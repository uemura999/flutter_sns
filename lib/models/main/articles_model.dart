//dart
import 'dart:convert';
//flutter
import 'package:flutter/material.dart';
//packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
//constants
import 'package:udemy_flutter_sns/constants/strings.dart';
import 'package:udemy_flutter_sns/constants/voids.dart' as voids;
//domain
import 'package:udemy_flutter_sns/domain/article/article.dart';

final articlesProvider = ChangeNotifierProvider((ref) => ArticlesModel());

class ArticlesModel extends ChangeNotifier {
  List<dynamic> jsons = [];
  List<Article> articles = [];
  bool isLoading = false;

  ArticlesModel() {
    init();
  }
  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  Future<void> init() async {
    startLoading();
    const String uri = 'https://qiita.com/api/v2/items';
    final response = await http.get(Uri.parse(uri));
    if (response.statusCode == 200) {
      jsons = json.decode(response.body); //responseをdecode
      // //型を判別
      // final first = jsons.first; //最初の記事を取得
      // final firstUser = first['user']; //最初の記事のユーザーを取得
      // //記事の型を判別
      // final List<String> articleFields = [
      //   'id',
      //   'comments_count',
      //   'likes_count',
      //   'private',
      //   'reactions_count',
      //   'title',
      //   'url',
      //   'user'
      // ];
      // for (final field in articleFields) {
      //   debugPrint(
      //       '$field is ${first[field].runtimeType}\n'); //runtimeTypeは型を返す
      // }

      // //ユーザーの型を判別
      // final List<String> qiitaUserFields = [
      //   'description',
      //   'followees_count',
      //   'followers_count',
      //   'id',
      //   'items_count',
      //   'name',
      //   'permanent_id',
      //   'profile_image_url',
      // ];
      // for (final field in qiitaUserFields) {
      //   debugPrint('$field is ${firstUser[field].runtimeType}\n');
      // }

      articles = jsons.map((e) => Article.fromJson(e)).toList();
      endLoading();
    } else {
      //失敗
      voids.showFluttertoast(msg: failureRequestMsg);
    }
  }
}
