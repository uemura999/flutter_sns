import 'package:flutter/material.dart';
//packages
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
//constants
import 'package:udemy_flutter_sns/constants/enums.dart';
import 'package:udemy_flutter_sns/constants/routes.dart' as routes;
import 'package:udemy_flutter_sns/constants/strings.dart';
import 'package:udemy_flutter_sns/constants/voids.dart' as voids;
//models
import 'package:udemy_flutter_sns/models/main_model.dart';
//domain
import 'package:udemy_flutter_sns/domain/firestore_user/firestore_user.dart';
import 'package:udemy_flutter_sns/domain/following_token/following_token.dart';
import 'package:udemy_flutter_sns/domain/follower/follower.dart';

final passiveUserProfileProvider =
    ChangeNotifierProvider((ref) => PassiveUserProfileModel());

class PassiveUserProfileModel extends ChangeNotifier {
  //ユーザーの投稿を取得する
  List<DocumentSnapshot<Map<String, dynamic>>> postDocs = [];
  SortState sortState = SortState.byNewestFirst;
  RefreshController refreshController = RefreshController();
  String indexUid = '';
  Query<Map<String, dynamic>> returnQuery(
      {required DocumentSnapshot<Map<String, dynamic>> passiveUserDoc}) {
    final query = passiveUserDoc.reference.collection('posts');
    switch (sortState) {
      case SortState.byLikeCount:
        return query.orderBy('likeCount', descending: true);
      case SortState.byNewestFirst:
        return query.orderBy('createdAt', descending: true);
      case SortState.byOldestFirst:
        return query.orderBy('createdAt', descending: false);
    }
  }

  Future<void> onUserIconPressed({
    required BuildContext context,
    required MainModel mainModel,
    required DocumentSnapshot<Map<String, dynamic>> passiveUserDoc,
  }) async {
    refreshController = RefreshController();
    final String passiveUid = passiveUserDoc.id;
    if (indexUid != passiveUid) {
      postDocs = [];
      await onReload(
          muteUids: mainModel.muteUids,
          mutePostIds: mainModel.mutePostIds,
          passiveUserDoc: passiveUserDoc);
    }
    indexUid = passiveUid;
    routes.toPassiveUserProfilePage(
        context: context, mainModel: mainModel, passiveUserDoc: passiveUserDoc);
    notifyListeners();
  }

  Future<void> onRefresh(
      {required List<String> muteUids,
      required List<String> mutePostIds,
      required DocumentSnapshot<Map<String, dynamic>> passiveUserDoc}) async {
    refreshController.refreshCompleted();
    await voids.processNewDocs(
        muteUids: muteUids,
        mutePostIds: mutePostIds,
        docs: postDocs,
        query: returnQuery(passiveUserDoc: passiveUserDoc));
    notifyListeners();
  }

  Future<void> onReload(
      {required List<String> muteUids,
      required List<String> mutePostIds,
      required DocumentSnapshot<Map<String, dynamic>> passiveUserDoc}) async {
    await voids.processBasicDocs(
        muteUids: muteUids,
        mutePostIds: mutePostIds,
        docs: postDocs,
        query: returnQuery(passiveUserDoc: passiveUserDoc));
    notifyListeners();
  }

  Future<void> onLoading(
      {required List<String> muteUids,
      required List<String> mutePostIds,
      required DocumentSnapshot<Map<String, dynamic>> passiveUserDoc}) async {
    refreshController.loadComplete();
    await voids.processOldDocs(
        muteUids: muteUids,
        mutePostIds: mutePostIds,
        docs: postDocs,
        query: returnQuery(passiveUserDoc: passiveUserDoc));
    notifyListeners();
  }

