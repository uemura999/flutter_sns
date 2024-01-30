//flutter
import 'package:flutter/material.dart';
//packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
//components
import 'package:udemy_flutter_sns/details/user_image.dart';
//domain
import 'package:udemy_flutter_sns/domain/firestore_user/firestore_user.dart';
//models
import 'package:udemy_flutter_sns/models/main/user_search_model.dart';
import 'package:udemy_flutter_sns/models/main_model.dart';
import 'package:udemy_flutter_sns/models/passive_user_profile_model.dart';
import 'package:udemy_flutter_sns/views/main/components/search_screen.dart';

class UserSearchScreen extends ConsumerWidget {
  const UserSearchScreen(
      {Key? key,
      required this.isPortrait,
      required this.passiveUserProfileModel,
      required this.mainModel})
      : super(key: key);
  final MainModel mainModel;
  final PassiveUserProfileModel passiveUserProfileModel;
  final bool isPortrait;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserSearchModel userSearchModel = ref.watch(userSearchProvider);
    final userDocs = userSearchModel.userDocs;
    return SearchScreen(
      onQueryChanged: (text) async {
        userSearchModel.searchTerm = text;
        await userSearchModel.operation(
            muteUids: mainModel.muteUids, mutePostIds: mainModel.mutePostIds);
      },
      axisAlignment: isPortrait ? 0.0 : -1.0,
      width: isPortrait ? 600 : 500,
      child: ListView.builder(
        itemCount: userDocs.length,
        itemBuilder: ((context, index) {
          final userDoc = userDocs[index];
          final FirestoreUser passiveUser =
              FirestoreUser.fromJson(userDoc.data()!);
          return ListTile(
              leading: UserImage(
                  length: 32.0, userImageURL: passiveUser.userImageURL),
              title: Text(passiveUser.userName),
              onTap: () async =>
                  await passiveUserProfileModel.onUserIconPressed(
                      context: context,
                      mainModel: mainModel,
                      passiveUserDoc: userDoc));
        }),
      ),
    );
  }
}
