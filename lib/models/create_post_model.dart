//flutter
import 'package:flutter/material.dart';
//packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
//constants
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:udemy_flutter_sns/constants/strings.dart';
import 'package:udemy_flutter_sns/constants/voids.dart' as voids;
import 'package:udemy_flutter_sns/domain/firestore_user/firestore_user.dart';
//domain
import 'package:udemy_flutter_sns/domain/post/post.dart';
//models
import 'package:udemy_flutter_sns/models/main_model.dart';

final createPostProvider = ChangeNotifierProvider((ref) => CreatePostModel());

class CreatePostModel extends ChangeNotifier {
  final TextEditingController textEditingController = TextEditingController();
  String text = "";
  void showPostFlashBar({
    required BuildContext context,
    required MainModel mainModel,
  }) {
    voids.showFlashBar(
        context: context,
        textEditingController: textEditingController,
        onChanged: (value) => text = value,
        titleString: createPostTitle,
        primaryActionColor: Colors.purple,
        primaryAction: (controller) async {
          if (textEditingController.text.isNotEmpty) {
            await controller.dismiss();
            //メインの動作
            await createPost(mainModel: mainModel);
            text = "";
            textEditingController.clear();
          } else {
            //何もしない
            await controller.dismiss();
          }
        });
  }

  Future<void> createPost({required MainModel mainModel}) async {
    final DocumentSnapshot<Map<String, dynamic>> currentUserDoc =
        mainModel.currentUserDoc;
    final FirestoreUser firestoreUser = mainModel.firestoreUser;
    final Timestamp now = Timestamp.now();
    final String activeUid = currentUserDoc.id;
    final String postId = returnUuidV4();
    final Post post = Post(
        commentCount: 0,
        createdAt: now,
        hashTags: [],
        imageUrl: "",
        likeCount: 0,
        text: text,
        textLanguageCode: "",
        textNegativeScore: 0,
        textPositiveScore: 0,
        textSentiment: "",
        muteCount: 0,
        postId: postId,
        uid: activeUid,
        userName: firestoreUser.userName,
        userImageURL: firestoreUser.userImageURL,
        userNameLanguageCode: firestoreUser.userNameLanguageCode,
        userNameNegativeScore: firestoreUser.userNameNegativeScore,
        userNamePositiveScore: firestoreUser.userNamePositiveScore,
        userNameSentiment: firestoreUser.userNameSentiment,
        updatedAt: now);

    //FirebaseFirestore.instance.collection("users").doc(activeUid)
    await currentUserDoc.reference
        .collection("posts")
        .doc(postId)
        .set(post.toJson());

    await voids.showFluttertoast(msg: createdPostMsg);
  }
}
