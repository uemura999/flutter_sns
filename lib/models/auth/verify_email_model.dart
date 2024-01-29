//flutter
import 'package:flutter/material.dart';
//packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//constants
import 'package:udemy_flutter_sns/constants/others.dart';

final verifyEmailProvider = ChangeNotifierProvider((ref) => VerifyEmailModel());

class VerifyEmailModel extends ChangeNotifier {
  VerifyEmailModel() {
    init();
  }
  Future<void> init() async {
    final User user = returnAuthUser()!;
    //メールアドレスの確認メールを送信する
    await user.sendEmailVerification();
  }
}
