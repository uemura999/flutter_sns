//flutter
import 'package:flutter/material.dart';
//packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//constants
import 'package:udemy_flutter_sns/constants/enums.dart';
import 'package:udemy_flutter_sns/constants/others.dart';
import 'package:udemy_flutter_sns/constants/routes.dart' as routes;
import 'package:udemy_flutter_sns/constants/strings.dart';
import 'package:udemy_flutter_sns/constants/voids.dart' as voids;

final accountProvider = ChangeNotifierProvider((ref) => AccountModel());

class AccountModel extends ChangeNotifier {
  bool isObscure = true;
  User? currentUser = returnAuthUser();
  String password = "";
  ReauthenticationState reauthenticationState =
      ReauthenticationState.initialValue;

  Future<void> reauthenticateWithCredential(
      {required BuildContext context}) async {
    //まず再認証する
    //場合によりupdatePasswordかupdateEmailかの推移先を判別する
    currentUser = returnAuthUser();
    final String email = currentUser!.email!;
    //認証情報FirebaseAuthの大事な作業に必要
    final AuthCredential credential =
        EmailAuthProvider.credential(email: email, password: password);
    try {
      //エラーをcatchしたらその瞬間、tryの中の処理は中断される
      await currentUser!.reauthenticateWithCredential(credential);
      await voids.showFluttertoast(msg: reauthenticatedMsg);
      switch (reauthenticationState) {
        case ReauthenticationState.updatePassword:
          routes.toUpdatePasswordPage(context: context);
          break;
        case ReauthenticationState.updateEmail:
          routes.toUpdateEmailPage(context: context);
          break;
        default:
          break;
      }
    } on FirebaseAuthException catch (e) {
      String msg = '';
      switch (e.code) {
        case 'invalid-email':
          msg = invalidEmailMsg;
          break;
        case 'user-not-found':
          msg = userNotFoundMsg;
          break;
        case 'wrong-password':
          msg = wrongPasswordMsg;
          break;
        case 'user-mismatch':
          msg = userMismatchMsg;
          break;
        case 'invalid-credential':
          msg = invalidCredentialMsg;
          break;
      }
      await voids.showFluttertoast(msg: msg);
    }
  }

  void toggleIsObscure() {
    isObscure = !isObscure;
    notifyListeners();
  }
}
