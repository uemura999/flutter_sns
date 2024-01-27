// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_like.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CommentLikeImpl _$$CommentLikeImplFromJson(Map<String, dynamic> json) =>
    _$CommentLikeImpl(
      activeUid: json['activeUid'] as String,
      createdAt: json['createdAt'],
      postCommentCreatorUid: json['postCommentCreatorUid'] as String,
      postCommentRef: json['postCommentRef'],
      postCommentId: json['postCommentId'] as String,
    );

Map<String, dynamic> _$$CommentLikeImplToJson(_$CommentLikeImpl instance) =>
    <String, dynamic>{
      'activeUid': instance.activeUid,
      'createdAt': instance.createdAt,
      'postCommentCreatorUid': instance.postCommentCreatorUid,
      'postCommentRef': instance.postCommentRef,
      'postCommentId': instance.postCommentId,
    };
