//flutter
import 'package:flutter/material.dart';
//packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
//constants
import 'package:udemy_flutter_sns/constants/ints.dart';
import 'package:udemy_flutter_sns/constants/lists.dart';
import 'package:udemy_flutter_sns/constants/others.dart';
import 'package:udemy_flutter_sns/constants/voids.dart' as voids;
import 'package:udemy_flutter_sns/domain/timeline/timeline.dart';

final homeProvider = ChangeNotifierProvider((ref) => HomeModel());

class HomeModel extends ChangeNotifier {
  //followingの投稿を取得する
  List<DocumentSnapshot<Map<String, dynamic>>> postDocs = [];
  List<DocumentSnapshot<Map<String, dynamic>>> timelineDocs = [];
  User currentUser = returnAuthUser()!;
  List<String> muteUids = [];
  List<String> mutePostIds = [];
  RefreshController refreshController = RefreshController();
  Query<Map<String, dynamic>> returnQuery(
      {required QuerySnapshot<Map<String, dynamic>> timelinesQshot}) {
    //timelineを取得したい
    // List<String> max10TimelinePostIds = [];
    // for (final timelineDoc in timelinesQshot.docs) {
    //   final timeline = Timeline.fromJson(timelineDoc.data());
    //   max10TimelinePostIds.add(timeline.postId);
    // } をしている↓
    final List<String> max10TimelinePostIds = timelinesQshot.docs
        .map((e) => Timeline.fromJson(e.data()).postId)
        .toList();
    if (max10TimelinePostIds.isEmpty) {
      max10TimelinePostIds.add(""); //whereInの中身が空だとerrorを返すので、空文字を入れておく
    }
    return FirebaseFirestore.instance
        .collectionGroup('posts')
        .where('postId', whereIn: max10TimelinePostIds)
        .limit(tenCount);
  }

  HomeModel() {
    init();
  }

  Future<void> init() async {
    final muteUidsAndMutePostIds = await returnMuteUidsAndMutePostIds();
    muteUids = muteUidsAndMutePostIds.first;
    mutePostIds = muteUidsAndMutePostIds.last;
    await onReload();
  }

  Future<void> onRefresh() async {
    final timelinesQshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .collection('timelines')
        .orderBy('createdAt', descending: true)
        .endBeforeDocument(timelineDocs.first)
        .limit(tenCount)
        .get();
    for (final timelineDoc in timelinesQshot.docs.reversed.toList()) {
      timelineDocs.insert(0, timelineDoc);
    }
    refreshController.refreshCompleted();
    await voids.processNewDocs(
        muteUids: muteUids,
        mutePostIds: mutePostIds,
        docs: postDocs,
        query: returnQuery(timelinesQshot: timelinesQshot));
    notifyListeners();
  }

  Future<void> onReload() async {
    final timelinesQshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .collection('timelines')
        .orderBy('createdAt', descending: true)
        .limit(tenCount)
        .get();
    timelineDocs = timelinesQshot.docs;
    if (timelineDocs.isNotEmpty) {
      await voids.processBasicDocs(
          muteUids: muteUids,
          mutePostIds: mutePostIds,
          docs: postDocs,
          query: returnQuery(timelinesQshot: timelinesQshot));
    }
    notifyListeners();
  }

  Future<void> onLoading() async {
    refreshController.loadComplete();
    final timelinesQshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .collection('timelines')
        .orderBy('createdAt', descending: true)
        .startAfterDocument(timelineDocs.last)
        .limit(tenCount)
        .get();
    for (final timelineDoc in timelinesQshot.docs) {
      timelineDocs.add(timelineDoc);
    }
    await voids.processOldDocs(
        muteUids: muteUids,
        mutePostIds: mutePostIds,
        docs: postDocs,
        query: returnQuery(timelinesQshot: timelinesQshot));
    notifyListeners();
  }
}
