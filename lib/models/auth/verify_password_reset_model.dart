//flutter
import 'package:flutter/material.dart';
//packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//constants
import 'package:udemy_flutter_sns/constants/strings.dart';
import 'package:udemy_flutter_sns/constants/voids.dart' as voids;

final verifyPasswordResetProvider =
    ChangeNotifierProvider((ref) => VerifyPasswordResetModel());

class VerifyPasswordResetModel extends ChangeNotifier {
  String email = "";

  Future<void> sendPasswordResetEmail({required BuildContext context}) async {
    try {
      //passwordをresetするためのメールを送る
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      await voids.showFluttertoast(msg: passwordResetEmailSentMsg);
    } on FirebaseAuthException catch (e) {
      String msg = '';
      switch (e.code) {
        case 'invalid-email':
          msg = invalidEmailMsg;
          break;
        case 'auth/missing-android-pkg-name':
          msg = missingAndroidPkgNameMsg;
          break;
        case 'auth/missing-ios-bundle-id':
          msg = missingIosBundleIdMsg;
          break;
        case 'user-not-found':
          msg = userNotFoundMsg;
          break;
        default:
          msg = somethingWentWrongMsg;
      }
      await voids.showFluttertoast(msg: msg);
    }
  }
}
