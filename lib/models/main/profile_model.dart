//flutter
import 'package:flutter/material.dart';
//packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:udemy_flutter_sns/constants/lists.dart';
import 'package:udemy_flutter_sns/constants/others.dart';
//constants
import 'package:udemy_flutter_sns/constants/voids.dart' as voids;

final profileProvider = ChangeNotifierProvider((ref) => ProfileModel());

class ProfileModel extends ChangeNotifier {
  //自分の投稿を取得する
  List<DocumentSnapshot<Map<String, dynamic>>> postDocs = [];
  final RefreshController refreshController = RefreshController();
  List<String> muteUids = [];
  Query<Map<String, dynamic>> returnQuery() {
    final User? currentUser = returnAuthUser();
    return FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser!.uid)
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .limit(30);
  }

  ProfileModel() {
    init();
  }

  Future<void> init() async {
    muteUids = await returnMuteUids();
    await onReload();
  }

  Future<void> onRefresh() async {
    refreshController.refreshCompleted();
    await voids.processNewDocs(
        muteUids: muteUids, docs: postDocs, query: returnQuery());
    notifyListeners();
  }

  Future<void> onReload() async {
    await voids.processBasicDocs(
        muteUids: muteUids, docs: postDocs, query: returnQuery());
    notifyListeners();
  }

  Future<void> onLoading() async {
    refreshController.loadComplete();
    await voids.processOldDocs(
        muteUids: muteUids, docs: postDocs, query: returnQuery());
    notifyListeners();
  }
}
