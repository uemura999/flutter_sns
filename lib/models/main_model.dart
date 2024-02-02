//flutter
import 'package:flutter/material.dart';
//packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//domain
import 'package:udemy_flutter_sns/domain/firestore_user/firestore_user.dart';
import 'package:udemy_flutter_sns/domain/following_token/following_token.dart';
import 'package:udemy_flutter_sns/domain/like_comment_token/like_comment_token.dart';
import 'package:udemy_flutter_sns/domain/like_post_token/like_post_token.dart';
import 'package:udemy_flutter_sns/domain/like_reply_token/like_reply_token.dart';
import 'package:udemy_flutter_sns/domain/mute_comment_token/mute_comment_token.dart';
import 'package:udemy_flutter_sns/domain/mute_post_token/mute_post_token.dart';
import 'package:udemy_flutter_sns/domain/mute_reply_token/mute_reply_token.dart';
import 'package:udemy_flutter_sns/domain/mute_user_token/mute_user_token.dart';
//constants
import 'package:udemy_flutter_sns/constants/enums.dart';
import 'package:udemy_flutter_sns/constants/others.dart';

final mainProvider = ChangeNotifierProvider((ref) => MainModel());

class MainModel extends ChangeNotifier {
  bool isLoading = false;

  late User? currentUser;
  late DocumentSnapshot<Map<String, dynamic>> currentUserDoc;
  late FirestoreUser firestoreUser;
  //tokens
  List<FollowingToken> followingTokens = [];
  List<String> followingUids = [];
  List<LikePostToken> likePostTokens = [];
  List<String> likePostIds = [];
  List<LikeCommentToken> likeCommentTokens = [];
  List<String> likeCommentIds = [];
  List<LikeReplyToken> likeReplyTokens = [];
  List<String> likeReplyIds = [];
  List<MuteUserToken> muteUserTokens = [];
  List<String> muteUids = [];
  List<MutePostToken> mutePostTokens = [];
  List<String> mutePostIds = [];
  List<MuteCommentToken> muteCommentTokens = [];
  List<String> muteCommentIds = [];
  List<MuteReplyToken> muteReplyTokens = [];
  List<String> muteReplyIds = [];

  //以下3行がMainModelが起動した時の処理
  //ユーザーの動作を必要としないモデルの関数
  MainModel() {
    init();
  }
  void setCurrentUser() {
    returnAuthUser();
    notifyListeners();
  }

  //initの中でcurrentUserを更新すれば良い
  Future<void> init() async {
    startLoading();
    //modelを跨がないでcurrentUserの更新
    currentUser = returnAuthUser();
    //WtyKn3pDcINcgODIyxRWQiLL1H03
    currentUserDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .get();
    await distributeTokens();
    firestoreUser = FirestoreUser.fromJson(currentUserDoc.data()!);
    //currentUserのuidの取得が可能になる
    notifyListeners();
    endLoading();
  }

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  Future<void> distributeTokens() async {
    final tokensQshot =
        await currentUserDoc.reference.collection('tokens').get();
    final tokenDocs = tokensQshot.docs;
    //新しい順に並べる
    //公式的なもの
    //古い順に並べるなら、aとbを入れ替える
    tokenDocs.sort(
        (a, b) => (b["createdAt"] as Timestamp).compareTo(a["createdAt"]));
    for (final tokenDoc in tokenDocs) {
      final Map<String, dynamic> tokenMap = tokenDoc.data();
      final TokenType tokenType = mapToTokenType(tokenMap: tokenMap);
      switch (tokenType) {
        case TokenType.following:
          final FollowingToken followingToken =
              FollowingToken.fromJson(tokenMap);
          followingTokens.add(followingToken);
          followingUids.add(followingToken.passiveUid);
          break;
        case TokenType.likePost:
          final LikePostToken likePostToken = LikePostToken.fromJson(tokenMap);
          likePostTokens.add(likePostToken);
          likePostIds.add(likePostToken.postId);
          break;
        case TokenType.likeComment:
          final LikeCommentToken likeCommentToken =
              LikeCommentToken.fromJson(tokenMap);
          likeCommentTokens.add(likeCommentToken);
          likeCommentIds.add(likeCommentToken.postCommentId);
          break;
        case TokenType.likeReply:
          final LikeReplyToken likeReplyToken =
              LikeReplyToken.fromJson(tokenMap);
          likeReplyTokens.add(likeReplyToken);
          likeReplyIds.add(likeReplyToken.postCommentReplyId);
          break;
        case TokenType.muteUser:
          final MuteUserToken muteUserToken = MuteUserToken.fromJson(tokenMap);
          muteUserTokens.add(muteUserToken);
          muteUids.add(muteUserToken.passiveUid);
          break;
        case TokenType.mutePost:
          final MutePostToken mutePostToken = MutePostToken.fromJson(tokenMap);
          mutePostTokens.add(mutePostToken);
          mutePostIds.add(mutePostToken.postId);
          break;
        case TokenType.muteComment:
          final MuteCommentToken muteCommentToken =
              MuteCommentToken.fromJson(tokenMap);
          muteCommentTokens.add(muteCommentToken);
          muteCommentIds.add(muteCommentToken.postCommentId);
          break;
        case TokenType.muteReply:
          final MuteReplyToken muteReplyToken =
              MuteReplyToken.fromJson(tokenMap);
          muteReplyTokens.add(muteReplyToken);
          muteReplyIds.add(muteReplyToken.postCommentReplyId);
          break;
        case TokenType.mistake:
          break;
      }
    }
  }

  void updateFrontUserInfo(
      {required String newUserName, required String newUserImageURL}) {
    //現在のfirestoreUserの中身をほぼコピーして、userNameだけを更新する
    firestoreUser = firestoreUser.copyWith(
        userName: newUserName, userImageURL: newUserImageURL);
    notifyListeners();
  }
}
