// flutter
import 'package:flutter/material.dart';
// components
import 'package:udemy_flutter_sns/details/rounded_button.dart';
import 'package:udemy_flutter_sns/details/rounded_text_field.dart';

class TextFieldAndButtonScreen extends StatelessWidget {
  const TextFieldAndButtonScreen(
      {Key? key,
      required this.appbarTitle,
      required this.buttonText,
      required this.hintText,
      required this.controller,
      required this.keyboardType,
      required this.shadowColor,
      required this.buttonColor,
      required this.borderColor,
      required this.onChanged,
      required this.onPressed})
      : super(key: key);

  final String appbarTitle, buttonText, hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Color shadowColor, buttonColor, borderColor;
  final void Function(String)? onChanged;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appbarTitle),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: RoundedTextField(
                keyboardType: keyboardType,
                onChanged: onChanged,
                controller: controller,
                shadowColor: shadowColor,
                borderColor: borderColor,
                hintText: hintText),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 64.0),
            child: RoundedButton(
              onPressed: onPressed,
              widthRate: 0.85,
              color: buttonColor,
              text: buttonText,
            ),
          )
        ],
      ),
    );
  }
}
