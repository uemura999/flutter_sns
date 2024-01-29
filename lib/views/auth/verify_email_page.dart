//flutter
import 'package:flutter/material.dart';
//packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
//constants
import 'package:udemy_flutter_sns/constants/strings.dart';
//models
import 'package:udemy_flutter_sns/models/auth/verify_email_model.dart';

class VerifyEmailPage extends ConsumerWidget {
  const VerifyEmailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final VerifyEmailModel verifyEmailModel = ref.watch(verifyEmailProvider);
    return Scaffold(
      //戻る機能つけないようにappBarは消しておく
      body: Container(
        alignment: Alignment.center,
        child: const Text(sendEmailVerificationMsg),
      ),
    );
  }
}
