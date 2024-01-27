import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//constants
import 'package:udemy_flutter_sns/constants/routes.dart' as routes;

final loginProvider = ChangeNotifierProvider((ref) => LoginModel());

class LoginModel extends ChangeNotifier {
  String email = "";
  String password = "";
  bool isObscure = true;

  Future<void> login({required BuildContext context}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      routes.toMyApp(context: context);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
  }

  void toggleIsObscure() {
    isObscure = !isObscure;
    notifyListeners();
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
