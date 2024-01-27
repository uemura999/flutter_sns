// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mute_user_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MuteUserTokenImpl _$$MuteUserTokenImplFromJson(Map<String, dynamic> json) =>
    _$MuteUserTokenImpl(
      activeUid: json['activeUid'] as String,
      createdAt: json['createdAt'],
      passiveUid: json['passiveUid'] as String,
      tokenId: json['tokenId'] as String,
      tokenType: json['tokenType'] as String,
    );

Map<String, dynamic> _$$MuteUserTokenImplToJson(_$MuteUserTokenImpl instance) =>
    <String, dynamic>{
      'activeUid': instance.activeUid,
      'createdAt': instance.createdAt,
      'passiveUid': instance.passiveUid,
      'tokenId': instance.tokenId,
      'tokenType': instance.tokenType,
    };
