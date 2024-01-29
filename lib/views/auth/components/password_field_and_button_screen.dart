//flutter
import 'package:flutter/material.dart';
//components
import 'package:udemy_flutter_sns/details/rounded_button.dart';
import 'package:udemy_flutter_sns/details/rounded_password_field.dart';

class PasswordFieldAndButtonScreen extends StatelessWidget {
  const PasswordFieldAndButtonScreen({
    Key? key,
    required this.appBarTitle,
    required this.buttonText,
    required this.buttonColor,
    required this.shadowColor,
    required this.reauthenticateText,
    required this.passwordController,
    required this.onChanged,
    required this.obscureText,
    required this.toggleObscureText,
    required this.onPressed,
  }) : super(key: key);
  final String appBarTitle, reauthenticateText;
  final Color shadowColor, buttonColor;
  final TextEditingController passwordController;
  final void Function(String) onChanged;
  final bool obscureText;
  final void Function()? toggleObscureText;
  final void Function()? onPressed;
  final String buttonText;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(appBarTitle),
        ),
        body: Column(
          children: [
            Center(
                child: RoundedPasswordField(
              onChanged: onChanged,
              passwordController: passwordController,
              obscureText: obscureText,
              toggleObscureText: () => toggleObscureText,
              borderColor: Colors.black,
              shadowColor: shadowColor,
            )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 64.0),
              child: RoundedButton(
                  //まず再認証する
                  //場合によりupdatePasswordかupdateEmailかの推移先を判別する
                  onPressed: onPressed,
                  widthRate: 0.85,
                  color: buttonColor,
                  text: buttonText),
            )
          ],
        ));
  }
}
