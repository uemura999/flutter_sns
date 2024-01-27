import 'package:freezed_annotation/freezed_annotation.dart';

part 'reply_like.freezed.dart';
part 'reply_like.g.dart';

@freezed
abstract class ReplyLike with _$ReplyLike {
  const factory ReplyLike({
    required String activeUid,
    required dynamic createdAt,
    required String postCommentReplyCreatorUid,
    required dynamic postCommentReplyRef,
    required String postCommentReplyId,
  }) = _ReplyLike;

  factory ReplyLike.fromJson(Map<String, dynamic> json) =>
      _$ReplyLikeFromJson(json);
}
