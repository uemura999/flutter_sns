//package
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//constants
import 'package:udemy_flutter_sns/constants/enum.dart';
import 'package:udemy_flutter_sns/constants/others.dart';
import 'package:udemy_flutter_sns/domain/mute_user_token/mute_user_token.dart';

Future<List<String>> returnMuteUids() async {
  //firebase authのユーザーをreturnしている
  final User? user = returnAuthUser();
  final tokensQshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(user!.uid)
      .collection('tokens')
      .get();
  //for文を回し、１回１回にnullをreturnして、toList();でListにしている。つまり、List<null>
  final tokenDocs = tokensQshot.docs;
  List<String> muteUids = tokenDocs
      .where((element) => element['tokenType'] == muteUserTokenTypeString)
      .map((e) => MuteUserToken.fromJson(e.data()).passiveUid)
      .toList();
  return muteUids;
}
