//flutter
import 'package:flutter/material.dart';
//packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';

//domain
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
    //画面の向きを取得
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    final PassiveUserProfileModel passiveUserProfileModel =
        ref.watch(passiveUserProfileProvider);
    //SearchModelがよびだされる
    final SearchModel searchModel = ref.watch(searchProvider);
    return Scaffold(
      body: FloatingSearchBar(
        onQueryChanged: (text) async {
          searchModel.searchTerm = text;
          await searchModel.operation(muteUids: mainModel.muteUids);
        },
        hint: 'Search...',
        scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
        transitionDuration: const Duration(milliseconds: 800),
        transitionCurve: Curves.easeInOut,
        physics: const BouncingScrollPhysics(),
        axisAlignment: isPortrait ? 0.0 : -1.0,
        openAxisAlignment: 0.0,
        width: isPortrait ? 600 : 500,
        debounceDelay: const Duration(milliseconds: 500),
        body: IndexedStack(
          children: [
            FloatingSearchBarScrollNotifier(
              child: Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: ListView.builder(
                  itemCount: searchModel.userDocs.length,
                  itemBuilder: ((context, index) {
                    final userDoc = searchModel.userDocs[index];
                    final FirestoreUser passiveUser =
                        FirestoreUser.fromJson(userDoc.data()!);
                    return ListTile(
                        title: Text(passiveUser.userName),
                        onTap: () async =>
                            await passiveUserProfileModel.onUserIconPressed(
                                context: context,
                                mainModel: mainModel,
                                passiveUserDoc: userDoc));
                  }),
                ),
              ),
            )
          ],
        ),
        builder: ((context, transition) {
          return Container();
        }),
      ),
    );
  }
}
