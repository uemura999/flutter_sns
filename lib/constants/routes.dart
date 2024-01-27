//flutter
import 'package:flutter/material.dart';
//packages
import 'package:cloud_firestore/cloud_firestore.dart';
//domain
import 'package:udemy_flutter_sns/domain/comment/comment.dart';
import 'package:udemy_flutter_sns/domain/firestore_user/firestore_user.dart';
import 'package:udemy_flutter_sns/domain/post/post.dart';
//pages
import 'package:udemy_flutter_sns/main.dart';
import 'package:udemy_flutter_sns/views/account_page.dart';
import 'package:udemy_flutter_sns/views/admin_page.dart';
import 'package:udemy_flutter_sns/views/comments/comments_page.dart';
import 'package:udemy_flutter_sns/views/edit_profile_page.dart';
import 'package:udemy_flutter_sns/views/mute_comments_page.dart';
import 'package:udemy_flutter_sns/views/mute_posts_page.dart';
import 'package:udemy_flutter_sns/views/mute_replies_page.dart';
import 'package:udemy_flutter_sns/views/mute_users_page.dart';
import 'package:udemy_flutter_sns/views/passive_user_profile_page.dart';
import 'package:udemy_flutter_sns/views/replies/replies_page.dart';
import 'package:udemy_flutter_sns/views/signup_page.dart';
import 'package:udemy_flutter_sns/views/login_page.dart';
//models
import 'package:udemy_flutter_sns/models/main_model.dart';

void toMyApp({required BuildContext context}) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));

void toSignupPage({required BuildContext context}) => Navigator.push(
    context, MaterialPageRoute(builder: (context) => SignupPage()));

void toLoginPage({required BuildContext context}) => Navigator.push(
    context, MaterialPageRoute(builder: (context) => LoginPage()));

void toAccountPage(
        {required BuildContext context, required MainModel mainModel}) =>
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AccountPage(mainModel: mainModel)));

void toPassiveUserProfilePage(
        {required BuildContext context,
        required FirestoreUser passiveUser,
        required MainModel mainModel}) =>
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PassiveUserProfilePage(
                  passiveUser: passiveUser,
                  mainModel: mainModel,
                )));
void toAdminPage(
        {required BuildContext context, required MainModel mainModel}) =>
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AdminPage(
                  mainModel: mainModel,
                )));

void toCommentsPage(
        {required BuildContext context,
        required Post post,
        required DocumentSnapshot<Map<String, dynamic>> postDoc,
        required MainModel mainModel}) =>
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CommentsPage(
                post: post, postDoc: postDoc, mainModel: mainModel)));
void toRepliesPage(
        {required BuildContext context,
        required MainModel mainModel,
        required Comment comment,
        required DocumentSnapshot<Map<String, dynamic>> commentDoc}) =>
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RepliesPage(
                comment: comment,
                commentDoc: commentDoc,
                mainModel: mainModel)));

void toEditProfilePage(
        {required BuildContext context, required MainModel mainModel}) =>
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditProfilePage(
                  mainModel: mainModel,
                )));

void toMuteUsersPage(
        {required BuildContext context, required MainModel mainModel}) =>
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MuteUsersPage(
                  mainModel: mainModel,
                )));

void toMutePostsPage(
        {required BuildContext context, required MainModel mainModel}) =>
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MutePostsPage(
                  mainModel: mainModel,
                )));

void toMuteCommentsPage(
        {required BuildContext context, required MainModel mainModel}) =>
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MuteCommentsPage(
                  mainModel: mainModel,
                )));

void toMuteRepliesPage(
        {required BuildContext context, required MainModel mainModel}) =>
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MuteRepliesPage(
                  mainModel: mainModel,
                )));
