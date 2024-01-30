//flutter
import 'package:flutter/material.dart';
//packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
//constants
import 'package:udemy_flutter_sns/constants/search_tab_bar_elements.dart';
import 'package:udemy_flutter_sns/constants/strings.dart';
//models
import 'package:udemy_flutter_sns/models/main_model.dart';
import 'package:udemy_flutter_sns/models/passive_user_profile_model.dart';
//components
import 'package:udemy_flutter_sns/views/main/components/user_search_screen.dart';
import 'package:udemy_flutter_sns/views/main/components/post_search_screen.dart';

class SearchPage extends ConsumerWidget {
  const SearchPage({Key? key, required this.mainModel}) : super(key: key);
  final MainModel mainModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //画面の向きを取得
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final PassiveUserProfileModel passiveUserProfileModel =
        ref.watch(passiveUserProfileProvider);
    //SearchModelがよびだされる
    return DefaultTabController(
      length: searchTabBarElements.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(searchText),
          bottom: TabBar(
              indicatorSize: TabBarIndicatorSize.label,
              tabs: searchTabBarElements
                  .map((e) => Tab(
                        text: e.title,
                      ))
                  .toList()),
        ),
        body: TabBarView(children: [
          UserSearchScreen(
              isPortrait: isPortrait,
              passiveUserProfileModel: passiveUserProfileModel,
              mainModel: mainModel),
          PostSearchScreen(isPortrait: isPortrait, mainModel: mainModel)
        ]),
      ),
    );
  }
}
