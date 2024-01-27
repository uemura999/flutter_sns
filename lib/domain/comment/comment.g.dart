// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CommentImpl _$$CommentImplFromJson(Map<String, dynamic> json) =>
    _$CommentImpl(
      createdAt: json['createdAt'],
      commentString: json['commentString'] as String,
      likeCount: json['likeCount'] as int,
      postRef: json['postRef'],
      postCommentId: json['postCommentId'] as String,
      postCommentReplyCount: json['postCommentReplyCount'] as int,
      muteCount: json['muteCount'] as int,
      userName: json['userName'] as String,
      uid: json['uid'] as String,
      userImageURL: json['userImageURL'] as String,
      updatedAt: json['updatedAt'],
    );

Map<String, dynamic> _$$CommentImplToJson(_$CommentImpl instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt,
      'commentString': instance.commentString,
      'likeCount': instance.likeCount,
      'postRef': instance.postRef,
      'postCommentId': instance.postCommentId,
      'postCommentReplyCount': instance.postCommentReplyCount,
      'muteCount': instance.muteCount,
      'userName': instance.userName,
      'uid': instance.uid,
      'userImageURL': instance.userImageURL,
      'updatedAt': instance.updatedAt,
    };
