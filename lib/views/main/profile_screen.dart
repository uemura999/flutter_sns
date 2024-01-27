// flutter
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udemy_flutter_sns/details/rounded_button.dart';
// components
import 'package:udemy_flutter_sns/details/user_image.dart';
// domain
import 'package:udemy_flutter_sns/domain/firestore_user/firestore_user.dart';
// models
import 'package:udemy_flutter_sns/models/main_model.dart';
import 'package:udemy_flutter_sns/models/main/profile_model.dart';
//constants
import 'package:udemy_flutter_sns/constants/strings.dart';
import 'package:udemy_flutter_sns/constants/routes.dart' as routes;

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key, required this.mainModel}) : super(key: key);
  final MainModel mainModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ProfileModel profileModel = ref.watch(profileProvider);
    final FirestoreUser firestoreUser = mainModel.firestoreUser;

    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          UserImage(
            length: 100.0,
            userImageURL: firestoreUser.userImageURL,
          ),
          Text(
            firestoreUser.userName,
            style: const TextStyle(fontSize: 32.0),
          ),
          Text('Following:${firestoreUser.followingCount.toString()}',
              style: const TextStyle(fontSize: 32.0)),
          Text(
            'Follower:${firestoreUser.followerCount.toString()}',
            style: const TextStyle(fontSize: 32.0),
          ),
          RoundedButton(
              onPressed: () => routes.toEditProfilePage(
                  context: context, mainModel: mainModel),
              widthRate: 0.85,
              color: Colors.purple,
              text: editProfileText)
        ]);
  }
}
