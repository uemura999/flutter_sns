//domain
import 'package:udemy_flutter_sns/domain/comment/comment.dart';
import 'package:udemy_flutter_sns/domain/reply/reply.dart';

bool isValidUser(
        {required List<String> muteUids, required Map<String, dynamic> map}) =>
    !muteUids.contains(map['uid']);

bool isValidPost(
        {required List<String> mutePostIds,
        required Map<String, dynamic> map}) =>
    !mutePostIds.contains(map['postId']);

bool isValidComment(
        {required List<String> muteCommentIds, required Comment comment}) =>
    !muteCommentIds.contains(comment.postCommentId);
//ミュートしているreplyIdたちにReplyのidが含まれていないか、含まれていなければtrueを返す
bool isValidReply({required List<String> muteReplyIds, required Reply reply}) =>
    !muteReplyIds.contains(reply.postCommentReplyId);
