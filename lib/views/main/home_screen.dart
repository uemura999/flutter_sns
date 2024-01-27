//flutter
import 'package:flutter/material.dart';
//packages
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//constants
import 'package:udemy_flutter_sns/constants/strings.dart';
import 'package:udemy_flutter_sns/constants/voids.dart' as voids;
//components
import 'package:udemy_flutter_sns/details/post_card.dart';
import 'package:udemy_flutter_sns/details/reload_screen.dart';
//domain
import 'package:udemy_flutter_sns/domain/post/post.dart';
//models
import 'package:udemy_flutter_sns/models/comments_model.dart';
import 'package:udemy_flutter_sns/models/create_post_model.dart';
import 'package:udemy_flutter_sns/models/main/home_model.dart';
import 'package:udemy_flutter_sns/models/main_model.dart';
import 'package:udemy_flutter_sns/models/mute_posts_model.dart';
import 'package:udemy_flutter_sns/models/mute_users_model.dart';
import 'package:udemy_flutter_sns/models/posts_model.dart';
//pages
import 'package:udemy_flutter_sns/views/refresh_screen.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({Key? key, required this.mainModel}) : super(key: key);
  final MainModel mainModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final HomeModel homeModel = ref.watch(homeProvider);
    final PostsModel postsModel = ref.watch(postsProvider);
    final CommentsModel commentsModel = ref.watch(commentsProvider);
    final CreatePostModel createPostModel = ref.watch(createPostProvider);
    final MuteUsersModel muteUsersModel = ref.watch(muteUsersProvider);
    final MutePostsModel mutePostsModel = ref.watch(mutePostsProvider);
    final postDocs = homeModel.postDocs;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => createPostModel.showPostFlashBar(
            context: context, mainModel: mainModel),
        child: Icon(Icons.new_label),
      ),
      body: postDocs.isEmpty
          ? ReloadScreen(onReload: () async => await homeModel.onReload())
          : RefreshScreen(
              onRefresh: () async => await homeModel.onRefresh(),
              onLoading: () async => await homeModel.onLoading(),
              refreshController: homeModel.refreshController,
              child: ListView.builder(
                  itemCount: postDocs.length,
                  itemBuilder: (BuildContext context, int index) {
                    final postDoc = postDocs[index];
                    final Post post = Post.fromJson(postDoc.data()!);
                    return PostCard(
                        //ユーザーをミュートしたい
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
                                      muteUsersModel.showMuteUserDialog(
                                          context: context,
                                          passiveUid: post.uid,
                                          mainModel: mainModel,
                                          docs: postDocs);
                                    },
                                    child: const Text(muteUserText),
                                  ),
                                  CupertinoActionSheetAction(
                                    // This parameter indicates the action would perform
                                    // a destructive action such as delete or exit and turns
                                    // the action's text color to red.
                                    isDestructiveAction: true,
                                    onPressed: () {
                                      Navigator.pop(innerContext);
                                      mutePostsModel.showMutePostDialog(
                                          context: context,
                                          mainModel: mainModel,
                                          postDoc: postDoc,
                                          postDocs: postDocs);
                                    },
                                    child: const Text(mutePostText),
                                  ),
                                  CupertinoActionSheetAction(
                                    onPressed: () =>
                                        Navigator.pop(innerContext),
                                    child: const Text(backText),
                                  ),
                                ],
                              ),
                            ),
                        post: post,
                        postDoc: postDoc,
                        mainModel: mainModel,
                        postsModel: postsModel,
                        commentsModel: commentsModel);
                  })),
    );
  }
}
