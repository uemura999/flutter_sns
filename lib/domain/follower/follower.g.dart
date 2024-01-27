// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follower.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FollowerImpl _$$FollowerImplFromJson(Map<String, dynamic> json) =>
    _$FollowerImpl(
      createdAt: json['createdAt'],
      followedUid: json['followedUid'] as String,
      followerUid: json['followerUid'] as String,
    );

Map<String, dynamic> _$$FollowerImplToJson(_$FollowerImpl instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt,
      'followedUid': instance.followedUid,
      'followerUid': instance.followerUid,
    };
