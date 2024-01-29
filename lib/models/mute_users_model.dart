//flutter
import 'package:flutter/material.dart';
//packages
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
//constants
import 'package:udemy_flutter_sns/constants/enums.dart';
import 'package:udemy_flutter_sns/constants/ints.dart';
import 'package:udemy_flutter_sns/constants/others.dart';
import 'package:udemy_flutter_sns/constants/strings.dart';
//domain
import 'package:udemy_flutter_sns/domain/mute_user_token/mute_user_token.dart';
import 'package:udemy_flutter_sns/domain/user_mute/user_mute.dart';
//models
import 'package:udemy_flutter_sns/models/main_model.dart';

final muteUsersProvider = ChangeNotifierProvider((ref) => MuteUsersModel());

class MuteUsersModel extends ChangeNotifier {
  bool showMuteUsers = false;
  List<DocumentSnapshot<Map<String, dynamic>>> muteUserDocs = [];
  List<String> muteUids = [];
  final RefreshController refreshController = RefreshController();
  //新しくミュートするユーザー
  List<MuteUserToken> newMuteUserTokens = [];
  //uidがmuteUidsに含まれるユーザーを取得
  //10件以下の場合はwhereInを使う
  //.whereと.createdAtの2つ以上のフィールドで絞っている
  //indexをfirestoreで作成する必要がある
  Query<Map<String, dynamic>> returnQuery(
          {required List<String> max10MuteUids}) =>
      FirebaseFirestore.instance
          .collection('users')
          .where('uid', whereIn: max10MuteUids)
          .orderBy('createdAt', descending: true);

  Future<void> getMuteUsers({required MainModel mainModel}) async {
    showMuteUsers = true;
    muteUids = mainModel.muteUids;
    await process();
    notifyListeners();
  }

  Future<void> onRefresh() async {
    refreshController.refreshCompleted();
    await processNewMuteUsers();
    notifyListeners();
  }

  Future<void> onReload() async {
    await process();
    notifyListeners();
  }

  Future<void> onLoading() async {
    refreshController.loadComplete();
    await process();
    notifyListeners();
  }

  Future<void> processNewMuteUsers() async {
    //newMuteUserTokensをfor文で回してpassiveUidだけをまとめている
    final List<String> newMuteUids =
        newMuteUserTokens.map((e) => e.passiveUid).toList();
    //新しくミュートしたユーザーが１０人以上の場合
    final List<String> max10MuteUids = newMuteUids.length > 10
        ? newMuteUids.sublist(0, tenCount) //１０より大きければ１０個まで取り出す
        : newMuteUids; //10より小さければ全て取り出す
    if (max10MuteUids.isNotEmpty) {
      final qshot = await returnQuery(max10MuteUids: max10MuteUids).get();
      final reversed = qshot.docs.reversed.toList();
      for (final muteUserDoc in reversed) {
        muteUserDocs.insert(0, muteUserDoc);
        //muteUserDocsに加えたということは、もう新しくない。
        //新しいやつから省く
        //tokenに含まれるpassiveUidがmuteUserDoc.idと一致するものを取り出す
        final deleteNewMuteUserToken = newMuteUserTokens
            .where((element) => element.passiveUid == muteUserDoc.id)
            .toList()
            .first;
        newMuteUserTokens.remove(deleteNewMuteUserToken);
      }
    }
    notifyListeners();
  }

  Future<void> process() async {
    if (muteUids.length > muteUserDocs.length) {
      final int userDocsLength = muteUserDocs.length;
      //max10MuteUidsには10個までしかUidを入れない。
      //なぜならwhereInで検索をかけるから
      //sublistは第一引数に含まれ、第二引数に含まれないlistの分割
      List<String> max10MuteUids = (muteUids.length - muteUserDocs.length) > 10
          ? muteUids.sublist(userDocsLength, userDocsLength + tenCount)
          : muteUids.sublist(userDocsLength, muteUids.length);
      if (max10MuteUids.isNotEmpty) {
        final qshot = await returnQuery(max10MuteUids: max10MuteUids).get();
        for (final userDoc in qshot.docs) {
          muteUserDocs.add(userDoc);
        }
      }
    }
    notifyListeners();
  }

