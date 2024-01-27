//flutter
import 'package:flutter/material.dart';
//packages
import 'package:cloud_firestore/cloud_firestore.dart';
//constants
import 'package:udemy_flutter_sns/constants/bools.dart';
import 'package:udemy_flutter_sns/constants/routes.dart' as routes;
//components
import 'package:udemy_flutter_sns/details/card_container.dart';
import 'package:udemy_flutter_sns/details/user_image.dart';
import 'package:udemy_flutter_sns/views/comments/components/comment_like_button.dart';
//domain
import 'package:udemy_flutter_sns/domain/firestore_user/firestore_user.dart';
import 'package:udemy_flutter_sns/domain/comment/comment.dart';
import 'package:udemy_flutter_sns/domain/post/post.dart';
//models
import 'package:udemy_flutter_sns/models/comments_model.dart';
import 'package:udemy_flutter_sns/models/main_model.dart';

class CommentCard extends StatelessWidget {
  CommentCard({
    Key? key,
    required this.onTap,
    required this.mainModel,
    required this.post,
    required this.comment,
    required this.commentsModel,
    required this.commentDoc,
  }) : super(key: key);
  final void Function() onTap;
  final MainModel mainModel;
  final Post post;
  final Comment comment;
  final CommentsModel commentsModel;
  final DocumentSnapshot<Map<String, dynamic>> commentDoc;
  @override
  Widget build(BuildContext context) {
    //mainModelのfirestoreUserは更新されている。updateされた瞬間
    final FirestoreUser firestoreUser = mainModel.firestoreUser;
    final bool isMyComment = comment.uid == firestoreUser.uid;
    return isValidUser(muteUids: mainModel.muteUids, doc: commentDoc) &&
            isValidComment(
                muteCommentIds: mainModel.muteCommentIds, comment: comment)
        ? CardContainer(
            borderColor: Colors.green,
            onTap: onTap,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  UserImage(
                      length: 32.0,
                      userImageURL: isMyComment
                          ? firestoreUser.userImageURL
                          : comment.userImageURL),
                  Text(
                    isMyComment ? firestoreUser.userName : comment.userName,
                    style: const TextStyle(
                        fontSize: 20.0, overflow: TextOverflow.ellipsis),
                  )
                ],
              ),
              Text(
                comment.commentString,
                style: const TextStyle(fontSize: 20.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                      onTap: () => routes.toRepliesPage(
                          context: context,
                          mainModel: mainModel,
                          comment: comment,
                          commentDoc: commentDoc),
                      child: const Icon(Icons.reply)),
                  CommentLikeButton(
                      mainModel: mainModel,
                      post: post,
                      comment: comment,
                      commentsModel: commentsModel,
                      commentDoc: commentDoc),
                ],
              ),
            ]),
          )
        : const SizedBox.shrink();
  }
}
