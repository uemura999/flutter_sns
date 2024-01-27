// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like_comment_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LikeCommentTokenImpl _$$LikeCommentTokenImplFromJson(
        Map<String, dynamic> json) =>
    _$LikeCommentTokenImpl(
      activeUid: json['activeUid'] as String,
      createdAt: json['createdAt'],
      passiveUid: json['passiveUid'] as String,
      postCommentRef: json['postCommentRef'],
      postCommentId: json['postCommentId'] as String,
      tokenId: json['tokenId'] as String,
      tokenType: json['tokenType'] as String,
    );

Map<String, dynamic> _$$LikeCommentTokenImplToJson(
        _$LikeCommentTokenImpl instance) =>
    <String, dynamic>{
      'activeUid': instance.activeUid,
      'createdAt': instance.createdAt,
      'passiveUid': instance.passiveUid,
      'postCommentRef': instance.postCommentRef,
      'postCommentId': instance.postCommentId,
      'tokenId': instance.tokenId,
      'tokenType': instance.tokenType,
    };
