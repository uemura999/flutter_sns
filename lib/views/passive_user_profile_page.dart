//flutter
import 'package:flutter/material.dart';
//packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//models
import 'package:udemy_flutter_sns/models/main_model.dart';
import 'package:udemy_flutter_sns/models/passive_user_profile_model.dart';
//constants
import 'package:udemy_flutter_sns/constants/strings.dart';
//components
import 'package:udemy_flutter_sns/details/post_card.dart';
import 'package:udemy_flutter_sns/details/reload_screen.dart';
import 'package:udemy_flutter_sns/details/user_header.dart';
import 'package:udemy_flutter_sns/views/refresh_screen.dart';
//domain
import 'package:udemy_flutter_sns/domain/post/post.dart';
import 'package:udemy_flutter_sns/domain/firestore_user/firestore_user.dart';

class PassiveUserProfilePage extends ConsumerWidget {
  const PassiveUserProfilePage(
      {Key? key, required this.mainModel, required this.passiveUserDoc})
      : super(key: key);
  final MainModel mainModel;
  final DocumentSnapshot<Map<String, dynamic>> passiveUserDoc;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PassiveUserProfileModel passiveUserProfileModel =
        ref.watch(passiveUserProfileProvider);
    final FirestoreUser passiveUser =
        FirestoreUser.fromJson(passiveUserDoc.data()!);
    final muteUids = mainModel.muteUids;
    final postDocs = passiveUserProfileModel.postDocs;
    return Scaffold(
        appBar: AppBar(title: const Text(profileTitle)),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            UserHeader(
              firestoreUser: passiveUser,
              mainModel: mainModel,
              onTap: () => passiveUserProfileModel.onMenuPressed(
                  context: context,
                  muteUids: muteUids,
                  mutePostIds: mainModel.mutePostIds,
                  passiveUserDoc: passiveUserDoc),
            ),
            postDocs.isEmpty
                ? SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: ReloadScreen(
                        onReload: () async =>
                            await passiveUserProfileModel.onReload(
                                muteUids: muteUids,
                                mutePostIds: mainModel.mutePostIds,
                                passiveUserDoc: passiveUserDoc)),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: RefreshScreen(
                        onRefresh: () async =>
                            await passiveUserProfileModel.onRefresh(
                                muteUids: muteUids,
                                mutePostIds: mainModel.mutePostIds,
                                passiveUserDoc: passiveUserDoc),
                        onLoading: () async =>
                            await passiveUserProfileModel.onLoading(
                                muteUids: muteUids,
                                mutePostIds: mainModel.mutePostIds,
                                passiveUserDoc: passiveUserDoc),
                        refreshController:
                            passiveUserProfileModel.refreshController,
                        child: ListView.builder(
                            itemCount: postDocs.length,
                            itemBuilder: (BuildContext context, int index) {
                              final postDoc = postDocs[index];
                              final Post post = Post.fromJson(postDoc.data()!);
                              return PostCard(
                                post: post,
                                postDocs: postDocs,
                                mainModel: mainModel,
                                postDoc: postDoc,
                              );
                            })),
                  ),
          ]),
        ));
  }
}
