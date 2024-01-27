// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_mute.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserMuteImpl _$$UserMuteImplFromJson(Map<String, dynamic> json) =>
    _$UserMuteImpl(
      activeUid: json['activeUid'] as String,
      createdAt: json['createdAt'],
      passiveUid: json['passiveUid'] as String,
      passiveUserRef: json['passiveUserRef'],
    );

Map<String, dynamic> _$$UserMuteImplToJson(_$UserMuteImpl instance) =>
    <String, dynamic>{
      'activeUid': instance.activeUid,
      'createdAt': instance.createdAt,
      'passiveUid': instance.passiveUid,
      'passiveUserRef': instance.passiveUserRef,
    };
