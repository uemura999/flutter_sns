// flutter
import 'package:flutter/material.dart';
// packages
import 'package:firebase_auth/firebase_auth.dart';
// constants
import 'package:udemy_flutter_sns/constants/others.dart';
import 'package:udemy_flutter_sns/constants/strings.dart';
import 'package:udemy_flutter_sns/constants/voids.dart' as voids;
// components
import 'package:udemy_flutter_sns/views/auth/components/text_field_and_button_screen.dart';

class UpdateEmailPage extends StatelessWidget {
  const UpdateEmailPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String newEmail = "";
    final TextEditingController controller = TextEditingController();
    // 簡単な処理で済むのでModelはいらない
    return TextFieldAndButtonScreen(
        appbarTitle: updateEmailPageTitle,
        buttonText: updateEmailText,
        hintText: mailAddressText,
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        shadowColor: Colors.yellowAccent.withOpacity(0.25),
        buttonColor: Colors.purpleAccent,
        borderColor: Colors.black,
        onChanged: (value) => newEmail = value,
        onPressed: () async {
          final User user = returnAuthUser()!;
          // メールアドレスを認証するためにメールが送られる
          await user.verifyBeforeUpdateEmail(newEmail);
          await voids.showFluttertoast(msg: emailSendedMsg);
          Navigator.pop(context);
          Navigator.pop(context);
        });
  }
}
