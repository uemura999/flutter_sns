import 'package:freezed_annotation/freezed_annotation.dart';

part 'mute_comment_token.freezed.dart';
part 'mute_comment_token.g.dart';

@freezed
abstract class MuteCommentToken with _$MuteCommentToken {
  //自分が投稿にいいねしたことの印
  const factory MuteCommentToken({
    required String activeUid,
    required dynamic createdAt,
    required String postCommentId,
    required dynamic postCommentRef,
    required String tokenId,
    required String tokenType,
  }) = _MuteCommentToken;
  factory MuteCommentToken.fromJson(Map<String, dynamic> json) =>
      _$MuteCommentTokenFromJson(json);
}
