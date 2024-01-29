import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udemy_flutter_sns/details/forget_password_text.dart';
import 'package:udemy_flutter_sns/details/rounded_button.dart';
import 'package:udemy_flutter_sns/details/rounded_password_field.dart';
import 'package:udemy_flutter_sns/details/rounded_text_field.dart';
import 'package:udemy_flutter_sns/models/login_model.dart';
//constants
import 'package:udemy_flutter_sns/constants/strings.dart';
import 'package:udemy_flutter_sns/constants/routes.dart' as routes;

class LoginPage extends ConsumerWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final LoginModel loginModel = ref.watch(loginProvider);
    final TextEditingController emailController =
        TextEditingController(text: loginModel.email);
    final TextEditingController passwordController =
        TextEditingController(text: loginModel.password);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(loginTitle),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RoundedTextField(
              keyboardType: TextInputType.emailAddress,
              onChanged: (text) => loginModel.email = text,
              controller: emailController,
              hintText: mailAddressText,
              borderColor: Colors.black,
              shadowColor: Colors.red),
          RoundedPasswordField(
              onChanged: (text) => loginModel.password = text,
              passwordController: passwordController,
              obscureText: loginModel.isObscure,
              toggleObscureText: () => loginModel.toggleIsObscure(),
              borderColor: Colors.black,
              shadowColor: Colors.blue),
          RoundedButton(
              onPressed: () async => await loginModel.login(context: context),
              widthRate: 0.85,
              color: Colors.green,
              text: loginText),
          TextButton(
            onPressed: () => routes.toSignupPage(context: context),
            child: const Text(noAccountMsg),
          ),
          const ForgetPasswordText()
        ],
      ),
    );
  }
}
