// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mute_post_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MutePostTokenImpl _$$MutePostTokenImplFromJson(Map<String, dynamic> json) =>
    _$MutePostTokenImpl(
      activeUid: json['activeUid'] as String,
      createdAt: json['createdAt'],
      postId: json['postId'] as String,
      postRef: json['postRef'],
      tokenId: json['tokenId'] as String,
      tokenType: json['tokenType'] as String,
    );

Map<String, dynamic> _$$MutePostTokenImplToJson(_$MutePostTokenImpl instance) =>
    <String, dynamic>{
      'activeUid': instance.activeUid,
      'createdAt': instance.createdAt,
      'postId': instance.postId,
      'postRef': instance.postRef,
      'tokenId': instance.tokenId,
      'tokenType': instance.tokenType,
    };
