// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_mute.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostMuteImpl _$$PostMuteImplFromJson(Map<String, dynamic> json) =>
    _$PostMuteImpl(
      activeUid: json['activeUid'] as String,
      createdAt: json['createdAt'],
      postId: json['postId'] as String,
      postRef: json['postRef'],
    );

Map<String, dynamic> _$$PostMuteImplToJson(_$PostMuteImpl instance) =>
    <String, dynamic>{
      'activeUid': instance.activeUid,
      'createdAt': instance.createdAt,
      'postId': instance.postId,
      'postRef': instance.postRef,
    };
