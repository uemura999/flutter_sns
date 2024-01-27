//flutter
import 'package:cloud_firestore/cloud_firestore.dart';
//domain
import 'package:udemy_flutter_sns/domain/comment/comment.dart';
import 'package:udemy_flutter_sns/domain/post/post.dart';
import 'package:udemy_flutter_sns/domain/reply/reply.dart';

bool isValidUser(
        {required List<String> muteUids, required DocumentSnapshot doc}) =>
    !muteUids.contains(doc['uid']);

bool isValidPost({required List<String> mutePostIds, required Post post}) =>
    !mutePostIds.contains(post.postId);

bool isValidComment(
        {required List<String> muteCommentIds, required Comment comment}) =>
    !muteCommentIds.contains(comment.postCommentId);
//ミュートしているreplyIdたちにReplyのidが含まれていないか、含まれていなければtrueを返す
bool isValidReply({required List<String> muteReplyIds, required Reply reply}) =>
    !muteReplyIds.contains(reply.postCommentReplyId);
