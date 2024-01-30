//flutter
import 'package:flutter/material.dart';
//constants
import 'package:udemy_flutter_sns/constants/strings.dart';
//details
import 'package:udemy_flutter_sns/details/circle_image.dart';

class ArticleUserImage extends StatelessWidget {
  const ArticleUserImage(
      {Key? key, required this.length, required this.ArticleUserImageURL})
      : super(key: key);
  final double length;
  final String ArticleUserImageURL;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: validateImageUrl(ArticleUserImageURL),
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Loading indicator while waiting
        } else if (snapshot.hasError || snapshot.data == null) {
          return Container(
            width: length,
            height: length,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.green)),
            child: Icon(
              Icons.person,
              size: length - 8,
            ),
          );
        } else {
          return CircleImage(
              length: length, image: NetworkImage(snapshot.data!));
        }
      },
    );
  }
}
