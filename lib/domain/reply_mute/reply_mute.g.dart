// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reply_mute.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReplyMuteImpl _$$ReplyMuteImplFromJson(Map<String, dynamic> json) =>
    _$ReplyMuteImpl(
      activeUid: json['activeUid'] as String,
      createdAt: json['createdAt'],
      postCommentReplyId: json['postCommentReplyId'] as String,
      postCommentReplyRef: json['postCommentReplyRef'],
    );

Map<String, dynamic> _$$ReplyMuteImplToJson(_$ReplyMuteImpl instance) =>
    <String, dynamic>{
      'activeUid': instance.activeUid,
      'createdAt': instance.createdAt,
      'postCommentReplyId': instance.postCommentReplyId,
      'postCommentReplyRef': instance.postCommentReplyRef,
    };
