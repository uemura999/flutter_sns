//flutter
import 'package:flutter/material.dart';
//packages
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
//constants
import 'package:udemy_flutter_sns/constants/enum.dart';
import 'package:udemy_flutter_sns/constants/ints.dart';
import 'package:udemy_flutter_sns/constants/others.dart';
import 'package:udemy_flutter_sns/constants/strings.dart';
//domain
import 'package:udemy_flutter_sns/domain/mute_reply_token/mute_reply_token.dart';
import 'package:udemy_flutter_sns/domain/reply_mute/reply_mute.dart';

//models
import 'package:udemy_flutter_sns/models/main_model.dart';

final muteRepliesProvider = ChangeNotifierProvider((ref) => MuteRepliesModel());

class MuteRepliesModel extends ChangeNotifier {
  bool showMuteReplies = false;
  List<String> mutePostCommentReplyIds = [];
  List<DocumentSnapshot<Map<String, dynamic>>> muteReplyDocs = [];
  final RefreshController refreshController = RefreshController();
  //新しくミュートするリプライのtoken
  List<MuteReplyToken> newMuteReplyTokens = [];
  //ミュートしているリプライのDocumentを取得するクエリ
  Query<Map<String, dynamic>> returnQuery(
          {required List<String> max10MutePostCommentReplyIds}) =>
      FirebaseFirestore.instance
          .collectionGroup('postCommentReplies')
          .where('postCommentReplyId', whereIn: max10MutePostCommentReplyIds);

  Future<void> getMuteReplies({required MainModel mainModel}) async {
    showMuteReplies = true;
    mutePostCommentReplyIds = mainModel.muteReplyIds;
    await process();
    notifyListeners();
  }

