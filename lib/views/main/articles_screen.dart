//flutter
import 'package:flutter/material.dart';
//packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
//components
import 'package:udemy_flutter_sns/details/article_user_image.dart';
//domain
import 'package:udemy_flutter_sns/domain/qiita_user/qiita_user.dart';
//models
import 'package:udemy_flutter_sns/models/main/articles_model.dart';

class ArticlesScreen extends ConsumerWidget {
  const ArticlesScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ArticlesModel articlesModel = ref.watch(articlesProvider);
    final articles = articlesModel.articles;
    return Scaffold(
      body: articlesModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              alignment: Alignment.center,
              child: ListView.builder(
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    final article = articles[index];
                    final QiitaUser qiitaUser =
                        QiitaUser.fromJson(article.user);
                    return ListTile(
                      leading: ArticleUserImage(
                          length: 64.0,
                          ArticleUserImageURL: qiitaUser.profile_image_url),
                      title: Text(qiitaUser.name),
                      subtitle: Text(article.title),
                    );
                  })),
    );
  }
}
