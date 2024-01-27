import 'package:flutter/material.dart';

import 'package:udemy_flutter_sns/constants/strings.dart';
import 'package:udemy_flutter_sns/details/text_field_container.dart';

class RoundedPasswordField extends StatelessWidget {
  RoundedPasswordField({
    Key? key,
    required this.onChanged,
    required this.passwordController,
    required this.obscureText,
    required this.toggleObscureText,
    required this.borderColor,
    required this.shadowColor,
  }) : super(key: key);
  final void Function(String)? onChanged;
  final TextEditingController passwordController;
  final bool obscureText;
  final void Function()? toggleObscureText;
  final Color borderColor, shadowColor;
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      borderColor: borderColor,
      shadowColor: shadowColor,
      child: TextFormField(
        keyboardType: TextInputType.visiblePassword,
        onChanged: onChanged,
        controller: passwordController,
        obscureText: obscureText,
        decoration: InputDecoration(
            suffix: InkWell(
              child: obscureText
                  ? Icon(Icons.visibility_off)
                  : Icon(Icons.visibility),
              onTap: toggleObscureText,
            ),
            hintText: passwordText,
            hintStyle: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
