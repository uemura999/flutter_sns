// flutter
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
// constants
import 'package:udemy_flutter_sns/constants/strings.dart';
// components
import 'package:udemy_flutter_sns/details/rounded_text_field.dart';
import 'package:udemy_flutter_sns/details/rounded_password_field.dart';
import 'package:udemy_flutter_sns/details/rounded_button.dart';
// models
import 'package:udemy_flutter_sns/models/signup_model.dart';

class SignupPage extends ConsumerWidget {
  const SignupPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SignupModel signupModel = ref.watch(signupProvider);
    final TextEditingController emailEditingController =
        TextEditingController(text: signupModel.email);
    final TextEditingController passwordEditingController =
        TextEditingController(text: signupModel.password);
    return Scaffold(
      appBar: AppBar(
        title: const Text(signupTitle),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RoundedTextField(
              controller: emailEditingController,
              keyboardType: TextInputType.emailAddress,
              onChanged: (text) => signupModel.email = text,
              borderColor: Colors.black,
              shadowColor: const Color(0xFF77BFA3).withOpacity(0.3),
              hintText: mailAddressText),
          RoundedPasswordField(
              onChanged: (text) => signupModel.password = text,
              passwordController: passwordEditingController,
              obscureText: signupModel.isObscure,
              toggleObscureText: () => signupModel.toggleIsObscure(),
              borderColor: Colors.black,
              shadowColor: const Color(0xFFEDEEC9)),
          RoundedButton(
              onPressed: () async =>
                  await signupModel.createUser(context: context),
              widthRate: 0.85,
              color: Colors.red.withOpacity(0.5),
              text: signupText)
        ],
      ),
    );
  }
}
