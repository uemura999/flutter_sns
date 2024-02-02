//flutter
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//constants
import 'package:udemy_flutter_sns/constants/enums.dart';
import 'package:udemy_flutter_sns/constants/others.dart';
import 'package:udemy_flutter_sns/constants/routes.dart' as routes;
import 'package:udemy_flutter_sns/constants/strings.dart';
import 'package:udemy_flutter_sns/constants/voids.dart' as voids;
//domain
import 'package:udemy_flutter_sns/domain/firestore_user/firestore_user.dart';

final accountProvider = ChangeNotifierProvider((ref) => AccountModel());

class AccountModel extends ChangeNotifier {
  bool isObscure = true;
  User? currentUser = returnAuthUser();
  String password = "";
  ReauthenticateState reauthenticationState = ReauthenticateState.initialValue;

  Future<void> reauthenticateWithCredential(
      {required BuildContext context,
      required FirestoreUser firestoreUser}) async {
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
        case ReauthenticateState.updatePassword:
          routes.toUpdatePasswordPage(context: context);
          break;
        case ReauthenticateState.updateEmail:
          routes.toUpdateEmailPage(context: context);
          break;
        case ReauthenticateState.deleteUser:
          //ユーザーを削除するDialogを表示する
          showDeleteUserDialog(context: context, firestoreUser: firestoreUser);
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

  void setCurrentUser() {
    returnAuthUser();
    notifyListeners();
  }

  void toggleIsObscure() {
    isObscure = !isObscure;
    notifyListeners();
  }

  Future<void> logout({required BuildContext context}) async {
    final String msg = returnL10n(context: context).logoutedMsg;
    routes.toFinishedPage(context: context, msg: msg);
    await FirebaseAuth.instance.signOut();
    // ignore: use_build_context_synchronously
  }

  void showDeleteUserDialog(
      {required BuildContext context, required FirestoreUser firestoreUser}) {
    final l10n = returnL10n(context: context);
    //ユーザーを削除するDialogを表示する
    showCupertinoModalPopup(
        context: context,
        builder: (innerContext) => CupertinoAlertDialog(
                content: Text(l10n.deleteUserAlertMsg),
                actions: <CupertinoDialogAction>[
                  CupertinoDialogAction(
                    /// This parameter indicates this action is the default,
                    /// and turns the action's text to bold text.
                    isDefaultAction: true,
                    onPressed: () => Navigator.pop(innerContext),
                    child: const Text(noText),
                  ),
                  CupertinoDialogAction(
                    /// This parameter indicates this action is the default,
                    /// and turns the action's text to bold text.
                    isDefaultAction: true,
                    onPressed: () async => await deleteUser(
                        context: context, firestoreUser: firestoreUser),
                    child: const Text(yesText),
                  ),
                ]));
  }

  Future<void> deleteUser(
      {required BuildContext context,
      required FirestoreUser firestoreUser}) async {
    //ユーザーの削除にはReauthenticationが必要
    final l10n = returnL10n(context: context);
    final String msg = l10n.userDeletedMsg;
    routes.toFinishedPage(context: context, msg: msg);
    //ユーザーの削除はFirebaseAuthのトークンがないといけない
    //Documentの方を削除　→ FirebaseAuthのユーザーを削除　（DeleteUserの作成）
    final User currentUser = returnAuthUser()!;
    //deleteUserを作成する
    try {
      await FirebaseFirestore.instance
          .collection('deleteUsers')
          .doc(currentUser.uid)
          .set(firestoreUser.toJson())
          .then((_) => currentUser.delete());
    } on FirebaseAuthException catch (e) {
      String msg = '';
      if (e.code == 'requires-recent-login') {
        msg = l10n.requiresRecentLoginMsg;
        await voids.showFluttertoast(msg: msg);
      }

      //finishedPageに移動する
    }
  }
}
