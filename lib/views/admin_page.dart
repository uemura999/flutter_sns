//flutter
import 'package:flutter/material.dart';
//packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
//constants
import 'package:udemy_flutter_sns/constants/strings.dart';
import 'package:udemy_flutter_sns/details/rounded_button.dart';
//models
import 'package:udemy_flutter_sns/models/admin_model.dart';
import 'package:udemy_flutter_sns/models/main_model.dart';
import 'package:udemy_flutter_sns/models/mute_users_model.dart';

class AdminPage extends ConsumerWidget {
  const AdminPage({Key? key, required this.mainModel}) : super(key: key);
  final MainModel mainModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AdminModel adminModel = ref.watch(adminProvider);
    final MuteUsersModel muteUsersModel = ref.watch(muteUsersProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(adminTitle),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: RoundedButton(
                onPressed: () => adminModel.admin(
                    currentUserDoc: mainModel.currentUserDoc,
                    firestoreUser: mainModel.firestoreUser,
                    muteUsersModel: muteUsersModel),
                widthRate: 0.85,
                color: Colors.blue,
                text: adminTitle),
          )
        ],
      ),
    );
  }
}