  Future<void> onRefresh() async {
    refreshController.refreshCompleted();
    await processNewPostCommentReplies();
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

  Future<void> processNewPostCommentReplies() async {
    //newMutePostCommentReplyTokensをfor文で回してPostCommentReplyIdだけをまとめている
    final List<String> newMutePostCommentReplyIds =
        newMuteReplyTokens.map((e) => e.postCommentReplyId).toList();
    //新しくミュートしたリプライが１０人以上の場合
    final List<String> max10MutePostCommentReplyIds = newMutePostCommentReplyIds
                .length >
            10
        ? newMutePostCommentReplyIds.sublist(0, tenCount) //１０より大きければ１０個まで取り出す
        : newMutePostCommentReplyIds; //10より小さければ全て取り出す
    if (max10MutePostCommentReplyIds.isNotEmpty) {
      final qshot = await returnQuery(
              max10MutePostCommentReplyIds: max10MutePostCommentReplyIds)
          .get();
      final reversed = qshot.docs.reversed.toList();
      for (final mutePostCommentReplyDoc in reversed) {
        muteReplyDocs.insert(0, mutePostCommentReplyDoc);
        //mutePostCommentReplyDocsに加えたということは、もう新しくない。
        //新しいやつから省く
        //tokenに含まれるPostCommentReplyIdがPostCommentReplyIdと一致するものを取り出す
        final deleteNewMutePostCommentReplyToken = newMuteReplyTokens
            .where((element) =>
                element.postCommentReplyId == mutePostCommentReplyDoc.id)
            .toList()
            .first;
        newMuteReplyTokens.remove(deleteNewMutePostCommentReplyToken);
      }
    }
    notifyListeners();
  }

  Future<void> process() async {
    if (mutePostCommentReplyIds.length > muteReplyDocs.length) {
      final int mutePostCommentReplyDocsLength = muteReplyDocs.length;
      //max10MutePostCommentReplyIdsには10個までしかPostCommentReplyIdを入れない。
      //なぜならwhereInで検索をかけるから
      //sublistは第一引数に含まれ、第二引数に含まれないlistの分割
      List<String> max10MutePostCommentReplyIds =
          (mutePostCommentReplyIds.length - muteReplyDocs.length) > 10
              ? mutePostCommentReplyIds.sublist(mutePostCommentReplyDocsLength,
                  mutePostCommentReplyDocsLength + tenCount)
              : mutePostCommentReplyIds.sublist(mutePostCommentReplyDocsLength,
                  mutePostCommentReplyIds.length);
      if (max10MutePostCommentReplyIds.isNotEmpty) {
        final qshot = await returnQuery(
                max10MutePostCommentReplyIds: max10MutePostCommentReplyIds)
            .get();
        for (final userDoc in qshot.docs) {
          muteReplyDocs.add(userDoc);
        }
      }
    }
    notifyListeners();
  }

  Future<void> muteReply({
    required MainModel mainModel,
    required DocumentSnapshot replyDoc,
  }) async {
    final String tokenId = returnUuidV4();
    final currentUserDoc = mainModel.currentUserDoc;
    final String activeUid = currentUserDoc.id;
    final replyRef = replyDoc.reference;
    final String postCommentReplyId = replyDoc.id;
    final Timestamp now = Timestamp.now();
    final MuteReplyToken muteReplyToken = MuteReplyToken(
        activeUid: activeUid,
        createdAt: now,
        postCommentReplyId: postCommentReplyId,
        postCommentReplyRef: replyRef,
        tokenId: tokenId,
        tokenType: muteReplyTokenTypeString);
    //新しくミュートしたリプライ
    newMuteReplyTokens.add(muteReplyToken);
    mainModel.muteReplyTokens.add(muteReplyToken);
    mainModel.muteReplyIds.add(postCommentReplyId);
    //フロントエンドで非常時にしているのでreplyDocsから除外する必要はない
    notifyListeners();
    //自分がミュートしたことの印
    //currentUserDoc.reference.collection('tokens').doc(tokenId)
    await currentUserDocToTokenDocRef(
            currentUserDoc: currentUserDoc, tokenId: tokenId)
        .set(muteReplyToken.toJson());

    //リプライがミュートされたことの印
    final ReplyMute replyMute = ReplyMute(
        activeUid: activeUid,
        createdAt: now,
        postCommentReplyId: postCommentReplyId,
        postCommentReplyRef: replyRef);
    await replyDoc.reference
        .collection('postCommentReplyMutes')
        .doc(activeUid)
        .set(replyMute.toJson());
  }

  void showMuteRepliesDialog({
    required BuildContext context,
    required MainModel mainModel,
    required DocumentSnapshot replyDoc,
  }) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext innerContext) => CupertinoAlertDialog(
                content: const Text(muteReplyAlertMsg),
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
                      await muteReply(
                        mainModel: mainModel,
                        replyDoc: replyDoc,
                      );
                      // ignore: use_build_context_synchronously
                      Navigator.pop(innerContext);
                    },
                    child: const Text(yesText),
                  ),
                ]));
  }

  Future<void> unMuteReply({
    required MainModel mainModel,
    required DocumentSnapshot replyDoc,
  }) async {
    //MuteRepliesModel側の処理
    final String replyId = replyDoc.id;
    muteReplyDocs.remove(replyDoc);
    mainModel.muteCommentIds.remove(replyId);
    final currentUserDoc = mainModel.currentUserDoc;
    final String activeUid = currentUserDoc.id;
    final MuteReplyToken deleteMuteReplyToken = mainModel.muteReplyTokens
        .where((element) => element.postCommentReplyId == replyId)
        .toList()
        .first;
    if (newMuteReplyTokens.contains(deleteMuteReplyToken)) {
      //もし削除するミュートリプライが新しくミュートしたリプライなら、
      newMuteReplyTokens.remove(deleteMuteReplyToken);
    }
    mainModel.muteReplyTokens.remove(deleteMuteReplyToken);
    notifyListeners();

    //自分がミュートした印を削除
    await currentUserDocToTokenDocRef(
            currentUserDoc: currentUserDoc,
            tokenId: deleteMuteReplyToken.tokenId)
        .delete();

    //リプライがミュートされた印を削除
    final DocumentReference<Map<String, dynamic>> muteReplyRef =
        deleteMuteReplyToken.postCommentReplyRef;
    await muteReplyRef
        .collection('postCommentReplyMutes')
        .doc(activeUid)
        .delete();
  }

  void showUnMuteReplyDialog({
    required BuildContext context,
    required MainModel mainModel,
    required DocumentSnapshot replyDoc,
  }) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext innerContext) => CupertinoAlertDialog(
                content: const Text(unMuteReplyAlertMsg),
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
                      await unMuteReply(
                        mainModel: mainModel,
                        replyDoc: replyDoc,
                      );
                      // ignore: use_build_context_synchronously
                      Navigator.pop(innerContext);
                    },
                    child: const Text(yesText),
                  ),
                ]));
  }
}
