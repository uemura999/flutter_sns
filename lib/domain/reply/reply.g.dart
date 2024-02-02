// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reply.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReplyImpl _$$ReplyImplFromJson(Map<String, dynamic> json) => _$ReplyImpl(
      createdAt: json['createdAt'],
      replyString: json['replyString'] as String,
      replyLanguageCode: json['replyLanguageCode'] as String,
      replyNegativeScore: (json['replyNegativeScore'] as num).toDouble(),
      replyPositiveScore: (json['replyPositiveScore'] as num).toDouble(),
      replySentiment: json['replySentiment'] as String,
      likeCount: json['likeCount'] as int,
      muteCount: json['muteCount'] as int,
      postRef: json['postRef'],
      postCommentRef: json['postCommentRef'],
      postCommentReplyId: json['postCommentReplyId'] as String,
      userName: json['userName'] as String,
      uid: json['uid'] as String,
      userImageURL: json['userImageURL'] as String,
      userNameLanguageCode: json['userNameLanguageCode'] as String,
      userNameNegativeScore: (json['userNameNegativeScore'] as num).toDouble(),
      userNamePositiveScore: (json['userNamePositiveScore'] as num).toDouble(),
      userNameSentiment: json['userNameSentiment'] as String,
      updatedAt: json['updatedAt'],
    );

Map<String, dynamic> _$$ReplyImplToJson(_$ReplyImpl instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt,
      'replyString': instance.replyString,
      'replyLanguageCode': instance.replyLanguageCode,
      'replyNegativeScore': instance.replyNegativeScore,
      'replyPositiveScore': instance.replyPositiveScore,
      'replySentiment': instance.replySentiment,
      'likeCount': instance.likeCount,
      'muteCount': instance.muteCount,
      'postRef': instance.postRef,
      'postCommentRef': instance.postCommentRef,
      'postCommentReplyId': instance.postCommentReplyId,
      'userName': instance.userName,
      'uid': instance.uid,
      'userImageURL': instance.userImageURL,
      'userNameLanguageCode': instance.userNameLanguageCode,
      'userNameNegativeScore': instance.userNameNegativeScore,
      'userNamePositiveScore': instance.userNamePositiveScore,
      'userNameSentiment': instance.userNameSentiment,
      'updatedAt': instance.updatedAt,
    };
