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
import 'package:udemy_flutter_sns/domain/comment_mute/comment_mute.dart';
import 'package:udemy_flutter_sns/domain/mute_comment_token/mute_comment_token.dart';
//models
import 'package:udemy_flutter_sns/models/main_model.dart';

final muteCommentsProvider =
    ChangeNotifierProvider((ref) => MuteCommentsModel());

class MuteCommentsModel extends ChangeNotifier {
  bool showMuteComments = false;
  List<String> mutePostCommentIds = [];
  List<DocumentSnapshot<Map<String, dynamic>>> muteCommentDocs = [];
  final RefreshController refreshController = RefreshController();
  //新しくミュートするコメントのtoken
  List<MuteCommentToken> newMuteCommentTokens = [];
  //ミュートしているコメントのDocumentを取得するクエリ
  Query<Map<String, dynamic>> returnQuery(
          {required List<String> max10MutePostCommentIds}) =>
      FirebaseFirestore.instance
          .collectionGroup('postComments')
          .where('postCommentId', whereIn: max10MutePostCommentIds);

  Future<void> getMuteComments({required MainModel mainModel}) async {
    showMuteComments = true;
    mutePostCommentIds = mainModel.muteCommentIds;
    await process();
    notifyListeners();
  }

  Future<void> onRefresh() async {
    refreshController.refreshCompleted();
    await processNewPostComments();
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

  Future<void> processNewPostComments() async {
    //newMutePostCommentTokensをfor文で回してpostCommentIdだけをまとめている
    final List<String> newmutePostCommentIds =
        newMuteCommentTokens.map((e) => e.postCommentId).toList();
    //新しくミュートしたコメントが１０人以上の場合
    final List<String> max10MutePostCommentIds =
        newmutePostCommentIds.length > 10
            ? newmutePostCommentIds.sublist(0, tenCount) //１０より大きければ１０個まで取り出す
            : newmutePostCommentIds; //10より小さければ全て取り出す
    if (max10MutePostCommentIds.isNotEmpty) {
      final qshot =
          await returnQuery(max10MutePostCommentIds: max10MutePostCommentIds)
              .get();
      final reversed = qshot.docs.reversed.toList();
      for (final mutePostCommentDoc in reversed) {
        muteCommentDocs.insert(0, mutePostCommentDoc);
        //mutePostCommentDocsに加えたということは、もう新しくない。
        //新しいやつから省く
        //tokenに含まれるpostCommentIdがpostCommentIdと一致するものを取り出す
        final deleteNewMutePostCommentToken = newMuteCommentTokens
            .where((element) => element.postCommentId == mutePostCommentDoc.id)
            .toList()
            .first;
        newMuteCommentTokens.remove(deleteNewMutePostCommentToken);
      }
    }
    notifyListeners();
  }

  Future<void> process() async {
    if (mutePostCommentIds.length > muteCommentDocs.length) {
      final int mutePostCommentDocsLength = muteCommentDocs.length;
      //max10MutePostCommentIdsには10個までしかpostCommentIdを入れない。
      //なぜならwhereInで検索をかけるから
      //sublistは第一引数に含まれ、第二引数に含まれないlistの分割
      List<String> max10MutePostCommentIds =
          (mutePostCommentIds.length - muteCommentDocs.length) > 10
              ? mutePostCommentIds.sublist(mutePostCommentDocsLength,
                  mutePostCommentDocsLength + tenCount)
              : mutePostCommentIds.sublist(
                  mutePostCommentDocsLength, mutePostCommentIds.length);
      if (max10MutePostCommentIds.isNotEmpty) {
        final qshot =
            await returnQuery(max10MutePostCommentIds: max10MutePostCommentIds)
                .get();
        for (final userDoc in qshot.docs) {
          muteCommentDocs.add(userDoc);
        }
      }
    }
    notifyListeners();
  }

  Future<void> muteComment(
      {required MainModel mainModel,
      required DocumentSnapshot<Map<String, dynamic>> commentDoc,
      required List<DocumentSnapshot<Map<String, dynamic>>>
          commentDocs}) async {
    final String tokenId = returnUuidV4();
    final currentUserDoc = mainModel.currentUserDoc;
    final String activeUid = currentUserDoc.id;
    final commentRef = commentDoc.reference;
    final String postCommentId = commentDoc.id;
    final Timestamp now = Timestamp.now();
    final MuteCommentToken muteCommentToken = MuteCommentToken(
        activeUid: activeUid,
        createdAt: now,
        postCommentId: postCommentId,
        postCommentRef: commentRef,
        tokenId: tokenId,
        tokenType: muteCommentTokenTypeString);
    //新しくミュートしたコメント
    newMuteCommentTokens.add(muteCommentToken);
    mainModel.muteCommentTokens.add(muteCommentToken);
    mainModel.muteCommentIds.add(postCommentId);
    //muteしたいコメントを除外する
    commentDocs.remove(commentDoc);
    notifyListeners();
    //自分がミュートしたことの印
    //currentUserDoc.reference.collection('tokens').doc(tokenId)
    await currentUserDocToTokenDocRef(
            currentUserDoc: currentUserDoc, tokenId: tokenId)
        .set(muteCommentToken.toJson());

    //コメントがミュートされたことの印
    final CommentMute commentMute = CommentMute(
      activeUid: activeUid,
      createdAt: now,
      postCommentId: postCommentId,
      postCommentRef: commentRef,
    );
    await commentDoc.reference
        .collection('postCommentMutes')
        .doc(activeUid)
        .set(commentMute.toJson());
  }

  void showMuteCommentDialog(
      {required BuildContext context,
      required MainModel mainModel,
      required DocumentSnapshot<Map<String, dynamic>> commentDoc,
      required List<DocumentSnapshot<Map<String, dynamic>>> commentDocs}) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext innerContext) => CupertinoAlertDialog(
                content: const Text(muteCommentAlertMsg),
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
                      await muteComment(
                          mainModel: mainModel,
                          commentDoc: commentDoc,
                          commentDocs: commentDocs);
                      // ignore: use_build_context_synchronously
                      Navigator.pop(innerContext);
                    },
                    child: const Text(yesText),
                  ),
                ]));
  }

  Future<void> unMuteComment(
      {required MainModel mainModel,
      required DocumentSnapshot<Map<String, dynamic>> commentDoc,
      required List<DocumentSnapshot<Map<String, dynamic>>>
          commentDocs}) async {
    //MuteCommentsModel側の処理
    final String commentId = commentDoc.id;
    muteCommentDocs.remove(commentDoc);
    mainModel.muteCommentIds.remove(commentId);
    final currentUserDoc = mainModel.currentUserDoc;
    final String activeUid = currentUserDoc.id;
    final MuteCommentToken deleteMuteCommentToken = mainModel.muteCommentTokens
        .where((element) => element.postCommentId == commentId)
        .toList()
        .first;
    if (newMuteCommentTokens.contains(deleteMuteCommentToken)) {
      //もし削除するミュートコメントが新しくミュートしたコメントなら、
      newMuteCommentTokens.remove(deleteMuteCommentToken);
    }
    mainModel.muteCommentTokens.remove(deleteMuteCommentToken);
    notifyListeners();

    //自分がミュートした印を削除
    await currentUserDocToTokenDocRef(
            currentUserDoc: currentUserDoc,
            tokenId: deleteMuteCommentToken.tokenId)
        .delete();

    //コメントがミュートされた印を削除
    final DocumentReference<Map<String, dynamic>> muteCommentRef =
        deleteMuteCommentToken.postCommentRef;
    await muteCommentRef.collection('postCommentMutes').doc(activeUid).delete();
  }

  void showUnMuteCommentDialog(
      {required BuildContext context,
      required MainModel mainModel,
      required DocumentSnapshot<Map<String, dynamic>> commentDoc,
      required List<DocumentSnapshot<Map<String, dynamic>>> commentDocs}) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext innerContext) => CupertinoAlertDialog(
                content: const Text(unMuteCommentAlertMsg),
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
                      await unMuteComment(
                          mainModel: mainModel,
                          commentDoc: commentDoc,
                          commentDocs: commentDocs);
                      // ignore: use_build_context_synchronously
                      Navigator.pop(innerContext);
                    },
                    child: const Text(yesText),
                  ),
                ]));
  }
}
