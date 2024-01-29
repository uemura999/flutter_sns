//flutter
import 'package:flutter/material.dart';
//packages
import 'package:flutter/gestures.dart';
//constants
import 'package:udemy_flutter_sns/constants/routes.dart' as routes;
import 'package:udemy_flutter_sns/constants/strings.dart';

class ForgetPasswordText extends StatelessWidget {
  const ForgetPasswordText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text:
            TextSpan(style: TextStyle(fontWeight: FontWeight.bold), children: [
          TextSpan(
              text: forgetPasswordText,
              style: TextStyle(color: Colors.lightGreen),
              recognizer: TapGestureRecognizer()
                ..onTap =
                    () => routes.toVerifyPasswordResetPage(context: context)),
        ]),
      ),
    );
  }
}
