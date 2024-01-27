import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment.freezed.dart';
part 'comment.g.dart';

@freezed
abstract class Comment with _$Comment {
  const factory Comment({
    required dynamic createdAt,
    required String commentString,
    required int likeCount,
    required dynamic postRef,
    required String postCommentId,
    required int postCommentReplyCount,
    required int muteCount,
    required String userName,
    required String uid,
    required String userImageURL,
    required dynamic updatedAt,
  }) = _Comment;
  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
}
