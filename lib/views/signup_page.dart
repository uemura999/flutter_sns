import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udemy_flutter_sns/constants/strings.dart';
import 'package:udemy_flutter_sns/details/rounded_button.dart';
import 'package:udemy_flutter_sns/details/rounded_password_field.dart';

import 'package:udemy_flutter_sns/models/signup_model.dart';

//components
import 'package:udemy_flutter_sns/details/rounded_text_field.dart';

class SignupPage extends ConsumerWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SignupModel signupModel = ref.watch(signupProvider);
    final TextEditingController emailController =
        TextEditingController(text: signupModel.email);
    final TextEditingController passwordController =
        TextEditingController(text: signupModel.password);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(signupTitle),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RoundedTextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            onChanged: (text) => signupModel.email = text,
            borderColor: Colors.black,
            shadowColor: Colors.purple,
            hintText: mailAddressText,
          ),
          RoundedPasswordField(
              onChanged: (text) => signupModel.password = text,
              passwordController: passwordController,
              obscureText: signupModel.isObscure,
              toggleObscureText: () => signupModel.toggleIsObscure(),
              borderColor: Colors.black,
              shadowColor: Colors.orange),
          RoundedButton(
            onPressed: () async =>
                await signupModel.createUser(context: context),
            widthRate: 0.5,
            color: Colors.red,
            text: signupText,
          )
        ],
      ),
    );
  }
}
