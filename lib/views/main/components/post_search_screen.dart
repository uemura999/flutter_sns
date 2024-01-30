//flutter
import 'package:flutter/material.dart';
//packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
//components
import 'package:udemy_flutter_sns/details/user_image.dart';
import 'package:udemy_flutter_sns/views/main/components/search_screen.dart';
//domain
import 'package:udemy_flutter_sns/domain/post/post.dart';
//models
import 'package:udemy_flutter_sns/models/main/post_search_model.dart';
import 'package:udemy_flutter_sns/models/main_model.dart';

class PostSearchScreen extends ConsumerWidget {
  const PostSearchScreen(
      {Key? key, required this.isPortrait, required this.mainModel})
      : super(key: key);
  final MainModel mainModel;
  final bool isPortrait;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PostSearchModel postSearchModel = ref.watch(postSearchProvider);
    final postMaps = postSearchModel.postMaps;
    return SearchScreen(
      onQueryChanged: (text) async {
        postSearchModel.searchTerm = text;
        await postSearchModel.operation(
            muteUids: mainModel.muteUids, mutePostIds: mainModel.mutePostIds);
      },
      axisAlignment: isPortrait ? 0.0 : -1.0,
      width: isPortrait ? 600 : 500,
      child: ListView.builder(
        itemCount: postMaps.length,
        itemBuilder: ((context, index) {
          final post = Post.fromJson(postMaps[index]);
          return ListTile(
            leading: UserImage(
              userImageURL: post.userImageURL,
              length: 32.0,
            ),
            title: Text(post.userName),
            subtitle: Text(post.text),
          );
        }),
      ),
    );
  }
}
