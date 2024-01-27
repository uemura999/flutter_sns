// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'following_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FollowingTokenImpl _$$FollowingTokenImplFromJson(Map<String, dynamic> json) =>
    _$FollowingTokenImpl(
      createdAt: json['createdAt'],
      passiveUid: json['passiveUid'] as String,
      tokenId: json['tokenId'] as String,
      tokenType: json['tokenType'] as String,
    );

Map<String, dynamic> _$$FollowingTokenImplToJson(
        _$FollowingTokenImpl instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt,
      'passiveUid': instance.passiveUid,
      'tokenId': instance.tokenId,
      'tokenType': instance.tokenType,
    };
