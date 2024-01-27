// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like_post_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LikePostTokenImpl _$$LikePostTokenImplFromJson(Map<String, dynamic> json) =>
    _$LikePostTokenImpl(
      activeUid: json['activeUid'] as String,
      createdAt: json['createdAt'],
      passiveUid: json['passiveUid'] as String,
      postRef: json['postRef'],
      postId: json['postId'] as String,
      tokenId: json['tokenId'] as String,
      tokenType: json['tokenType'] as String,
    );

Map<String, dynamic> _$$LikePostTokenImplToJson(_$LikePostTokenImpl instance) =>
    <String, dynamic>{
      'activeUid': instance.activeUid,
      'createdAt': instance.createdAt,
      'passiveUid': instance.passiveUid,
      'postRef': instance.postRef,
      'postId': instance.postId,
      'tokenId': instance.tokenId,
      'tokenType': instance.tokenType,
    };
