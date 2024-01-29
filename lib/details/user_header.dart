//flutter
import 'package:flutter/material.dart';
//components
import 'package:udemy_flutter_sns/details/user_button.dart';
import 'package:udemy_flutter_sns/details/user_image.dart';
//domain
import 'package:udemy_flutter_sns/domain/firestore_user/firestore_user.dart';
//models
import 'package:udemy_flutter_sns/models/main_model.dart';

class UserHeader extends StatelessWidget {
  const UserHeader(
      {Key? key, required this.firestoreUser, required this.mainModel})
      : super(key: key);
  final MainModel mainModel;
  final FirestoreUser firestoreUser;
  @override
  Widget build(BuildContext context) {
    final int plusOneFollowingCount = firestoreUser.followingCount + 1;
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Column(
        children: [
          UserImage(
            length: 50.0,
            userImageURL: firestoreUser.userImageURL,
          ),
          Text(
            firestoreUser.userName,
            style: const TextStyle(fontSize: 32.0),
          ),
          Text('Following:${firestoreUser.followingCount.toString()}',
              style: const TextStyle(fontSize: 16.0)),
          Text(
            mainModel.followingUids.contains(firestoreUser.uid)
                ? 'Follower:${plusOneFollowingCount.toString()}'
                : 'Follower:${firestoreUser.followerCount.toString()}',
            style: const TextStyle(fontSize: 16.0),
          ),
          UserButton(mainModel: mainModel, firestoreUser: firestoreUser)
        ],
      ),
    );
  }
}
