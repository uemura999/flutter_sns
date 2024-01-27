//flutter
import 'package:flutter/material.dart';
//packages
import 'package:cloud_firestore/cloud_firestore.dart';
//constants
import 'package:udemy_flutter_sns/constants/bools.dart';
//components
import 'package:udemy_flutter_sns/details/card_container.dart';
import 'package:udemy_flutter_sns/details/post_like_button.dart';
import 'package:udemy_flutter_sns/details/user_image.dart';
import 'package:udemy_flutter_sns/domain/firestore_user/firestore_user.dart';
//domain
import 'package:udemy_flutter_sns/domain/post/post.dart';
//models
import 'package:udemy_flutter_sns/models/comments_model.dart';
import 'package:udemy_flutter_sns/models/main_model.dart';
import 'package:udemy_flutter_sns/models/posts_model.dart';

class PostCard extends StatelessWidget {
  PostCard({
    Key? key,
    required this.onTap,
    required this.post,
    required this.postDoc,
    required this.mainModel,
    required this.postsModel,
    required this.commentsModel,
  }) : super(key: key);
  final void Function() onTap;
  final Post post;
  final DocumentSnapshot<Map<String, dynamic>> postDoc;
  final MainModel mainModel;
  final PostsModel postsModel;
  final CommentsModel commentsModel;
  @override
  Widget build(BuildContext context) {
    final FirestoreUser firestoreUser = mainModel.firestoreUser;
    final bool isMyPost = post.uid == firestoreUser.uid;
    return isValidUser(muteUids: mainModel.muteUids, doc: postDoc) &&
            isValidPost(mutePostIds: mainModel.mutePostIds, post: post)
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
                      userImageURL: isMyPost
                          ? firestoreUser.userImageURL
                          : post.userImageURL),
                  Text(
                    isMyPost ? firestoreUser.userName : post.userName,
                    style: const TextStyle(
                        fontSize: 20.0, overflow: TextOverflow.ellipsis),
                  )
                ],
              ),
              Text(
                post.text,
                style: const TextStyle(fontSize: 20.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                      onTap: () async =>
                          await commentsModel.onCommentButtonPressed(
                              context: context,
                              post: post,
                              mainModel: mainModel,
                              postDoc: postDoc),
                      child: const Icon(Icons.comment)),
                  PostLikeButton(
                      mainModel: mainModel,
                      post: post,
                      postsModel: postsModel,
                      postDoc: postDoc),
                ],
              ),
            ]),
          )
        : const SizedBox.shrink();
  }
}
