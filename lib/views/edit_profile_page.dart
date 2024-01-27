//flutter
import 'package:flutter/material.dart';
//models
import 'package:flutter_riverpod/flutter_riverpod.dart';
//constants
import 'package:udemy_flutter_sns/constants/strings.dart';
//components
import 'package:udemy_flutter_sns/details/rounded_button.dart';
import 'package:udemy_flutter_sns/details/rounded_text_field.dart';
import 'package:udemy_flutter_sns/details/user_image.dart';
import 'package:udemy_flutter_sns/domain/firestore_user/firestore_user.dart';
import 'package:udemy_flutter_sns/models/edit_profile_model.dart';
import 'package:udemy_flutter_sns/models/main_model.dart';

class EditProfilePage extends ConsumerWidget {
  const EditProfilePage({Key? key, required this.mainModel}) : super(key: key);
  final MainModel mainModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final EditProfileModel editProfileModel = ref.watch(editProfileProvider);
    final FirestoreUser firestoreUser = mainModel.firestoreUser;
    final TextEditingController textEditingController =
        TextEditingController(text: editProfileModel.userName);
    return Scaffold(
      appBar: AppBar(title: const Text(editProfilePageTitle)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                onTap: () async => await editProfileModel.onImageTapped(),
                child: editProfileModel.croppedFile == null
                    ? UserImage(
                        length: 100.0,
                        userImageURL: firestoreUser.userImageURL,
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(300.0),
                        child: Image.file(
                          editProfileModel.croppedFile!,
                          fit: BoxFit.fill,
                        ),
                      ),
              ),
            ),

            //ユーザー名を編集したい！
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32.0),
              child: RoundedTextField(
                  keyboardType: TextInputType.name,
                  onChanged: (value) => editProfileModel.userName = value,
                  controller: textEditingController,
                  borderColor: Colors.black,
                  shadowColor: Colors.red.withOpacity(0.3),
                  hintText: firestoreUser.userName),
            ),
            //プロフィールを更新するのに必要
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32.0),
              child: Center(
                child: RoundedButton(
                    onPressed: () async =>
                        await editProfileModel.updateUserInfo(
                          context: context,
                          mainModel: mainModel,
                        ),
                    widthRate: 0.85,
                    color: Colors.green,
                    text: updateText),
              ),
            )
          ],
        ),
      ),
    );
  }
}
