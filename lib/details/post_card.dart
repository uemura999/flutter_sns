//flutter
import 'package:flutter/material.dart';
//packages
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//constants
import 'package:udemy_flutter_sns/constants/bools.dart';
import 'package:udemy_flutter_sns/constants/voids.dart' as voids;
import 'package:udemy_flutter_sns/constants/strings.dart';
//components
import 'package:udemy_flutter_sns/details/card_container.dart';
import 'package:udemy_flutter_sns/details/post_like_button.dart';
import 'package:udemy_flutter_sns/details/user_image.dart';
//domain
import 'package:udemy_flutter_sns/domain/firestore_user/firestore_user.dart';
import 'package:udemy_flutter_sns/domain/post/post.dart';
//models
import 'package:udemy_flutter_sns/models/comments_model.dart';
import 'package:udemy_flutter_sns/models/main_model.dart';
import 'package:udemy_flutter_sns/models/mute_posts_model.dart';
import 'package:udemy_flutter_sns/models/mute_users_model.dart';
import 'package:udemy_flutter_sns/models/posts_model.dart';

class PostCard extends ConsumerWidget {
  const PostCard({
    Key? key,
    required this.post,
    required this.postDocs,
    required this.mainModel,
    required this.postDoc,
  }) : super(key: key);
  final Post post;
  final List<DocumentSnapshot<Map<String, dynamic>>> postDocs;
  final MainModel mainModel;
  final DocumentSnapshot<Map<String, dynamic>> postDoc;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PostsModel postsModel = ref.watch(postsProvider);
    final CommentsModel commentsModel = ref.watch(commentsProvider);
    final FirestoreUser firestoreUser = mainModel.firestoreUser;
    final MuteUsersModel muteUsersModel = ref.watch(muteUsersProvider);
    final MutePostsModel mutePostsModel = ref.watch(mutePostsProvider);
    final bool isMyPost = post.uid == firestoreUser.uid;

    return isValidUser(muteUids: mainModel.muteUids, map: postDoc.data()!) &&
            isValidPost(
                mutePostIds: mainModel.mutePostIds, map: postDoc.data()!)
        ? CardContainer(
            borderColor: Colors.green,
            onTap: () => voids.showPopUp(
              context: context,
              builder: (BuildContext innerContext) => CupertinoActionSheet(
                title: const Text(selectTitle),
                actions: [
                  CupertinoActionSheetAction(
                    // This parameter indicates the action would perform
                    // a destructive action such as delete or exit and turns
                    // the action's text color to red.
                    isDestructiveAction: true,
                    onPressed: () {
                      Navigator.pop(innerContext);
                      muteUsersModel.showMuteUserDialog(
                          context: context,
                          passiveUid: post.uid,
                          mainModel: mainModel,
                          docs: postDocs);
                    },
                    child: const Text(muteUserText),
                  ),
                  CupertinoActionSheetAction(
                    // This parameter indicates the action would perform
                    // a destructive action such as delete or exit and turns
                    // the action's text color to red.
                    isDestructiveAction: true,
                    onPressed: () {
                      Navigator.pop(innerContext);
                      mutePostsModel.showMutePostDialog(
                          context: context,
                          mainModel: mainModel,
                          postDoc: postDoc,
                          postDocs: postDocs);
                    },
                    child: const Text(mutePostText),
                  ),
                  CupertinoActionSheetAction(
                    onPressed: () => Navigator.pop(innerContext),
                    child: const Text(backText),
                  ),
                ],
              ),
            ),
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
