// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CommentImpl _$$CommentImplFromJson(Map<String, dynamic> json) =>
    _$CommentImpl(
      createdAt: json['createdAt'],
      commentString: json['commentString'] as String,
      commentLanguageCode: json['commentLanguageCode'] as String,
      commentNegativeScore: (json['commentNegativeScore'] as num).toDouble(),
      commentPositiveScore: (json['commentPositiveScore'] as num).toDouble(),
      commentSentiment: json['commentSentiment'] as String,
      likeCount: json['likeCount'] as int,
      postRef: json['postRef'],
      postCommentId: json['postCommentId'] as String,
      postCommentReplyCount: json['postCommentReplyCount'] as int,
      muteCount: json['muteCount'] as int,
      userName: json['userName'] as String,
      uid: json['uid'] as String,
      userImageURL: json['userImageURL'] as String,
      userNameLanguageCode: json['userNameLanguageCode'] as String,
      userNameNegativeScore: (json['userNameNegativeScore'] as num).toDouble(),
      userNamePositiveScore: (json['userNamePositiveScore'] as num).toDouble(),
      userNameSentiment: json['userNameSentiment'] as String,
      updatedAt: json['updatedAt'],
    );

Map<String, dynamic> _$$CommentImplToJson(_$CommentImpl instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt,
      'commentString': instance.commentString,
      'commentLanguageCode': instance.commentLanguageCode,
      'commentNegativeScore': instance.commentNegativeScore,
      'commentPositiveScore': instance.commentPositiveScore,
      'commentSentiment': instance.commentSentiment,
      'likeCount': instance.likeCount,
      'postRef': instance.postRef,
      'postCommentId': instance.postCommentId,
      'postCommentReplyCount': instance.postCommentReplyCount,
      'muteCount': instance.muteCount,
      'userName': instance.userName,
      'uid': instance.uid,
      'userImageURL': instance.userImageURL,
      'userNameLanguageCode': instance.userNameLanguageCode,
      'userNameNegativeScore': instance.userNameNegativeScore,
      'userNamePositiveScore': instance.userNamePositiveScore,
      'userNameSentiment': instance.userNameSentiment,
      'updatedAt': instance.updatedAt,
    };
