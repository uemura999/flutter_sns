//flutter
import 'package:flutter/material.dart';
//packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//constants
import 'package:udemy_flutter_sns/constants/ints.dart';
import 'package:udemy_flutter_sns/constants/lists.dart';
import 'package:udemy_flutter_sns/constants/others.dart';
import 'package:udemy_flutter_sns/constants/strings.dart';
import 'package:udemy_flutter_sns/constants/voids.dart' as voids;

final userSearchProvider = ChangeNotifierProvider((ref) => UserSearchModel());

class UserSearchModel extends ChangeNotifier {
  List<DocumentSnapshot<Map<String, dynamic>>> userDocs = [];
  String searchTerm = '';

  Future<void> operation(
      {required List<String> muteUids,
      required List<String> mutePostIds}) async {
    if (searchTerm.length > maxSearchLength) {
      await voids.showFluttertoast(msg: maxSeardhLengthMsg);
    } else if (searchTerm.isNotEmpty) {
      userDocs.removeWhere((element) => true); //中身を全て削除
      final List<String> searchWords =
          returnSearchWords(searchTerm: searchTerm);
      //queryは文字数-1個のwhereが必要
      final Query<Map<String, dynamic>> query =
          returnSearchQuery(searchWords: searchWords);
      await voids.processBasicDocs(
          muteUids: muteUids,
          mutePostIds: mutePostIds,
          docs: userDocs,
          query: query);
      notifyListeners();
    }
  }
}
