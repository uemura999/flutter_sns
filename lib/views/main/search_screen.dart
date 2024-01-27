import 'package:flutter/material.dart';
//constants
import 'package:udemy_flutter_sns/constants/routes.dart' as routes;
//packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udemy_flutter_sns/domain/firestore_user/firestore_user.dart';
//models
import 'package:udemy_flutter_sns/models/main/search_model.dart';
import 'package:udemy_flutter_sns/models/main_model.dart';

class SearchScreen extends ConsumerWidget {
  SearchScreen({Key? key, required this.mainModel}) : super(key: key);
  final MainModel mainModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //SearchModelがよびだされる
    final SearchModel searchModel = ref.watch(searchProvider);
    return ListView.builder(
      itemCount: searchModel.users.length,
      itemBuilder: ((context, index) {
        final FirestoreUser firestoreUser = searchModel.users[index];
        return ListTile(
            title: Text(firestoreUser.uid),
            onTap: () => routes.toPassiveUserProfilePage(
                context: context,
                passiveUser: firestoreUser,
                mainModel: mainModel));
      }),
    );
  }
}
