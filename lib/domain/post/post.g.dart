// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostImpl _$$PostImplFromJson(Map<String, dynamic> json) => _$PostImpl(
      commentCount: json['commentCount'] as int,
      createdAt: json['createdAt'],
      hashTags:
          (json['hashTags'] as List<dynamic>).map((e) => e as String).toList(),
      imageUrl: json['imageUrl'] as String,
      likeCount: json['likeCount'] as int,
      text: json['text'] as String,
      textLanguageCode: json['textLanguageCode'] as String,
      textNegativeScore: (json['textNegativeScore'] as num).toDouble(),
      textPositiveScore: (json['textPositiveScore'] as num).toDouble(),
      textSentiment: json['textSentiment'] as String,
      muteCount: json['muteCount'] as int,
      postId: json['postId'] as String,
      uid: json['uid'] as String,
      userName: json['userName'] as String,
      userNameLanguageCode: json['userNameLanguageCode'] as String,
      userNameNegativeScore: (json['userNameNegativeScore'] as num).toDouble(),
      userNamePositiveScore: (json['userNamePositiveScore'] as num).toDouble(),
      userNameSentiment: json['userNameSentiment'] as String,
      userImageURL: json['userImageURL'] as String,
      updatedAt: json['updatedAt'],
    );

Map<String, dynamic> _$$PostImplToJson(_$PostImpl instance) =>
    <String, dynamic>{
      'commentCount': instance.commentCount,
      'createdAt': instance.createdAt,
      'hashTags': instance.hashTags,
      'imageUrl': instance.imageUrl,
      'likeCount': instance.likeCount,
      'text': instance.text,
      'textLanguageCode': instance.textLanguageCode,
      'textNegativeScore': instance.textNegativeScore,
      'textPositiveScore': instance.textPositiveScore,
      'textSentiment': instance.textSentiment,
      'muteCount': instance.muteCount,
      'postId': instance.postId,
      'uid': instance.uid,
      'userName': instance.userName,
      'userNameLanguageCode': instance.userNameLanguageCode,
      'userNameNegativeScore': instance.userNameNegativeScore,
      'userNamePositiveScore': instance.userNamePositiveScore,
      'userNameSentiment': instance.userNameSentiment,
      'userImageURL': instance.userImageURL,
      'updatedAt': instance.updatedAt,
    };
