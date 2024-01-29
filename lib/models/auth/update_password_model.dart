//flutter
import 'package:flutter/material.dart';
//packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//constants
import 'package:udemy_flutter_sns/constants/others.dart';
import 'package:udemy_flutter_sns/constants/strings.dart';
import 'package:udemy_flutter_sns/constants/voids.dart' as voids;

final updatePasswordProvider =
    ChangeNotifierProvider((ref) => UpdatePasswordModel());

class UpdatePasswordModel extends ChangeNotifier {
  String newPassword = "";
  bool isObscure = true;

  void toggleIsObscure() {
    isObscure = !isObscure;
    notifyListeners();
  }

  Future<void> updatePassword({required BuildContext context}) async {
    final User user = returnAuthUser()!;
    try {
      await user.updatePassword(newPassword);
      Navigator.pop(context);
      Navigator.pop(context);
      const String msg = updatedPasswordMsg;
      await voids.showFluttertoast(msg: msg);
    } on FirebaseAuthException catch (e) {
      String msg = '';
      switch (e.code) {
        case 'weak-password':
          msg = weakPasswordMsg;
          break;
        case 'requires-recent-login':
          msg = requiresRecentLoginMsg;
          break;
        default:
          msg = somethingWentWrongMsg;
      }
      await voids.showFluttertoast(msg: msg);
    }
  }
}
