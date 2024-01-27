import 'package:freezed_annotation/freezed_annotation.dart';

part 'like_reply_token.freezed.dart';
part 'like_reply_token.g.dart';

@freezed
abstract class LikeReplyToken with _$LikeReplyToken {
  //自分が投稿にいいねしたことの印
  const factory LikeReplyToken({
    required String activeUid,
    required dynamic createdAt,
    required String passiveUid,
    required dynamic postCommentReplyRef,
    required String postCommentReplyId,
    required String tokenId,
    required String tokenType,
  }) = _LikeReplyToken;
  factory LikeReplyToken.fromJson(Map<String, dynamic> json) =>
      _$LikeReplyTokenFromJson(json);
}
