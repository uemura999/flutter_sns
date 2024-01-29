//flutter
import 'package:flutter/material.dart';
//packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udemy_flutter_sns/domain/firestore_user/firestore_user.dart';
//models
import 'package:udemy_flutter_sns/models/main/search_model.dart';
import 'package:udemy_flutter_sns/models/main_model.dart';
import 'package:udemy_flutter_sns/models/passive_user_profile_model.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({Key? key, required this.mainModel}) : super(key: key);
  final MainModel mainModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PassiveUserProfileModel passiveUserProfileModel =
        ref.watch(passiveUserProfileProvider);
    //SearchModelがよびだされる
    final SearchModel searchModel = ref.watch(searchProvider);
    return ListView.builder(
      itemCount: searchModel.userDocs.length,
      itemBuilder: ((context, index) {
        final userDoc = searchModel.userDocs[index];
        final FirestoreUser passiveUser =
            FirestoreUser.fromJson(userDoc.data()!);
        return ListTile(
            title: Text(passiveUser.uid),
            onTap: () async => await passiveUserProfileModel.onUserIconPressed(
                context: context,
                mainModel: mainModel,
                passiveUserDoc: userDoc));
      }),
    );
  }
}
