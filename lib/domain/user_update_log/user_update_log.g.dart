// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_update_log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserUpdateLogImpl _$$UserUpdateLogImplFromJson(Map<String, dynamic> json) =>
    _$UserUpdateLogImpl(
      logcreatedAt: json['logcreatedAt'],
      userName: json['userName'] as String,
      userImageURL: json['userImageURL'] as String,
      userRef: json['userRef'],
      uid: json['uid'] as String,
    );

Map<String, dynamic> _$$UserUpdateLogImplToJson(_$UserUpdateLogImpl instance) =>
    <String, dynamic>{
      'logcreatedAt': instance.logcreatedAt,
      'userName': instance.userName,
      'userImageURL': instance.userImageURL,
      'userRef': instance.userRef,
      'uid': instance.uid,
    };
