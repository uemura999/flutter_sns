// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qiita_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QiitaUserImpl _$$QiitaUserImplFromJson(Map<String, dynamic> json) =>
    _$QiitaUserImpl(
      description: json['description'],
      followees_count: json['followees_count'] as int,
      followers_count: json['followers_count'] as int,
      id: json['id'] as String,
      items_count: json['items_count'] as int,
      name: json['name'] as String,
      permanent_id: json['permanent_id'] as int,
      profile_image_url: json['profile_image_url'] as String,
    );

Map<String, dynamic> _$$QiitaUserImplToJson(_$QiitaUserImpl instance) =>
    <String, dynamic>{
      'description': instance.description,
      'followees_count': instance.followees_count,
      'followers_count': instance.followers_count,
      'id': instance.id,
      'items_count': instance.items_count,
      'name': instance.name,
      'permanent_id': instance.permanent_id,
      'profile_image_url': instance.profile_image_url,
    };
