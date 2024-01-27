import 'package:flutter/material.dart';
//packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//constants
import 'package:udemy_flutter_sns/constants/enum.dart';
import 'package:udemy_flutter_sns/constants/strings.dart';
//models
import 'package:udemy_flutter_sns/models/main_model.dart';
//domain
import 'package:udemy_flutter_sns/domain/firestore_user/firestore_user.dart';
import 'package:udemy_flutter_sns/domain/following_token/following_token.dart';
import 'package:udemy_flutter_sns/domain/follower/follower.dart';

final passiveUserProfileProvider =
    ChangeNotifierProvider((ref) => PassiveUserProfileModel());

class PassiveUserProfileModel extends ChangeNotifier {
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
        .collection(usersFieldKey)
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
        .collection(usersFieldKey)
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
        .collection(usersFieldKey)
        .doc(passiveUser.uid)
        .collection('followers')
        .doc(activeUser.uid)
        .delete();
  }
}
