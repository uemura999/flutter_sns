//flutter
import 'package:flutter/material.dart';
//constants
import 'package:udemy_flutter_sns/constants/strings.dart';
//components
import 'package:udemy_flutter_sns/details/rounded_button.dart';

class ReloadScreen extends StatelessWidget {
  ReloadScreen({Key? key, required this.onReload}) : super(key: key);
  final void Function()? onReload;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: RoundedButton(
              onPressed: onReload,
              widthRate: 0.85,
              color: Colors.green,
              text: reloadText),
        )
      ],
    );
  }
}
