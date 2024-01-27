//flutter
import 'package:flutter/material.dart';
//packages
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//constants
import 'package:udemy_flutter_sns/constants/strings.dart';
import 'package:udemy_flutter_sns/constants/voids.dart' as voids;
//models
import 'package:udemy_flutter_sns/models/main_model.dart';
import 'package:udemy_flutter_sns/models/mute_replies_model.dart';
import 'package:udemy_flutter_sns/models/mute_users_model.dart';
import 'package:udemy_flutter_sns/models/replies_model.dart';
//domain
import 'package:udemy_flutter_sns/domain/reply/reply.dart';
import 'package:udemy_flutter_sns/domain/comment/comment.dart';
//components
import 'package:udemy_flutter_sns/views/replies/components/reply_card.dart';

class RepliesPage extends ConsumerWidget {
  const RepliesPage(
      {Key? key,
      required this.comment,
      required this.commentDoc,
      required this.mainModel})
      : super(key: key);
  final Comment comment;
  final DocumentSnapshot<Map<String, dynamic>> commentDoc;
  final MainModel mainModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final RepliesModel repliesModel = ref.watch(repliesProvider);
    final MuteUsersModel muteUsersModel = ref.watch(muteUsersProvider);
    final MuteRepliesModel muteRepliesModel = ref.watch(muteRepliesProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(replyTitle),
      ),
      body: StreamBuilder<QuerySnapshot>(
          //streamにqueryのようなものを入れる
          stream: commentDoc.reference
              .collection("postCommentReplies")
              .orderBy("likeCount", descending: true)
              .limit(30)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting ||
                snapshot.hasError) {
              return const Text(loadingText);
            } else if (!snapshot.hasData) {
              return const Text('データがありません');
            } else {
              final replyDocs = snapshot.data!.docs;
              return ListView(
                //DocumentSnapshot<Map<String, dynamic>>は不可
                children: replyDocs.map((DocumentSnapshot replyDoc) {
                  final Map<String, dynamic> data =
                      replyDoc.data()! as Map<String, dynamic>;
                  final Reply reply = Reply.fromJson(data);
                  return ReplyCard(
                      comment: comment,
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
                                        passiveUid: reply.uid,
                                        mainModel: mainModel,
                                        docs: []);
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
                                    //リアルタイム取得なので表示しなければいい
                                    muteRepliesModel.showMuteRepliesDialog(
                                        context: context,
                                        mainModel: mainModel,
                                        replyDoc: replyDoc);
                                  },
                                  child: const Text(muteReplyText),
                                ),
                                CupertinoActionSheetAction(
                                  onPressed: () => Navigator.pop(innerContext),
                                  child: const Text(backText),
                                ),
                              ],
                            ),
                          ),
                      reply: reply,
                      replyDoc: replyDoc,
                      mainModel: mainModel);
                }).toList(),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => repliesModel.showReplyFlashBar(
            context: context,
            mainModel: mainModel,
            comment: comment,
            commentDoc: commentDoc),
        backgroundColor: Colors.purple,
        child: const Icon(
          Icons.new_label,
          color: Colors.white,
        ),
      ),
    );
  }
}
