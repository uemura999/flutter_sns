// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mute_reply_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MuteReplyTokenImpl _$$MuteReplyTokenImplFromJson(Map<String, dynamic> json) =>
    _$MuteReplyTokenImpl(
      activeUid: json['activeUid'] as String,
      createdAt: json['createdAt'],
      postCommentReplyId: json['postCommentReplyId'] as String,
      postCommentReplyRef: json['postCommentReplyRef'],
      tokenId: json['tokenId'] as String,
      tokenType: json['tokenType'] as String,
    );

Map<String, dynamic> _$$MuteReplyTokenImplToJson(
        _$MuteReplyTokenImpl instance) =>
    <String, dynamic>{
      'activeUid': instance.activeUid,
      'createdAt': instance.createdAt,
      'postCommentReplyId': instance.postCommentReplyId,
      'postCommentReplyRef': instance.postCommentReplyRef,
      'tokenId': instance.tokenId,
      'tokenType': instance.tokenType,
    };
