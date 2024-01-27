// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reply_like.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReplyLikeImpl _$$ReplyLikeImplFromJson(Map<String, dynamic> json) =>
    _$ReplyLikeImpl(
      activeUid: json['activeUid'] as String,
      createdAt: json['createdAt'],
      postCommentReplyCreatorUid: json['postCommentReplyCreatorUid'] as String,
      postCommentReplyRef: json['postCommentReplyRef'],
      postCommentReplyId: json['postCommentReplyId'] as String,
    );

Map<String, dynamic> _$$ReplyLikeImplToJson(_$ReplyLikeImpl instance) =>
    <String, dynamic>{
      'activeUid': instance.activeUid,
      'createdAt': instance.createdAt,
      'postCommentReplyCreatorUid': instance.postCommentReplyCreatorUid,
      'postCommentReplyRef': instance.postCommentReplyRef,
      'postCommentReplyId': instance.postCommentReplyId,
    };
