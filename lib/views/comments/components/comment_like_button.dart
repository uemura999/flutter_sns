//flutter
import 'package:flutter/material.dart';
//packages
import 'package:cloud_firestore/cloud_firestore.dart';
//models
import 'package:udemy_flutter_sns/models/comments_model.dart';
import 'package:udemy_flutter_sns/models/main_model.dart';
//domain
import 'package:udemy_flutter_sns/domain/post/post.dart';
import 'package:udemy_flutter_sns/domain/comment/comment.dart';

class CommentLikeButton extends StatelessWidget {
  CommentLikeButton({
    Key? key,
    required this.mainModel,
    required this.post,
    required this.comment,
    required this.commentsModel,
    required this.commentDoc,
  }) : super(key: key);
  final MainModel mainModel;
  final Post post;
  final Comment comment;
  final CommentsModel commentsModel;
  final DocumentSnapshot<Map<String, dynamic>> commentDoc;
  @override
  Widget build(BuildContext context) {
    final bool isLike =
        mainModel.likeCommentIds.contains(comment.postCommentId);
    final int likeCount = comment.likeCount;
    final int plusOneCount = likeCount + 1;
    return Row(
      children: [
        Container(
          child: isLike
              ? InkWell(
                  onTap: () async => await commentsModel.unlike(
                      comment: comment,
                      mainModel: mainModel,
                      post: post,
                      commentDoc: commentDoc),
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ))
              : InkWell(
                  onTap: () async => await commentsModel.like(
                      comment: comment,
                      mainModel: mainModel,
                      post: post,
                      commentDoc: commentDoc),
                  child: const Icon(Icons.favorite_border)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(isLike ? plusOneCount.toString() : likeCount.toString()),
        )
      ],
    );
  }
}
