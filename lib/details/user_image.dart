import 'package:flutter/material.dart';
import 'package:udemy_flutter_sns/details/circle_image.dart';

class UserImage extends StatelessWidget {
  const UserImage({Key? key, required this.length, required this.userImageURL})
      : super(key: key);
  final double length;
  final String userImageURL;
  @override
  Widget build(BuildContext context) {
    //与えられたUserImageURLが空の時に表示する
    return userImageURL.isEmpty
        ? Container(
            width: length,
            height: length,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.green)),
            child: Icon(
              Icons.person,
              size: length - 8,
            ),
          )
        : CircleImage(length: length, image: NetworkImage(userImageURL));
  }
}
