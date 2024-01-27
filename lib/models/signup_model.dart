//flutter
import 'package:flutter/material.dart';
//package
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//constants
import 'package:udemy_flutter_sns/constants/others.dart';
import 'package:udemy_flutter_sns/constants/strings.dart';
import 'package:udemy_flutter_sns/constants/voids.dart' as voids;
import 'package:udemy_flutter_sns/constants/routes.dart' as routes;
//domain
import 'package:udemy_flutter_sns/domain/firestore_user/firestore_user.dart';

final signupProvider = ChangeNotifierProvider((ref) => SignupModel());

class SignupModel extends ChangeNotifier {
  final User? currentUser = returnAuthUser();
  String email = "";
  String password = "";
  bool isObscure = true;

  Future<void> createFirestoreUser(
      {required BuildContext context, required String uid}) async {
    final Timestamp now = Timestamp.now();
    final FirestoreUser firestoreUser = FirestoreUser(
      createdAt: now,
      followerCount: 0,
      followingCount: 0,
      isAdmin: false,
      muteCount: 0,
      updatedAt: now,
      uid: uid,
      userName: aliceName,
      userImageURL: '',
    );
    final Map<String, dynamic> userData = firestoreUser.toJson();

    await FirebaseFirestore.instance
        .collection(usersFieldKey)
        .doc(uid)
        .set(userData);
    await voids.showFluttertoast(msg: 'ユーザー登録が完了しました');
    notifyListeners();
  }

  Future<void> createUser({required BuildContext context}) async {
    try {
      UserCredential result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      final User? user = result.user;
      final String uid = user!.uid;

      await createFirestoreUser(context: context, uid: uid);
      routes.toMyApp(context: context);
    } on FirebaseAuthException catch (e) {
      final String errorCode = e.code;
      switch (errorCode) {
        case 'email-already-in-use':
          await voids.showFluttertoast(msg: emailAlredyInUseMsg);
          break;
        case 'operation-not-allowed':
          //Firebaseでemail/passwordが許可されていない
          //開発側の過失
          debugPrint(firebaseAuthEmailOperationNotAllowedMsg);
          break;
        case 'weak-password':
          await voids.showFluttertoast(msg: weakPasswordMsg);
          break;
        case 'invalid-email':
          await voids.showFluttertoast(msg: invalidEmailMsg);
          break;
      }
    }
  }

  void toggleIsObscure() {
    isObscure = !isObscure;
    notifyListeners();
  }
}
