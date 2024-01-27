import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_mute.freezed.dart';
part 'post_mute.g.dart';

@freezed
abstract class PostMute with _$PostMute {
  const factory PostMute({
    required String activeUid,
    required dynamic createdAt,
    required String postId,
    required dynamic postRef,
  }) = _PostMute;

  factory PostMute.fromJson(Map<String, dynamic> json) =>
      _$PostMuteFromJson(json);
}
