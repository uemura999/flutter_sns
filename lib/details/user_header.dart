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
      {Key? key,
      required this.firestoreUser,
      required this.mainModel,
      required this.onTap})
      : super(key: key);
  final MainModel mainModel;
  final FirestoreUser firestoreUser;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final int plusOneFollowingCount = firestoreUser.followingCount + 1;
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: UserImage(
                  length: 50.0,
                  userImageURL: firestoreUser.userImageURL,
                ),
              ),
              Text(
                firestoreUser.userName,
                style: const TextStyle(fontSize: 32.0),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Following:${firestoreUser.followingCount.toString()}',
                    style: const TextStyle(fontSize: 16.0)),
                Text(
                  mainModel.followingUids.contains(firestoreUser.uid)
                      ? 'Follower:${plusOneFollowingCount.toString()}'
                      : 'Follower:${firestoreUser.followerCount.toString()}',
                  style: const TextStyle(fontSize: 16.0),
                ),
                InkWell(
                  onTap: onTap,
                  child: Icon(Icons.menu),
                )
              ],
            ),
          ),
          UserButton(mainModel: mainModel, firestoreUser: firestoreUser)
        ],
      ),
    );
  }
}
