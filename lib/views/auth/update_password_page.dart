//flutter
import 'package:flutter/material.dart';
//packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
//constants
import 'package:udemy_flutter_sns/constants/strings.dart';
//components
import 'package:udemy_flutter_sns/views/auth/components/password_field_and_button_screen.dart';
//models
import 'package:udemy_flutter_sns/models/auth/update_password_model.dart';

class UpdatePasswordPage extends ConsumerWidget {
  const UpdatePasswordPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UpdatePasswordModel updatePasswordModel =
        ref.watch(updatePasswordProvider);
    final TextEditingController passwordController =
        TextEditingController(text: updatePasswordModel.newPassword);
    return PasswordFieldAndButtonScreen(
        appBarTitle: updatePasswordPageTitle,
        buttonText: updatePasswordText,
        buttonColor: Colors.orange.withOpacity(0.5),
        shadowColor: Colors.green.withOpacity(0.3),
        reauthenticateText: reauthenticateText,
        passwordController: passwordController,
        onChanged: (value) => updatePasswordModel.newPassword = value,
        obscureText: updatePasswordModel.isObscure,
        toggleObscureText: () => updatePasswordModel.toggleIsObscure(),
        onPressed: () async =>
            await updatePasswordModel.updatePassword(context: context));
  }
}
