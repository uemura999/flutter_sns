// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_like.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostLikeImpl _$$PostLikeImplFromJson(Map<String, dynamic> json) =>
    _$PostLikeImpl(
      activeUid: json['activeUid'] as String,
      createdAt: json['createdAt'],
      passiveUid: json['passiveUid'] as String,
      postRef: json['postRef'],
      postId: json['postId'] as String,
    );

Map<String, dynamic> _$$PostLikeImplToJson(_$PostLikeImpl instance) =>
    <String, dynamic>{
      'activeUid': instance.activeUid,
      'createdAt': instance.createdAt,
      'passiveUid': instance.passiveUid,
      'postRef': instance.postRef,
      'postId': instance.postId,
    };
