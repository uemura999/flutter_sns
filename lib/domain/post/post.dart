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
    required String textLanguageCode,
    required double textNegativeScore,
    required double textPositiveScore,
    required String textSentiment,
    required int muteCount,
    required String postId,
    // required int reportCount, securityrulesも変更要
    required String uid,
    required String userName,
    required String userNameLanguageCode,
    required double userNameNegativeScore,
    required double userNamePositiveScore,
    required String userNameSentiment,
    required String userImageURL,
    required dynamic updatedAt,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}
