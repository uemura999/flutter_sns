import 'package:freezed_annotation/freezed_annotation.dart';

part 'article.freezed.dart';
part 'article.g.dart';

@freezed
abstract class Article with _$Article {
  const factory Article({
    required String id,
    // ignore: non_constant_identifier_names
    required int comments_count,
    required int likes_count,
    required bool private,
    required int reactions_count,
    required String title,
    required String url,
    required dynamic user,
  }) = _Article;
  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);
}
