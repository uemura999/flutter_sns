//flutter
import 'package:flutter/material.dart';
//packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
//constants
import 'package:udemy_flutter_sns/constants/strings.dart';
//models
import 'package:udemy_flutter_sns/models/auth/verify_password_reset_model.dart';
//components
import 'package:udemy_flutter_sns/views/auth/components/text_field_and_button_screen.dart';

class VerifyPasswordResetPage extends ConsumerWidget {
  const VerifyPasswordResetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final VerifyPasswordResetModel verifyPasswordResetModel =
        ref.watch(verifyPasswordResetProvider);
    final TextEditingController controller =
        TextEditingController(text: verifyPasswordResetModel.email);
    return TextFieldAndButtonScreen(
        appbarTitle: forgetPasswordPageTitle,
        buttonText: sendResetEmailText,
        hintText: loginMailAddressText,
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        shadowColor: Colors.red.withOpacity(0.3),
        buttonColor: Colors.redAccent,
        borderColor: Colors.black,
        onChanged: (value) => verifyPasswordResetModel.email = value,
        onPressed: () async => await verifyPasswordResetModel
            .sendPasswordResetEmail(context: context));
  }
}
