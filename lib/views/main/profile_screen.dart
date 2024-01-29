// flutter
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
// components
import 'package:udemy_flutter_sns/details/post_card.dart';
import 'package:udemy_flutter_sns/details/reload_screen.dart';
import 'package:udemy_flutter_sns/details/user_header.dart';
import 'package:udemy_flutter_sns/views/refresh_screen.dart';
// domain
import 'package:udemy_flutter_sns/domain/post/post.dart';
import 'package:udemy_flutter_sns/domain/firestore_user/firestore_user.dart';
// models
import 'package:udemy_flutter_sns/models/comments_model.dart';
import 'package:udemy_flutter_sns/models/main_model.dart';
import 'package:udemy_flutter_sns/models/main/profile_model.dart';
import 'package:udemy_flutter_sns/models/mute_posts_model.dart';
import 'package:udemy_flutter_sns/models/mute_users_model.dart';
import 'package:udemy_flutter_sns/models/posts_model.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key, required this.mainModel}) : super(key: key);
  final MainModel mainModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ProfileModel profileModel = ref.watch(profileProvider);
    final PostsModel postsModel = ref.watch(postsProvider);
    final CommentsModel commentsModel = ref.watch(commentsProvider);
    final FirestoreUser firestoreUser = mainModel.firestoreUser;
    final MuteUsersModel muteUsersModel = ref.watch(muteUsersProvider);
    final MutePostsModel mutePostsModel = ref.watch(mutePostsProvider);
    final postDocs = profileModel.postDocs;

    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        UserHeader(firestoreUser: firestoreUser, mainModel: mainModel),
        postDocs.isEmpty
            ? ReloadScreen(onReload: () async => await profileModel.onReload())
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
                              index: index,
                              mainModel: mainModel);
                        })),
              ),
      ]),
    );
  }
}