  Future<void> follow(
      {required MainModel mainModel,
      required FirestoreUser passiveUser}) async {
    mainModel.followingUids.add(passiveUser.uid);
    final String tokenId = returnUuidV4();
    final Timestamp now = Timestamp.now();
    final FollowingToken followingToken = FollowingToken(
        createdAt: now,
        passiveUid: passiveUser.uid,
        tokenId: tokenId,
        tokenType: followingTokenTypeString);
    final FirestoreUser activeUser = mainModel.firestoreUser;
    final newActiveUser =
        activeUser.copyWith(followingCount: activeUser.followingCount + 1);
    mainModel.firestoreUser = newActiveUser;
    notifyListeners();
    //自分がフォローした印
    await FirebaseFirestore.instance
        .collection("users")
        .doc(activeUser.uid)
        .collection('tokens')
        .doc(tokenId)
        .set(followingToken.toJson());
    //受動的なユーザーがフォローされたdataを生成する
    final Follower follower = Follower(
      createdAt: now,
      followedUid: passiveUser.uid,
      followerUid: activeUser.uid,
    );
    await FirebaseFirestore.instance
        .collection("users")
        .doc(passiveUser.uid)
        .collection('followers')
        .doc(activeUser.uid)
        .set(follower.toJson());
  }

  Future<void> unFollow(
      {required MainModel mainModel,
      required FirestoreUser passiveUser}) async {
    mainModel.followingUids.remove(passiveUser.uid);

    //followしているTokenを取得
    final FirestoreUser activeUser = mainModel.firestoreUser;
    final newActiveUser = activeUser.copyWith(
        followingCount: activeUser.followingCount - 1); //危険な例
    mainModel.firestoreUser = newActiveUser;
    notifyListeners();
    //qshotというdataの塊の存在を取得
    final QuerySnapshot<Map<String, dynamic>> qshot = await FirebaseFirestore
        .instance
        .collection("users")
        .doc(activeUser.uid)
        .collection('tokens')
        .where('passiveUid', isEqualTo: passiveUser.uid)
        .get();
    //１個しか取得してないけど複数扱いになるので、docsという複数形にする
    final List<DocumentSnapshot<Map<String, dynamic>>> docs = qshot.docs;
    final DocumentSnapshot<Map<String, dynamic>> token = docs.first;
    await token.reference.delete();
    //受動的なユーザーがフォローされたdataを削除する
    await FirebaseFirestore.instance
        .collection("users")
        .doc(passiveUser.uid)
        .collection('followers')
        .doc(activeUser.uid)
        .delete();
  }

  void onMenuPressed(
      {required BuildContext context,
      required List<String> muteUids,
      required List<String> mutePostIds,
      required DocumentSnapshot<Map<String, dynamic>> passiveUserDoc}) {
    voids.showPopUp(
        context: context,
        builder: (BuildContext innerContext) {
          return CupertinoActionSheet(
            message: const Text(selectTitle),
            actions: [
              CupertinoActionSheetAction(
                  onPressed: () async {
                    if (sortState != SortState.byLikeCount) {
                      sortState = SortState.byLikeCount;
                      await onReload(
                          muteUids: muteUids,
                          mutePostIds: mutePostIds,
                          passiveUserDoc: passiveUserDoc);
                    }
                    Navigator.pop(innerContext);
                  },
                  isDestructiveAction: true,
                  child: const Text(sortByLikeCountText)),
              CupertinoActionSheetAction(
                  onPressed: () async {
                    if (sortState != SortState.byNewestFirst) {
                      sortState = SortState.byNewestFirst;
                      await onReload(
                          muteUids: muteUids,
                          mutePostIds: mutePostIds,
                          passiveUserDoc: passiveUserDoc);
                    }
                    Navigator.pop(innerContext);
                  },
                  isDestructiveAction: true,
                  child: const Text(sortByNewText)),
              CupertinoActionSheetAction(
                  onPressed: () async {
                    if (sortState != SortState.byOldestFirst) {
                      sortState = SortState.byOldestFirst;
                      await onReload(
                          muteUids: muteUids,
                          mutePostIds: mutePostIds,
                          passiveUserDoc: passiveUserDoc);
                    }
                    Navigator.pop(innerContext);
                  },
                  isDestructiveAction: true,
                  child: const Text(sortByOldText)),
              CupertinoActionSheetAction(
                  onPressed: () => Navigator.pop(innerContext),
                  child: const Text(backText)),
            ],
          );
        });
  }
}
