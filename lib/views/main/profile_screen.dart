// flutter
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
// constants
import 'package:udemy_flutter_sns/constants/strings.dart';
// components
import 'package:udemy_flutter_sns/details/post_card.dart';
import 'package:udemy_flutter_sns/details/reload_screen.dart';
import 'package:udemy_flutter_sns/details/sns_drawer.dart';
import 'package:udemy_flutter_sns/details/user_header.dart';
import 'package:udemy_flutter_sns/views/refresh_screen.dart';
// domain
import 'package:udemy_flutter_sns/domain/post/post.dart';
import 'package:udemy_flutter_sns/domain/firestore_user/firestore_user.dart';
// models
import 'package:udemy_flutter_sns/models/themes_model.dart';
import 'package:udemy_flutter_sns/models/main_model.dart';
import 'package:udemy_flutter_sns/models/main/profile_model.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen(
      {Key? key, required this.mainModel, required this.themeModel})
      : super(key: key);
  final MainModel mainModel;
  final ThemeModel themeModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ProfileModel profileModel = ref.watch(profileProvider);
    final FirestoreUser firestoreUser = mainModel.firestoreUser;
    final postDocs = profileModel.postDocs;

    return Scaffold(
      appBar: AppBar(
        title: const Text(profileText),
      ),
      drawer: SNSDrawer(
        mainModel: mainModel,
        themeModel: themeModel,
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          UserHeader(
            firestoreUser: firestoreUser,
            mainModel: mainModel,
            onTap: () => profileModel.onMenuPressed(context: context),
          ),
          postDocs.isEmpty
              ? ReloadScreen(
                  onReload: () async => await profileModel.onReload())
              : SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: RefreshScreen(
                      onRefresh: () async => await profileModel.onRefresh(),
                      onLoading: () async => await profileModel.onLoading(),
                      refreshController: profileModel.refreshController,
                      child: ListView.builder(
                          itemCount: postDocs.length,
                          itemBuilder: (BuildContext context, int index) {
                            final postDoc = postDocs[index];
                            final Post post = Post.fromJson(postDoc.data()!);
                            return PostCard(
                                post: post,
                                postDocs: postDocs,
                                mainModel: mainModel,
                                postDoc: postDoc);
                          })),
                ),
        ]),
      ),
    );
  }
}
