//flutter
import 'package:flutter/material.dart';
//packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udemy_flutter_sns/constants/enum.dart';
//constants
import 'package:udemy_flutter_sns/constants/others.dart';
import 'package:udemy_flutter_sns/constants/voids.dart' as voids;
import 'package:udemy_flutter_sns/constants/strings.dart';
//domain
import 'package:udemy_flutter_sns/domain/firestore_user/firestore_user.dart';
import 'package:udemy_flutter_sns/domain/mute_user_token/mute_user_token.dart';
import 'package:udemy_flutter_sns/domain/post/post.dart';
import 'package:udemy_flutter_sns/domain/user_mute/user_mute.dart';
import 'package:udemy_flutter_sns/models/mute_users_model.dart';

final adminProvider = ChangeNotifierProvider((ref) => AdminModel());

class AdminModel extends ChangeNotifier {
  Future<void> admin(
      {required DocumentSnapshot<Map<String, dynamic>> currentUserDoc,
      required FirestoreUser firestoreUser,
      required MuteUsersModel muteUsersModel}) async {
    // //管理者にだけ出来る処理
    // //ユーザーのemailの削除
    // WriteBatch batch = FirebaseFirestore.instance.batch();
    // final usersQshot =
    //     await FirebaseFirestore.instance.collection('users').get();
    // for (final user in usersQshot.docs) {
    //   batch.update(user.reference, {'email': FieldValue.delete()});
    // }

    // //postにuserNameの追加
    // final postsQshot = await currentUserDoc.reference.collection('posts').get();
    // for (final post in postsQshot.docs) {
    //   batch.update(post.reference, {
    //     'userName': firestoreUser.userName,
    //     'userImageURL': firestoreUser.userImageURL
    //   });
    // }
    // await batch.commit();

//commentCountの追加
    // WriteBatch writeBatch = FirebaseFirestore.instance.batch();
    // final postsQshot = await currentUserDoc.reference.collection('posts').get();
    // for (final post in postsQshot.docs) {
    //   writeBatch.update(post.reference, {'commentCount': 0});
    // }
    // await writeBatch.commit();

//コレクショングループによる横断的な削除
    // WriteBatch writeBatch = FirebaseFirestore.instance.batch();
    // final commentsQshot =
    //     await FirebaseFirestore.instance.collectionGroup('postComments').get();
    // for (final commentDoc in commentsQshot.docs) {
    //   writeBatch.delete(commentDoc.reference);
    // }
    // await writeBatch.commit();

    // final WriteBatch writeBatch = FirebaseFirestore.instance.batch();
    // //postの削除.limit(100)
    // // final postsQshot = await currentUserDoc.reference
    // //     .collection('posts')
    // //     .orderBy('createdAt', descending: false)
    // //     .limit(100)
    // //     .get();

    // // for (final postDoc in postsQshot.docs) {
    // //   writeBatch.delete(postDoc.reference);
    // // }
    // await writeBatch.commit();
    // final usersQshot =
    //     await FirebaseFirestore.instance.collection('users').get();
    // final WriteBatch writeBatch = FirebaseFirestore.instance.batch();
    // for (final user in usersQshot.docs) {
    //   writeBatch.update(user.reference, {
    //     "muteCount": 0,
    //   });
    // }
    // await writeBatch.commit();

    final WriteBatch writeBatch = FirebaseFirestore.instance.batch();
    // for (int i = 0; i < 35; i++) {
    //   final String passiveUid = 'newMuteUser${i.toString()}';
    //   final Timestamp now = Timestamp.now();
    //   final String tokenId = returnUuidV4();
    //   final String activeUid = currentUserDoc.id;
    //   //ユーザーを作成する
    //   final FirestoreUser firestoreUser = FirestoreUser(
    //       createdAt: now,
    //       followerCount: 0,
    //       followingCount: 0,
    //       isAdmin: false,
    //       muteCount: 0,
    //       updatedAt: now,
    //       userName: passiveUid,
    //       userImageURL: '',
    //       uid: passiveUid);
    //   final ref =
    //       FirebaseFirestore.instance.collection('users').doc(passiveUid);
    //   writeBatch.set(ref, firestoreUser.toJson());
    //   //今回はフロントだけの処理を擬似的に実装したいのでDBには保存しない
    //   //ミュートした印を作成する
    //   final MuteUserToken muteUserToken = MuteUserToken(
    //       activeUid: activeUid,
    //       createdAt: now,
    //       passiveUid: passiveUid,
    //       tokenId: tokenId,
    //       tokenType: muteUserTokenTypeString);
    //   //フロントだけの処理
    //   muteUsersModel.newMuteUserTokens.add(muteUserToken);
    //   //Timestampwをずらす
    //   await Future.delayed(const Duration(milliseconds: 300));
    // }

// muteCountの追加
    // final commentsQshot =
    //     await FirebaseFirestore.instance.collectionGroup('postComments').get();
    // for (final commentDoc in commentsQshot.docs) {
    //   writeBatch.update(commentDoc.reference, {'muteCount': 0});
    // }

    //muteCountの追加
    // final postsQshot =
    //     await FirebaseFirestore.instance.collectionGroup('posts').get();
    // for (final postDoc in postsQshot.docs) {
    //   writeBatch.update(postDoc.reference, {'muteCount': 0});
    // }

    // muteCountの追加
    // final repliesQshot = await FirebaseFirestore.instance
    //     .collectionGroup('postCommentReplies')
    //     .get();
    // for (final replyDoc in repliesQshot.docs) {
    //   writeBatch.update(replyDoc.reference, {'muteCount': 0});
    // }

    await writeBatch.commit();
    await voids.showFluttertoast(msg: '処理が完了しました');
  }
}
