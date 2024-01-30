//package
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//constants
import 'package:udemy_flutter_sns/constants/enums.dart';
import 'package:udemy_flutter_sns/constants/others.dart';
import 'package:udemy_flutter_sns/domain/mute_post_token/mute_post_token.dart';
import 'package:udemy_flutter_sns/domain/mute_user_token/mute_user_token.dart';

Future<List<List<String>>> returnMuteUidsAndMutePostIds() async {
  //リストの１つ目の要素にmuteUidsを入れる
  //リストの２つ目の要素にmutePostIdsを入れる

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

  final List<String> mutePostIds = tokenDocs
      .where((element) => element['tokenType'] == mutePostTokenTypeString)
      .map((e) => MutePostToken.fromJson(e.data()).postId)
      .toList();
  return [muteUids, mutePostIds];
}

List<String> returnSearchWords({required String searchTerm}) {
  //１文字ずつに分割している
  //['私', 'は', ......]
  List<String> afterSplit = searchTerm.split('');
  //firebaseaで検索に使用できないフィールドを除外
  // {
  //   '私は': true,
  //   'はプ': true,
  // };
  const List<String> notUseOnField = ['.', ']', '[', '*', '`'];
  afterSplit.removeWhere((element) => notUseOnField.contains(element));
  String result = '';
  for (final element in afterSplit) {
    final x = element.toLowerCase();
    result += x;
  }

  //bi-gram
  final int length = result.length;
  List<String> searchWords = [];
  const nGramIndex = 2;
  if (length < nGramIndex) {
    searchWords.add(result);
  } else {
    int termIndex = 0;
    for (int i = 0; i < length - nGramIndex + 1; i++) {
      final String word = result.substring(termIndex, termIndex + nGramIndex);
      searchWords.add(word);
      termIndex++;
    }
  }
  return searchWords;
}
