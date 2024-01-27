//flutter
import 'package:flutter/material.dart';
//packages
import 'package:cloud_firestore/cloud_firestore.dart';
//models
import 'package:udemy_flutter_sns/models/main_model.dart';
import 'package:udemy_flutter_sns/models/replies_model.dart';
//domain
import 'package:udemy_flutter_sns/domain/comment/comment.dart';
import 'package:udemy_flutter_sns/domain/reply/reply.dart';

class ReplyLikeButton extends StatelessWidget {
  ReplyLikeButton(
      {Key? key,
      required this.mainModel,
      required this.comment,
      required this.reply,
      required this.replyDoc,
      required this.repliesModel})
      : super(key: key);
  final MainModel mainModel;
  final Comment comment;
  final Reply reply;
  final DocumentSnapshot replyDoc;
  final RepliesModel repliesModel;
  @override
  Widget build(BuildContext context) {
    final bool isLike =
        mainModel.likeReplyIds.contains(reply.postCommentReplyId);
    final int likeCount = reply.likeCount;
    return Row(
      children: [
        Container(
          child: isLike
              ? InkWell(
                  onTap: () async => await repliesModel.unlike(
                      reply: reply,
                      mainModel: mainModel,
                      comment: comment,
                      replyDoc: replyDoc),
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ))
              : InkWell(
                  onTap: () async => await repliesModel.like(
                      reply: reply,
                      mainModel: mainModel,
                      comment: comment,
                      replyDoc: replyDoc),
                  child: const Icon(Icons.favorite_border)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(likeCount.toString()),
        )
      ],
    );
  }
}
