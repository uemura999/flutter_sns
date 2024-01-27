import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';
part 'post.g.dart';

@freezed
abstract class Post with _$Post {
  const factory Post({
    required int commentCount,
    required dynamic createdAt,
    required List<String> hashTags,
    required String imageUrl,
    required int likeCount,
    required String text,
    required int muteCount,
    required String postId,
    required String uid,
    required String userName,
    required String userImageURL,
    required dynamic updatedAt,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}
