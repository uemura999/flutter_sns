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
import 'package:udemy_flutter_sns/domain/mute_post_token/mute_post_token.dart';
import 'package:udemy_flutter_sns/domain/post_mute/post_mute.dart';
//models
import 'package:udemy_flutter_sns/models/main_model.dart';

final mutePostsProvider = ChangeNotifierProvider((ref) => MutePostsModel());

class MutePostsModel extends ChangeNotifier {
  bool showMutePosts = false;
  List<String> mutePostIds = [];
  List<DocumentSnapshot<Map<String, dynamic>>> mutePostDocs = [];
  final RefreshController refreshController = RefreshController();
  //新しくミュートする投稿のtoken
  List<MutePostToken> newMutePostTokens = [];
  //ミュートしているコメントのDocumentを取得するクエリ
  Query<Map<String, dynamic>> returnQuery(
          {required List<String> max10MutePostIds}) =>
      FirebaseFirestore.instance
          .collectionGroup('posts')
          .where('postId', whereIn: max10MutePostIds);
  Future<void> getMutePosts({required MainModel mainModel}) async {
    showMutePosts = true;
    mutePostIds = mainModel.mutePostIds;
    await process();
    notifyListeners();
  }

  Future<void> onRefresh() async {
    refreshController.refreshCompleted();
    await processNewPosts();
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

  Future<void> processNewPosts() async {
    //newMutePostTokensをfor文で回してpostIdをまとめる
    final List<String> newMutePostIds =
        newMutePostTokens.map((e) => e.postId).toList();

    //新しくミュートしたポストが10以上の場合
    final List<String> max10MutePostIds = newMutePostIds.length > 10
        ? newMutePostIds.sublist(0, tenCount) //１０より大きければ１０個まで取り出す
        : newMutePostIds; //10より小さければ全て取り出す
    if (max10MutePostIds.isNotEmpty) {
      final qshot = await returnQuery(max10MutePostIds: max10MutePostIds).get();
      final reversed = qshot.docs.reversed.toList();
      for (final mutePostDoc in reversed) {
        mutePostDocs.insert(0, mutePostDoc);
        //mutePostDocsに加えたということは、もう新しくない。新しいものから省く
        //tokenに含まれるpostIdがpostIdと一致するものを取り出す
        final deleteNewMutePostToken = newMutePostTokens
            .where((element) => element.postId == mutePostDoc.id)
            .toList()
            .first;
        newMutePostTokens.remove(deleteNewMutePostToken);
      }
    }
    notifyListeners();
  }

  Future<void> process() async {
    if (mutePostIds.length > mutePostDocs.length) {
      final int mutePostDocsLength = mutePostDocs.length;
      //max10MutePostIdsには10個までしかpostIdが入らない
      //なぜならwhereInで検索をかけるから
      //subListは第一引数に含まれ、第二引数に含まれないlistの分割
      List<String> max10MutePostIds =
          (mutePostIds.length - mutePostDocsLength) > 10
              ? mutePostIds.sublist(
                  mutePostDocsLength, mutePostDocsLength + tenCount)
              : mutePostIds.sublist(mutePostDocsLength, mutePostIds.length);
      if (max10MutePostIds.isNotEmpty) {
        final qshot =
            await returnQuery(max10MutePostIds: max10MutePostIds).get();
        for (final postDoc in qshot.docs) {
          mutePostDocs.add(postDoc);
        }
      }
    }
    notifyListeners();
  }

  Future<void> mutePost(
      {required MainModel mainModel,
      required DocumentSnapshot<Map<String, dynamic>> postDoc,
      required List<DocumentSnapshot<Map<String, dynamic>>> postDocs}) async {
    final String tokenId = returnUuidV4();
    final currentUserDoc = mainModel.currentUserDoc;
    final String postId = postDoc.id;
    final postRef = postDoc.reference;
    final String activeUid = currentUserDoc.id;
    final Timestamp now = Timestamp.now();
    final MutePostToken mutePostToken = MutePostToken(
        activeUid: activeUid,
        createdAt: now,
        postId: postId,
        postRef: postRef,
        tokenId: tokenId,
        tokenType: mutePostTokenTypeString);
    //新しくミュートした投稿のtokenをnewMutePostTokensに追加
    newMutePostTokens.add(mutePostToken);
    mainModel.mutePostTokens.add(mutePostToken);
    mainModel.mutePostIds.add(postId);
    //muteしたい投稿を除外する
    postDocs.remove(postDoc);
    notifyListeners();
    //自分がミュートしたことの印
    await currentUserDocToTokenDocRef(
            currentUserDoc: currentUserDoc, tokenId: tokenId)
        .set(mutePostToken.toJson());

    //投稿がミュートされたことの印
    final PostMute postMute = PostMute(
        activeUid: activeUid, createdAt: now, postId: postId, postRef: postRef);
    await postDoc.reference
        .collection('postMutes')
        .doc(activeUid)
        .set(postMute.toJson());
  }

  void showMutePostDialog({
    required BuildContext context,
    required MainModel mainModel,
    required DocumentSnapshot<Map<String, dynamic>> postDoc,
    required List<DocumentSnapshot<Map<String, dynamic>>> postDocs,
  }) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext innerContext) => CupertinoAlertDialog(
                content: const Text(mutePostAlertMsg),
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
                      await mutePost(
                          mainModel: mainModel,
                          postDoc: postDoc,
                          postDocs: postDocs);
                      // ignore: use_build_context_synchronously
                      Navigator.pop(innerContext);
                    },
                    child: const Text(yesText),
                  ),
                ]));
  }

  Future<void> unMutePost(
      {required MainModel mainModel,
      required DocumentSnapshot<Map<String, dynamic>> postDoc,
      required List<DocumentSnapshot<Map<String, dynamic>>> postDocs}) async {
    //MutePostsModel側の処理
    final String postId = postDoc.id;
    mutePostDocs.remove(postDoc);
    mainModel.mutePostIds.remove(postId);
    final currentUserDoc = mainModel.currentUserDoc;
    final String activeUid = currentUserDoc.id;
    final MutePostToken deleteMutePostToken = mainModel.mutePostTokens
        .where((element) => element.postId == postId)
        .toList()
        .first;
    if (newMutePostTokens.contains(deleteMutePostToken)) {
      //newMutePostTokensに含まれている場合
      newMutePostTokens.remove(deleteMutePostToken);
    }
    mainModel.mutePostTokens.remove(deleteMutePostToken);
    notifyListeners();

    //自分がミュートしたことの印を削除
    await currentUserDocToTokenDocRef(
            currentUserDoc: currentUserDoc,
            tokenId: deleteMutePostToken.tokenId)
        .delete();

    //投稿がミュートされたことの印を削除
    final DocumentReference<Map<String, dynamic>> postMuteDocRef =
        deleteMutePostToken.postRef;
    await postMuteDocRef.collection('postMutes').doc(activeUid).delete();
  }

  void showUnMuteCommentDialog(
      {required BuildContext context,
      required MainModel mainModel,
      required DocumentSnapshot<Map<String, dynamic>> postDoc,
      required List<DocumentSnapshot<Map<String, dynamic>>> postDocs}) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext innerContext) => CupertinoAlertDialog(
              content: const Text(unMutePostAlertMsg),
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
                    await unMutePost(
                        mainModel: mainModel,
                        postDoc: postDoc,
                        postDocs: postDocs);
                    // ignore: use_build_context_synchronously
                    Navigator.pop(innerContext);
                  },
                  child: const Text(yesText),
                ),
              ],
            ));
  }
}