  Future<void> muteUser(
      {required MainModel mainModel,
      required String passiveUid,
      //docsにはpostDocs, commentDocsが含まれる
      required List<DocumentSnapshot<Map<String, dynamic>>> docs}) async {
    final String tokenId = returnUuidV4();
    final currentUserDoc = mainModel.currentUserDoc;
    final String activeUid = currentUserDoc.id;
    final passiveUserDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(passiveUid)
        .get();

    final Timestamp now = Timestamp.now();
    final MuteUserToken muteUserToken = MuteUserToken(
        activeUid: activeUid,
        createdAt: now,
        passiveUid: passiveUid,
        tokenId: tokenId,
        tokenType: muteUserTokenTypeString);
    //新しくミュートしたユーザー
    newMuteUserTokens.add(muteUserToken);
    mainModel.muteUserTokens.add(muteUserToken);
    mainModel.muteUids.add(passiveUid);
    //muteしたいユーザーが作成したコンテンツを除外する
    docs.removeWhere((element) => element.data()!['uid'] == passiveUid);
    notifyListeners();

    //自分がミュートしたことの印
    //currentUserDoc.reference.collection('tokens').doc(tokenId)
    await userDocToTokenDocRef(userDoc: currentUserDoc, tokenId: tokenId)
        .set(muteUserToken.toJson());

    //ユーザーがミュートされたことの印
    final UserMute userMute = UserMute(
        activeUid: activeUid,
        createdAt: now,
        passiveUid: passiveUid,
        passiveUserRef: passiveUserDoc.reference);
    await passiveUserDoc.reference
        .collection('userMutes')
        .doc(activeUid)
        .set(userMute.toJson());
  }

  void showMuteUserDialog(
      {required BuildContext context,
      required String passiveUid,
      required MainModel mainModel,
      //docsにはpostDocs, commentDocsが含まれる
      required List<DocumentSnapshot<Map<String, dynamic>>> docs}) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext innerContext) => CupertinoAlertDialog(
                content: const Text(muteUserAlertMsg),
                actions: <CupertinoDialogAction>[
                  CupertinoDialogAction(
                    /// This parameter indicates this action is the default,
                    /// and turns the action's text to bold text.
                    isDefaultAction: true,
                    onPressed: () => Navigator.pop(innerContext),
                    child: const Text(noText),
                  ),
                  CupertinoDialogAction(
                    /// This parameter indicates this action is the default,
                    /// and turns the action's text to bold text.
                    isDefaultAction: true,
                    onPressed: () async {
                      await muteUser(
                          mainModel: mainModel,
                          passiveUid: passiveUid,
                          docs: docs);
                      // ignore: use_build_context_synchronously
                      Navigator.pop(innerContext);
                    },
                    child: const Text(yesText),
                  ),
                ]));
  }

  Future<void> unMuteUser({
    required MainModel mainModel,
    required String passiveUid,
    required DocumentSnapshot<Map<String, dynamic>> muteUserDoc,
  }) async {
    //muteUsersModel側の処理
    muteUserDocs.remove(muteUserDoc);
    mainModel.muteUids.remove(passiveUid);
    final currentUserDoc = mainModel.currentUserDoc;
    final String activeUid = currentUserDoc.id;
    final deleteMuteUserToken = mainModel.muteUserTokens
        .where((element) => element.passiveUid == passiveUid)
        .toList()
        .first;
    if (newMuteUserTokens.contains(deleteMuteUserToken)) {
      //もし削除するミュートユーザーが新しくミュートしたユーザーなら、
      newMuteUserTokens.remove(deleteMuteUserToken);
    }
    mainModel.muteUserTokens.remove(deleteMuteUserToken);
    notifyListeners();

    //自分がミュートした印を削除
    await userDocToTokenDocRef(
            userDoc: currentUserDoc, tokenId: deleteMuteUserToken.tokenId)
        .delete();

    //ユーザーがミュートされた印を削除
    final DocumentReference<Map<String, dynamic>> muteUserRef =
        FirebaseFirestore.instance.collection('users').doc(passiveUid);
    await muteUserRef.collection('userMutes').doc(activeUid).delete();
  }

  void showUnMuteUserDialog({
    required BuildContext context,
    required String passiveUid,
    required MainModel mainModel,
    required DocumentSnapshot<Map<String, dynamic>> muteUserDoc,
  }) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext innerContext) => CupertinoAlertDialog(
                content: const Text(unMuteUserAlertMsg),
                actions: <CupertinoDialogAction>[
                  CupertinoDialogAction(
                    /// This parameter indicates this action is the default,
                    /// and turns the action's text to bold text.
                    isDefaultAction: true,
                    onPressed: () => Navigator.pop(innerContext),
                    child: const Text(noText),
                  ),
                  CupertinoDialogAction(
                    /// This parameter indicates this action is the default,
                    /// and turns the action's text to bold text.
                    isDefaultAction: true,
                    onPressed: () async {
                      await unMuteUser(
                          mainModel: mainModel,
                          passiveUid: passiveUid,
                          muteUserDoc: muteUserDoc);
                      // ignore: use_build_context_synchronously
                      Navigator.pop(innerContext);
                    },
                    child: const Text(yesText),
                  ),
                ]));
  }
}
