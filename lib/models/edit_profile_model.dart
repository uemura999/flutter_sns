//flutter
import 'package:flutter/material.dart';
//packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:udemy_flutter_sns/constants/lists.dart';
import 'package:udemy_flutter_sns/constants/maps.dart';
//constants
import 'package:udemy_flutter_sns/constants/others.dart';
import 'package:udemy_flutter_sns/constants/strings.dart';
//domain
import 'package:udemy_flutter_sns/domain/user_update_log/user_update_log.dart';
//models
import 'package:udemy_flutter_sns/models/main_model.dart';

final editProfileProvider = ChangeNotifierProvider((ref) => EditProfileModel());

class EditProfileModel extends ChangeNotifier {
  File? croppedFile = null;
  String userName = '';

  Future<void> updateUserInfo(
      {required BuildContext context, required MainModel mainModel}) async {
    //ひとつ前の画面に戻る
    String userImageURL = '';
    //userNameとcroppedFileが両方nullの場合は何もしない
    if (!(userName.isEmpty && croppedFile == null)) {
      //userNameとcroppedFileどちらかの情報がある状態
      final currentUserDoc = mainModel.currentUserDoc;
      final firestoreUser = mainModel.firestoreUser;
      if (croppedFile != null) {
        userImageURL = await uploadImageAndGetURL(
            uid: currentUserDoc.id, file: croppedFile!);
      } else {
        //croppedFileがnullの場合
        userImageURL = firestoreUser.userImageURL;
      }
      if (userName.isEmpty) {
        //userNameがnullの場合
        userName = firestoreUser.userName;
      }
      mainModel.updateFrontUserInfo(
          newUserName: userName, newUserImageURL: userImageURL);
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      //idを指定する必要がない。なぜならアプリから呼び出すことがないなく、消すこともないから
      //.doc()とすることで自動でidが割り振られる
      final UserUpdateLog updateLog = UserUpdateLog(
          logCreatedAt: Timestamp.now(),
          searchToken: returnSearchToken(
              searchWords: returnSearchWords(searchTerm: userName)),
          userName: userName,
          userImageURL: userImageURL,
          userRef: currentUserDoc.reference,
          uid: currentUserDoc.id);
      await currentUserDoc.reference
          .collection('userUpdateLogs')
          .doc()
          .set(updateLog.toJson());
    } else {
      //userNameとcroppedFileどちらもnullの場合
      Navigator.pop(context);
    }
  }

  Future<String> uploadImageAndGetURL(
      {required String uid, required File file}) async {
    final String fileName = returnJpgFileName();
    final Reference storageRef = FirebaseStorage.instance
        .ref()
        .child("users")
        .child(uid)
        .child(fileName);
    //users/uid/fileName にアップロード
    await storageRef.putFile(file);
    //users/uid/fileName のダウンロードURLを取得
    return await storageRef.getDownloadURL();
  }

  Future<void> onImageTapped() async {
    final XFile? xFile = await returnXFile();
    if (xFile == null) {
      return;
    }
    croppedFile = await returnCroppedFile(xFile: xFile);
    notifyListeners();
  }

  // Future<void> async {}
}
