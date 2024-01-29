//flutter
import 'package:flutter/material.dart';
//packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
//constants
import 'package:udemy_flutter_sns/constants/themes.dart';
import 'package:udemy_flutter_sns/constants/strings.dart';
import 'package:udemy_flutter_sns/views/auth/verify_email_page.dart';
//options
import 'firebase_options.dart';
//constants
import 'package:udemy_flutter_sns/models/mute_users_model.dart';
import 'package:udemy_flutter_sns/models/themes_model.dart';
//models
import 'package:udemy_flutter_sns/models/main_model.dart';
import 'package:udemy_flutter_sns/models/sns_bottom_navigation_bar_model.dart';
//components
import 'package:udemy_flutter_sns/details/sns_bottom_navigation_bar.dart';
import 'package:udemy_flutter_sns/details/sns_drawer.dart';
import 'package:udemy_flutter_sns/views/login_page.dart';
import 'package:udemy_flutter_sns/views/main/home_screen.dart';
import 'package:udemy_flutter_sns/views/main/profile_screen.dart';
import 'package:udemy_flutter_sns/views/main/search_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //MyAppが起動した最初の時にユーザーがログインしているかどうかの確認
    //今変数は一回きり
    final User? onceUser = FirebaseAuth.instance.currentUser;
    final ThemeModel themeModel = ref.watch(themeProvider);
    return MaterialApp(
      title: appTitle,
      debugShowCheckedModeBanner: false,
      theme: themeModel.isDarkTheme
          ? darkThemeData(context: context)
          : lightThemeData(context: context),
      home: onceUser == null //ユーザーが存在していないなら
          ? const LoginPage() //ログインページへ
          : onceUser.emailVerified //ユーザーが存在していて、かつメールアドレスが確認済みなら
              ? MyHomePage(
                  title: appTitle,
                  themeModel: themeModel,
                )
              : const VerifyEmailPage(),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key, required this.title, required this.themeModel});
  final String title;
  final ThemeModel themeModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //MainModelが起動し、init()が実行される
    final MainModel mainModel = ref.watch(mainProvider);
    final MuteUsersModel muteUsersModel = ref.watch(muteUsersProvider);

    final SNSBottomNavigationBarModel snsBottomNavigationBarModel =
        ref.watch(snsBottomNavigationBarProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      drawer: SNSDrawer(
        mainModel: mainModel,
        themeModel: themeModel,
      ),
      body: mainModel.isLoading
          ? Center(
              child: Text(loadingText),
            )
          : PageView(
              controller: snsBottomNavigationBarModel.pageController,
              onPageChanged: (index) =>
                  snsBottomNavigationBarModel.onPageChanged(index: index),
              //childrenの個数はElementsの個数と同じ
              children: [
                HomeScreen(
                  mainModel: mainModel,
                ),
                SearchScreen(
                  mainModel: mainModel,
                ),
                ProfileScreen(
                  mainModel: mainModel,
                )
              ],
            ),
      bottomNavigationBar: SNSBottomNavigationBar(
          snsBottomNavigationBarModel: snsBottomNavigationBarModel),
    );
  }
}
