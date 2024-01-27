//flutter
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//constants
import 'package:udemy_flutter_sns/constants/strings.dart';
import 'package:udemy_flutter_sns/constants/voids.dart' as voids;
//components
import 'package:udemy_flutter_sns/details/rounded_button.dart';
import 'package:udemy_flutter_sns/views/comments/components/comment_card.dart';
import 'package:udemy_flutter_sns/views/refresh_screen.dart';
//domain
import 'package:udemy_flutter_sns/domain/comment/comment.dart';
import 'package:udemy_flutter_sns/domain/post/post.dart';
//models
import 'package:udemy_flutter_sns/models/mute_comments_model.dart';
import 'package:udemy_flutter_sns/models/mute_users_model.dart';
import 'package:udemy_flutter_sns/models/main_model.dart';
import 'package:udemy_flutter_sns/models/comments_model.dart';

class CommentsPage extends ConsumerWidget {
  const CommentsPage({
    Key? key,
    required this.post,
    required this.postDoc,
    required this.mainModel,
  }) : super(key: key);
  final Post post;
  final DocumentSnapshot<Map<String, dynamic>> postDoc;
  final MainModel mainModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CommentsModel commentsModel = ref.watch(commentsProvider);
    final MuteUsersModel muteUsersModel = ref.watch(muteUsersProvider);
    final MuteCommentsModel muteCommentsModel = ref.watch(muteCommentsProvider);
    final commentDocs = commentsModel.commentDocs;
    return Scaffold(
      appBar: AppBar(
        title: const Text(commentTitle),
      ),
      body: commentDocs.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: RoundedButton(
                      onPressed: () async =>
                          await commentsModel.onReload(postDoc: postDoc),
                      widthRate: 0.85,
                      color: Colors.green,
                      text: reloadText),
                )
              ],
            )
          : RefreshScreen(
              onRefresh: () async =>
                  await commentsModel.onRefresh(postDoc: postDoc),
              onLoading: () async =>
                  await commentsModel.onLoading(postDoc: postDoc),
              refreshController: commentsModel.refreshController,
              child: ListView.builder(
                  itemCount: commentDocs.length,
                  itemBuilder: (BuildContext context, int index) {
                    final commentDoc = commentDocs[index];
                    final Comment comment =
                        Comment.fromJson(commentDoc.data()!);
                    return CommentCard(
                        onTap: () => voids.showPopUp(
                              context: context,
                              builder: (BuildContext innerContext) =>
                                  CupertinoActionSheet(
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
                                          passiveUid: comment.uid,
                                          mainModel: mainModel,
                                          docs: commentDocs);
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
                                      muteCommentsModel.showMuteCommentDialog(
                                          context: context,
                                          mainModel: mainModel,
                                          commentDoc: commentDoc,
                                          commentDocs: commentDocs);
                                    },
                                    child: const Text(muteCommentText),
                                  ),
                                  CupertinoActionSheetAction(
                                    onPressed: () =>
                                        Navigator.pop(innerContext),
                                    child: const Text(backText),
                                  ),
                                ],
                              ),
                            ),
                        mainModel: mainModel,
                        post: post,
                        comment: comment,
                        commentsModel: commentsModel,
                        commentDoc: commentDoc);
                  })),
      floatingActionButton: FloatingActionButton(
        onPressed: () => commentsModel.showCommentFlashBar(
            context: context, mainModel: mainModel, postDoc: postDoc),
        backgroundColor: Colors.orange,
        child: const Icon(Icons.new_label),
      ),
    );
  }
}
