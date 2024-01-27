import 'package:freezed_annotation/freezed_annotation.dart';

part 'reply.freezed.dart';
part 'reply.g.dart';

@freezed
abstract class Reply with _$Reply {
  const factory Reply({
    required dynamic createdAt,
    required String replyString,
    required int likeCount,
    required int muteCount,
    required dynamic postRef,
    required dynamic postCommentRef,
    required String postCommentReplyId,
    required String userName,
    //resource.data.uid
    required String uid,
    required String userImageURL,
    required dynamic updatedAt,
  }) = _Reply;
  factory Reply.fromJson(Map<String, dynamic> json) => _$ReplyFromJson(json);
}
