// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mute_comment_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MuteCommentTokenImpl _$$MuteCommentTokenImplFromJson(
        Map<String, dynamic> json) =>
    _$MuteCommentTokenImpl(
      activeUid: json['activeUid'] as String,
      createdAt: json['createdAt'],
      postCommentId: json['postCommentId'] as String,
      postCommentRef: json['postCommentRef'],
      tokenId: json['tokenId'] as String,
      tokenType: json['tokenType'] as String,
    );

Map<String, dynamic> _$$MuteCommentTokenImplToJson(
        _$MuteCommentTokenImpl instance) =>
    <String, dynamic>{
      'activeUid': instance.activeUid,
      'createdAt': instance.createdAt,
      'postCommentId': instance.postCommentId,
      'postCommentRef': instance.postCommentRef,
      'tokenId': instance.tokenId,
      'tokenType': instance.tokenType,
    };
