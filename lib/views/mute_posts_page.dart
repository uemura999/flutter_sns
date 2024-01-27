//flutter
import 'package:flutter/material.dart';
//packages
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//constants
import 'package:udemy_flutter_sns/constants/strings.dart';
import 'package:udemy_flutter_sns/constants/voids.dart' as voids;
import 'package:udemy_flutter_sns/details/user_image.dart';
//domain
import 'package:udemy_flutter_sns/domain/post/post.dart';
//models
import 'package:udemy_flutter_sns/models/main_model.dart';
import 'package:udemy_flutter_sns/models/mute_posts_model.dart';
//components
import 'package:udemy_flutter_sns/details/rounded_button.dart';
import 'package:udemy_flutter_sns/views/refresh_screen.dart';

class MutePostsPage extends ConsumerWidget {
  const MutePostsPage({Key? key, required this.mainModel}) : super(key: key);
  final MainModel mainModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MutePostsModel mutePostsModel = ref.watch(mutePostsProvider);
    final mutePostDocs = mutePostsModel.mutePostDocs;
    return Scaffold(
      appBar: AppBar(
        title: const Text(mutePostsPageTitle),
      ),
      body: mutePostsModel.showMutePosts
          ? RefreshScreen(
              onRefresh: () async => await mutePostsModel.onRefresh(),
              onLoading: () async => await mutePostsModel.onLoading(),
              refreshController: mutePostsModel.refreshController,
              child: ListView.builder(
                  itemCount: mutePostDocs.length,
                  itemBuilder: (BuildContext context, int index) {
                    final mutePostDoc = mutePostDocs[index];
                    final Post mutePost = Post.fromJson(mutePostDoc.data()!);
                    return ListTile(
                      leading: UserImage(
                          length: 60, userImageURL: mutePost.userImageURL),
                      title: Text(mutePost.text),
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
                                mutePostsModel.showUnMuteCommentDialog(
                                    context: context,
                                    mainModel: mainModel,
                                    postDoc: mutePostDoc,
                                    postDocs: mutePostDocs);
                              },
                              child: const Text(unMutePostText),
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
                        await mutePostsModel.getMutePosts(mainModel: mainModel),
                    widthRate: 0.85,
                    color: Colors.blue,
                    text: showMutePostsText),
              )
            ]),
    );
  }
}
