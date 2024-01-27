//flutter
import 'package:flutter/material.dart';
import 'package:udemy_flutter_sns/models/main_model.dart';
//models
import 'package:udemy_flutter_sns/models/passive_user_profile_model.dart';
//packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
//constants
import 'package:udemy_flutter_sns/constants/strings.dart';
//components
import 'package:udemy_flutter_sns/details/user_image.dart';
import 'package:udemy_flutter_sns/details/rounded_button.dart';
//domain
import 'package:udemy_flutter_sns/domain/firestore_user/firestore_user.dart';

class PassiveUserProfilePage extends ConsumerWidget {
  const PassiveUserProfilePage(
      {Key? key, required this.passiveUser, required this.mainModel})
      : super(key: key);
  final FirestoreUser passiveUser;
  final MainModel mainModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PassiveUserProfileModel passiveUserProfileModel =
        ref.watch(passiveUserProfileProvider);
    final bool isFollowing = mainModel.followingUids.contains(passiveUser.uid);
    final int followerCount = passiveUser.followerCount;
    final int plusOneFollowerCount = followerCount + 1;

    return Scaffold(
      appBar: AppBar(title: Text(profileTitle)),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        UserImage(
          length: 100.0,
          userImageURL: passiveUser.userImageURL,
        ),
        Center(child: Text(passiveUser.uid)),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text('Following:${passiveUser.followingCount.toString()}',
              style: const TextStyle(fontSize: 32.0)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            isFollowing
                ? 'Follower:${plusOneFollowerCount.toString()}'
                : 'Follower:${followerCount.toString()}',
            style: const TextStyle(fontSize: 32.0),
          ),
        ),
        isFollowing
            ? RoundedButton(
                onPressed: () => passiveUserProfileModel.unFollow(
                    mainModel: mainModel, passiveUser: passiveUser),
                widthRate: 0.85,
                color: Colors.red,
                text: 'UnFollow')
            : RoundedButton(
                onPressed: () => passiveUserProfileModel.follow(
                    mainModel: mainModel, passiveUser: passiveUser),
                widthRate: 0.85,
                color: Colors.green,
                text: 'Follow')
      ]),
    );
  }
}
