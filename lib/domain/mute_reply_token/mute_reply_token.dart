import 'package:freezed_annotation/freezed_annotation.dart';

part 'mute_reply_token.freezed.dart';
part 'mute_reply_token.g.dart';

@freezed
abstract class MuteReplyToken with _$MuteReplyToken {
  //自分が投稿にいいねしたことの印
  const factory MuteReplyToken({
    required String activeUid,
    required dynamic createdAt,
    required String postCommentReplyId,
    required dynamic postCommentReplyRef,
    required String tokenId,
    required String tokenType,
  }) = _MuteReplyToken;
  factory MuteReplyToken.fromJson(Map<String, dynamic> json) =>
      _$MuteReplyTokenFromJson(json);
}
