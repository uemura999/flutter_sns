// flutter
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
// constants
import 'package:udemy_flutter_sns/constants/enums.dart';
import 'package:udemy_flutter_sns/constants/others.dart';
import 'package:udemy_flutter_sns/constants/strings.dart';
import 'package:udemy_flutter_sns/constants/routes.dart' as routes;
// models
import 'package:udemy_flutter_sns/models/auth/account_model.dart';
import 'package:udemy_flutter_sns/models/main_model.dart';

class AccountPage extends ConsumerWidget {
  const AccountPage({Key? key, required this.mainModel}) : super(key: key);
  final MainModel mainModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AccountModel accountModel = ref.watch(accountProvider);
    final firestoreUser = mainModel.firestoreUser;
    final l10n = returnL10n(context: context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(accountTitle),
      ),
      body: ListView(
        children: [
          ListTile(
              title: const Text(updatePasswordText),
              trailing: const Icon(Icons.arrow_forward_ios),
              // reauthenticationするページに飛ばす
              onTap: () {
                accountModel.reauthenticationState =
                    ReauthenticateState.updatePassword;
                routes.toReauthenticationPage(
                    context: context, firestoreUser: firestoreUser);
              }),
          ListTile(
              // emailが更新が反映されるまで時間がかかる可能性がある
              title: Text(updateEmailLagMsg(email: returnAuthUser()!.email!)),
              trailing: const Icon(Icons.arrow_forward_ios),
              // reauthenticationするページに飛ばす
              onTap: () {
                accountModel.reauthenticationState =
                    ReauthenticateState.updateEmail;
                routes.toReauthenticationPage(
                    context: context, firestoreUser: firestoreUser);
              }),
          ListTile(
              title: Text(l10n.deleteUser),
              trailing: const Icon(Icons.arrow_forward_ios),
              // reauthenticationするページに飛ばす
              onTap: () {
                accountModel.reauthenticationState =
                    ReauthenticateState.deleteUser;
                routes.toReauthenticationPage(
                    context: context, firestoreUser: firestoreUser);
              }),
          ListTile(
            title: const Text(logoutText),
            onTap: () async => await accountModel.logout(context: context),
          )
        ],
      ),
    );
  }
}
