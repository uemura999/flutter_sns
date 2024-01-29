//flutter
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udemy_flutter_sns/constants/enums.dart';
//constants
import 'package:udemy_flutter_sns/constants/strings.dart';
//domain
import 'package:udemy_flutter_sns/domain/like_post_token/like_post_token.dart';
import 'package:udemy_flutter_sns/domain/post/post.dart';
import 'package:udemy_flutter_sns/domain/post_like/post_like.dart';
import 'package:udemy_flutter_sns/models/main_model.dart';

final postsProvider = ChangeNotifierProvider((ref) => PostsModel());

class PostsModel extends ChangeNotifier {
  Future<void> like(
      {required Post post,
      required DocumentReference<Map<String, dynamic>> postRef,
      required DocumentSnapshot<Map<String, dynamic>> postDoc,
      required MainModel mainModel}) async {
    //setting
    final String postId = post.postId;
    mainModel.likePostIds.add(postId);
    final currentUserDoc = mainModel.currentUserDoc;
    final String tokenId = returnUuidV4();
    final Timestamp now = Timestamp.now();
    final String activeUid = currentUserDoc.id;
    final String passiveUid = post.uid;
    //自分がいいねした印
    final LikePostToken likePostToken = LikePostToken(
        activeUid: activeUid,
        createdAt: now,
        passiveUid: passiveUid,
        postRef: postRef,
        postId: postId,
        tokenId: tokenId,
        tokenType: likePostTokenTypeString);
    mainModel.likePostTokens.add(likePostToken);
    notifyListeners();
    await currentUserDoc.reference
        .collection("tokens")
        .doc(tokenId)
        .set(likePostToken.toJson());

    //投稿がいいねされた印
    final PostLike postLike = PostLike(
        activeUid: activeUid,
        createdAt: now,
        passiveUid: passiveUid,
        postRef: postRef,
        postId: postId);
    //いいねする人が重複しないようにUidをdocumentIdとする
    await postDoc.reference
        .collection("postLikes")
        .doc(activeUid)
        .set(postLike.toJson());
  }

  Future<void> unlike(
      {required Post post,
      required DocumentSnapshot<Map<String, dynamic>> postDoc,
      required MainModel mainModel}) async {
    final String postId = post.postId;
    mainModel.likePostIds.remove(postId);
    final currentUserDoc = mainModel.currentUserDoc;
    final String activeUid = currentUserDoc.id;
    final deleteLikePostToken = mainModel.likePostTokens
        .where((element) => element.postId == postId)
        .toList()
        .first;
    mainModel.likePostTokens.remove(deleteLikePostToken);
    notifyListeners();
    //qshotというdataの塊の存在を取得
    // final QuerySnapshot<Map<String, dynamic>> qshot = await currentUserDoc
    //     .reference
    //     .collection('tokens')
    //     .where('postId', isEqualTo: postId)
    //     .get();
    //1個しか取得してないけど複数扱いになるので、docsという複数形にする
    // final List<DocumentSnapshot<Map<String, dynamic>>> docs = qshot.docs;
    // final DocumentSnapshot<Map<String, dynamic>> token = docs.first;
    //自分がいいねした印を削除
    await currentUserDoc.reference
        .collection('tokens')
        .doc(deleteLikePostToken.tokenId)
        .delete();

    //投稿がいいねされた印を削除
    await postDoc.reference.collection('postLikes').doc(activeUid).delete();
  }
}
