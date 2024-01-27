//flutter
import 'package:flutter/material.dart';
//packages
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//constants
import 'package:udemy_flutter_sns/constants/strings.dart';
import 'package:udemy_flutter_sns/constants/voids.dart' as voids;
//components
import 'package:udemy_flutter_sns/details/rounded_button.dart';
//domain
import 'package:udemy_flutter_sns/domain/firestore_user/firestore_user.dart';
//models
import 'package:udemy_flutter_sns/models/main_model.dart';
import 'package:udemy_flutter_sns/models/mute_users_model.dart';
import 'package:udemy_flutter_sns/views/refresh_screen.dart';

class MuteUsersPage extends ConsumerWidget {
  const MuteUsersPage({Key? key, required this.mainModel}) : super(key: key);
  final MainModel mainModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MuteUsersModel muteUsersModel = ref.watch(muteUsersProvider);
    final muteUserDocs = muteUsersModel.muteUserDocs;
    return Scaffold(
      appBar: AppBar(title: const Text(muteUsersPageTitle)),
      body: muteUsersModel.showMuteUsers
          ? RefreshScreen(
              onRefresh: () async => await muteUsersModel.onRefresh(),
              onLoading: () async => await muteUsersModel.onLoading(),
              refreshController: muteUsersModel.refreshController,
              child: ListView.builder(
                  itemCount: muteUserDocs.length,
                  itemBuilder: (BuildContext context, int index) {
                    final muteUserDoc = muteUserDocs[index];
                    final FirestoreUser muteFirestoreUser =
                        FirestoreUser.fromJson(muteUserDoc.data()!);
                    return ListTile(
                      title: Text(muteFirestoreUser.userName),
                      onTap: () => voids.showPopUp(
                        context: context,
                        builder: (BuildContext innerContext) =>
                            CupertinoActionSheet(
                          title: const Text(selectTitle),
                          actions: [
                            CupertinoActionSheetAction(
                              // This parameter indicates the action would perform
                              // a destructive action such as delete or exit and turns
                              // the action's text color to red.
                              isDestructiveAction: true,
                              onPressed: () {
                                Navigator.pop(innerContext);
                                muteUsersModel.showUnMuteUserDialog(
                                    context: context,
                                    passiveUid: muteFirestoreUser.uid,
                                    mainModel: mainModel,
                                    muteUserDoc: muteUserDoc);
                              },
                              child: const Text(unMuteUserText),
                            ),
                            CupertinoActionSheetAction(
                              onPressed: () => Navigator.pop(innerContext),
                              child: const Text(backText),
                            ),
                          ],
                        ),
                      ),
                    );
                  }))
          : Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Center(
                child: RoundedButton(
                    onPressed: () async =>
                        await muteUsersModel.getMuteUsers(mainModel: mainModel),
                    widthRate: 0.85,
                    color: Colors.blue,
                    text: showMuteUsersText),
              )
            ]),
    );
  }
}
