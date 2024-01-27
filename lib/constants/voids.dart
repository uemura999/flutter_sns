//flutter
import 'package:flutter/material.dart';
//packages
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash/flash.dart';
import 'package:fluttertoast/fluttertoast.dart' as fluttertoast;
//constants
import 'package:udemy_flutter_sns/constants/bools.dart';

void showFlashBar({
  required BuildContext context,
  required TextEditingController textEditingController,
  required void Function(String)? onChanged,
  required String titleString,
  required Color primaryActionColor,
  required void Function(FlashController)? primaryAction,
}) {
  showFlash(
      context: context,
      persistent: true,
      builder: (context, controller) {
        return FlashBar(
          controller: controller,
          content: Form(
            child: TextFormField(
              controller: textEditingController,
              style: const TextStyle(fontWeight: FontWeight.bold),
              onChanged: onChanged,
              maxLength: 10,
            ),
          ),
          title: Text(titleString),
          //メインの動作
          primaryAction: InkWell(
            child: Icon(Icons.send, color: primaryActionColor),
            onTap: () => primaryAction?.call(controller),
          ),
          //閉じるときの動作
          actions: [
            InkWell(
              onTap: () async => await controller.dismiss(),
              child: const Icon(Icons.close),
            ),
          ],
        );
      });
}

//onRefreshの内部
Future<void> processNewDocs(
    {required List<String> muteUids,
    required List<DocumentSnapshot<Map<String, dynamic>>> docs,
    required Query<Map<String, dynamic>> query}) async {
  if (docs.isNotEmpty) {
    if (docs.isNotEmpty) {
      final qshot = await query.limit(30).endBeforeDocument(docs.first).get();
      final reversed = qshot.docs.reversed.toList();
      for (final doc in reversed) {
        if (isValidUser(muteUids: muteUids, doc: doc)) docs.insert(0, doc);
      }
    }
  }
}

//onReloadの内部
Future<void> processBasicDocs(
    {required List<String> muteUids,
    required List<DocumentSnapshot<Map<String, dynamic>>> docs,
    required Query<Map<String, dynamic>> query}) async {
  final qshot = await query.limit(30).get();
  for (final doc in qshot.docs) {
    //doc['uid']は投稿主のuid
    //!は否定演算子
    if (isValidUser(muteUids: muteUids, doc: doc)) docs.add(doc);
  }
}

//onLoadingの内部
Future<void> processOldDocs(
    {required List<String> muteUids,
    required List<DocumentSnapshot<Map<String, dynamic>>> docs,
    required Query<Map<String, dynamic>> query}) async {
  if (docs.isNotEmpty) {
    final qshot = await query.limit(30).startAfterDocument(docs.last).get();
    for (final doc in qshot.docs) {
      if (isValidUser(muteUids: muteUids, doc: doc)) docs.add(doc);
    }
  }
}

void showPopUp(
    {required BuildContext context,
    required Widget Function(BuildContext) builder}) {
  showCupertinoModalPopup(
    context: context,
    builder: builder,
  );
}

Future<void> showFluttertoast({required String msg}) async {
  //flashにToastが定義されているのでasを使って区別する
  await fluttertoast.Fluttertoast.showToast(
    msg: msg,
    toastLength: fluttertoast.Toast.LENGTH_SHORT,
    gravity: fluttertoast.ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.purple,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
