//flutter
import 'package:flutter/material.dart';
//packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//domain
import 'package:udemy_flutter_sns/domain/firestore_user/firestore_user.dart';

final searchProvider = ChangeNotifierProvider((ref) => SearchModel());

class SearchModel extends ChangeNotifier {
  List<FirestoreUser> users = [];
  SearchModel() {
    init();
  }

  Future<void> init() async {
    final QuerySnapshot<Map<String, dynamic>> qshot =
        await FirebaseFirestore.instance.collection('users').get();
    final List<DocumentSnapshot<Map<String, dynamic>>> docs = qshot.docs;
    users = docs.map((e) => FirestoreUser.fromJson(e.data()!)).toList();
    notifyListeners();
  }
}
