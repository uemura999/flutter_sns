// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firestore_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FirestoreUserImpl _$$FirestoreUserImplFromJson(Map<String, dynamic> json) =>
    _$FirestoreUserImpl(
      createdAt: json['createdAt'],
      followerCount: json['followerCount'] as int,
      followingCount: json['followingCount'] as int,
      isAdmin: json['isAdmin'] as bool,
      muteCount: json['muteCount'] as int,
      updatedAt: json['updatedAt'],
      userName: json['userName'] as String,
      userImageURL: json['userImageURL'] as String,
      uid: json['uid'] as String,
    );

Map<String, dynamic> _$$FirestoreUserImplToJson(_$FirestoreUserImpl instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt,
      'followerCount': instance.followerCount,
      'followingCount': instance.followingCount,
      'isAdmin': instance.isAdmin,
      'muteCount': instance.muteCount,
      'updatedAt': instance.updatedAt,
      'userName': instance.userName,
      'userImageURL': instance.userImageURL,
      'uid': instance.uid,
    };
