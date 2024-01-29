//flutter
import 'package:flutter/material.dart';
//packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
//constants
import 'package:udemy_flutter_sns/constants/routes.dart' as routes;
import 'package:udemy_flutter_sns/constants/strings.dart';
//components
import 'package:udemy_flutter_sns/details/rounded_button.dart';
import 'package:udemy_flutter_sns/domain/firestore_user/firestore_user.dart';
//models
import 'package:udemy_flutter_sns/models/main_model.dart';
import 'package:udemy_flutter_sns/models/passive_user_profile_model.dart';

class UserButton extends ConsumerWidget {
  const UserButton(
      {Key? key, required this.mainModel, required this.firestoreUser})
      : super(key: key);
  final MainModel mainModel;
  final FirestoreUser firestoreUser;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PassiveUserProfileModel passiveUserProfileModel =
        ref.watch(passiveUserProfileProvider);
    final String firestoreUid = firestoreUser.uid;
    return //自分かどうか、自分なら編集ボタンをリターン違うならフォロー、アンフォローボタン
        mainModel.currentUserDoc.id == firestoreUid
            ? RoundedButton(
                onPressed: () => routes.toEditProfilePage,
                widthRate: 0.85,
                color: Colors.purple,
                text: editProfileText)
            : mainModel.followingUids.contains(firestoreUid)
                ? RoundedButton(
                    onPressed: () async =>
                        await passiveUserProfileModel.unFollow(
                            mainModel: mainModel, passiveUser: firestoreUser),
                    widthRate: 0.85,
                    color: Colors.red,
                    text: unFollowText)
                : RoundedButton(
                    onPressed: () async => await passiveUserProfileModel.follow(
                        mainModel: mainModel, passiveUser: firestoreUser),
                    widthRate: 0.85,
                    color: Colors.green,
                    text: followText);
  }
}
