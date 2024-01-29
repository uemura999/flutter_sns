//flutter
import 'package:flutter/material.dart';
//packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
//constants
import 'package:udemy_flutter_sns/constants/strings.dart';
//models
import 'package:udemy_flutter_sns/models/auth/account_model.dart';
import 'package:udemy_flutter_sns/views/auth/components/password_field_and_button_screen.dart';

class ReauthenticationPage extends ConsumerWidget {
  const ReauthenticationPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AccountModel accountModel = ref.watch(accountProvider);
    final TextEditingController passwordController =
        TextEditingController(text: accountModel.password);
    return PasswordFieldAndButtonScreen(
        appBarTitle: reauthenticationPageTitle,
        buttonText: reauthenticateText,
        buttonColor: Colors.orange.withOpacity(0.5),
        shadowColor: Colors.green.withOpacity(0.3),
        reauthenticateText: reauthenticateText,
        passwordController: passwordController,
        onChanged: (value) => accountModel.password = value,
        obscureText: accountModel.isObscure,
        toggleObscureText: () => accountModel.toggleIsObscure(),
        onPressed: () async =>
            await accountModel.reauthenticateWithCredential(context: context));
  }
}
