// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_mute.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CommentMuteImpl _$$CommentMuteImplFromJson(Map<String, dynamic> json) =>
    _$CommentMuteImpl(
      activeUid: json['activeUid'] as String,
      createdAt: json['createdAt'],
      postCommentId: json['postCommentId'] as String,
      postCommentRef: json['postCommentRef'],
    );

Map<String, dynamic> _$$CommentMuteImplToJson(_$CommentMuteImpl instance) =>
    <String, dynamic>{
      'activeUid': instance.activeUid,
      'createdAt': instance.createdAt,
      'postCommentId': instance.postCommentId,
      'postCommentRef': instance.postCommentRef,
    };
