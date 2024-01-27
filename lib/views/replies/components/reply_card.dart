//flutter
import 'package:flutter/material.dart';
//packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//constants
import 'package:udemy_flutter_sns/constants/bools.dart';
//components
import 'package:udemy_flutter_sns/details/card_container.dart';
import 'package:udemy_flutter_sns/details/user_image.dart';
import 'package:udemy_flutter_sns/domain/comment/comment.dart';
//domain
import 'package:udemy_flutter_sns/domain/reply/reply.dart';
import 'package:udemy_flutter_sns/models/main_model.dart';
//models
import 'package:udemy_flutter_sns/models/replies_model.dart';
import 'package:udemy_flutter_sns/views/replies/components/reply_like_button.dart';

class ReplyCard extends ConsumerWidget {
  const ReplyCard({
    Key? key,
    required this.comment,
    required this.onTap,
    required this.reply,
    required this.replyDoc,
    required this.mainModel,
  }) : super(key: key);
  final Comment comment;
  final void Function() onTap;
  final Reply reply;
  final DocumentSnapshot replyDoc;
  final MainModel mainModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final RepliesModel repliesModel = ref.watch(repliesProvider);
    return isValidUser(muteUids: mainModel.muteUids, doc: replyDoc) &&
            isValidReply(muteReplyIds: mainModel.muteReplyIds, reply: reply)
        ? CardContainer(
            borderColor: Colors.green,
            onTap: onTap,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  UserImage(length: 32.0, userImageURL: reply.userImageURL),
                  Text(
                    reply.userName,
                    style: const TextStyle(
                        fontSize: 20.0, overflow: TextOverflow.ellipsis),
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    reply.replyString,
                    style: const TextStyle(
                        fontSize: 20.0, overflow: TextOverflow.ellipsis),
                  ),
                  const Expanded(child: SizedBox()),
                  ReplyLikeButton(
                      mainModel: mainModel,
                      comment: comment,
                      reply: reply,
                      replyDoc: replyDoc,
                      repliesModel: repliesModel)
                ],
              ),
            ]),
          )
        : const SizedBox.shrink();
  }
}
