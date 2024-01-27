import 'package:flutter/material.dart';
//constants
import 'package:udemy_flutter_sns/constants/strings.dart';
import 'package:udemy_flutter_sns/models/main_model.dart';

class AccountPage extends StatelessWidget {
  AccountPage({Key? key, required this.mainModel}) : super(key: key);
  final MainModel mainModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(accountTitle),
        ),
        body: ListView(
          children: [
            ListTile(
              title: Text(logoutText),
              onTap: () async => await mainModel.logout(context: context),
            )
          ],
        ));
  }
}
