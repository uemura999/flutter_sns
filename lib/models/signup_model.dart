// flutter
import 'package:flutter/material.dart';
// package
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udemy_flutter_sns/constants/lists.dart';
import 'package:udemy_flutter_sns/constants/maps.dart';
import 'package:udemy_flutter_sns/constants/strings.dart';
// domain
import 'package:udemy_flutter_sns/domain/firestore_user/firestore_user.dart';
// constants
import 'package:udemy_flutter_sns/constants/routes.dart' as routes;
import 'package:udemy_flutter_sns/constants/voids.dart' as voids;

final signupProvider = ChangeNotifierProvider((ref) => SignupModel());

class SignupModel extends ChangeNotifier {
  int counter = 0;
  User? currentUser;
  // auth
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
      searchToken: returnSearchToken(
          searchWords: returnSearchWords(searchTerm: "Alice")),
      postCount: 0,
      uid: uid,
      updatedAt: now,
      userName: "Alice",
      userImageURL: "",
      userNameLanguageCode: "",
      userNameNegativeScore: 0.0,
      userNamePositiveScore: 0.0,
      userNameSentiment: "",
    );
    final Map<String, dynamic> userData = firestoreUser.toJson();
    await FirebaseFirestore.instance.collection("users").doc(uid).set(userData);
    await voids.showFluttertoast(msg: userCreatedMsg);
    notifyListeners();
  }

  Future<void> createUser({required BuildContext context}) async {
    try {
      final result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final User? user = result.user;
      final String uid = user!.uid;
      await createFirestoreUser(context: context, uid: uid);
      routes.toVerifyEmailPage(context: context);
    } on FirebaseAuthException catch (e) {
      final String errorCode = e.code;
      String msg = "";
      switch (errorCode) {
        case "email-already-in-use":
          msg = emailAlreadyInUseMsg;
          break;
        case "operation-not-allowed":
          // Firebaseでemail/passwordが許可されていない
          // 開発側の過失
          msg = firebaseAuthEmailOperationNotAllowed;
          break;
        case "weak-password":
          msg = weakPasswordMsg;
          break;
        case "invalid-email":
          msg = invalidEmailMsg;
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
