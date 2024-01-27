//flutter
import 'package:flutter/material.dart';
//packages
import 'package:cloud_firestore/cloud_firestore.dart';
//models
import 'package:udemy_flutter_sns/models/main_model.dart';
import 'package:udemy_flutter_sns/models/posts_model.dart';
//domain
import 'package:udemy_flutter_sns/domain/post/post.dart';

class PostLikeButton extends StatelessWidget {
  PostLikeButton(
      {Key? key,
      required this.mainModel,
      required this.post,
      required this.postsModel,
      required this.postDoc})
      : super(key: key);
  final MainModel mainModel;
  final Post post;
  final PostsModel postsModel;
  final DocumentSnapshot<Map<String, dynamic>> postDoc;
  @override
  Widget build(BuildContext context) {
    final bool isLike = mainModel.likePostIds.contains(post.postId);
    final int likeCount = post.likeCount;
    final int plusOneCount = likeCount + 1;
    return Row(
      children: [
        Container(
          child: isLike
              ? InkWell(
                  onTap: () async => await postsModel.unlike(
                      post: post, postDoc: postDoc, mainModel: mainModel),
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ))
              : InkWell(
                  onTap: () async => await postsModel.like(
                      post: post,
                      postRef: postDoc.reference,
                      postDoc: postDoc,
                      mainModel: mainModel),
                  child: const Icon(Icons.favorite_border)),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child:
                Text(isLike ? plusOneCount.toString() : likeCount.toString()))
      ],
    );
  }
}
