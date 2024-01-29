//Return except int, String

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//packages
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:udemy_flutter_sns/constants/strings.dart';

Future<XFile?> returnXFile() async {
  final ImagePicker picker = ImagePicker();

  //Pick an image
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  if (image == null) return null;
  return image;
}

Future<File?> returnCroppedFile({required XFile? xFile}) async {
  final instance = ImageCropper();
  final File? result = await instance.cropImage(
      sourcePath: xFile!.path,
      aspectRatioPresets: [CropAspectRatioPreset.square],
      androidUiSettings: const AndroidUiSettings(
          toolbarTitle: cropperTitle,
          toolbarColor: Colors.green,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: false),
      iosUiSettings: const IOSUiSettings(
          title: cropperTitle, aspectRatioLockEnabled: false));
  return result;
}

User? returnAuthUser() => FirebaseAuth.instance.currentUser;

DocumentReference<Map<String, dynamic>> userDocToTokenDocRef(
        {required DocumentSnapshot<Map<String, dynamic>> userDoc,
        required String tokenId}) =>
    userDoc.reference.collection('tokens').doc(tokenId);

Query<Map<String, dynamic>> returnSearchQuery(
    {required List<String> searchWords}) {
  Query<Map<String, dynamic>> query =
      FirebaseFirestore.instance.collection('users').limit(30);
  for (final searchWord in searchWords) {
    query = query.where('searchToken.$searchWord', isEqualTo: true);
  }
  return query;
}
