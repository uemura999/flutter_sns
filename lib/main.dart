//dart
import 'dart:async';
import 'dart:ui';
//flutter
import 'package:flutter/material.dart';
//packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:udemy_flutter_sns/constants/others.dart';
//constants
import 'package:udemy_flutter_sns/constants/themes.dart';
import 'package:udemy_flutter_sns/constants/strings.dart';
import 'package:udemy_flutter_sns/views/auth/verify_email_page.dart';
import 'package:udemy_flutter_sns/views/main/articles_screen.dart';
//options
import 'firebase_options.dart';
//models
import 'package:udemy_flutter_sns/models/themes_model.dart';
import 'package:udemy_flutter_sns/models/main_model.dart';
import 'package:udemy_flutter_sns/models/sns_bottom_navigation_bar_model.dart';
//components
import 'package:udemy_flutter_sns/details/sns_bottom_navigation_bar.dart';
import 'package:udemy_flutter_sns/views/login_page.dart';
import 'package:udemy_flutter_sns/views/main/home_screen.dart';
import 'package:udemy_flutter_sns/views/main/profile_screen.dart';
import 'package:udemy_flutter_sns/views/main/search_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  const fatalError = true;
  // Non-async exceptions
  //Dartのエラーを報告
  FlutterError.onError = (errorDetails) {
    if (fatalError) {
      // If you want to record a "fatal" exception
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
      // ignore: dead_code
    } else {
      // If you want to record a "non-fatal" exception
      FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
    }
  };
  // Async exceptions
  PlatformDispatcher.instance.onError = (error, stack) {
    if (fatalError) {
      // If you want to record a "fatal" exception
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      // ignore: dead_code
    } else {
      // If you want to record a "non-fatal" exception
      FirebaseCrashlytics.instance.recordError(error, stack);
    }
    return true;
  };
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
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      title: appTitle,
      debugShowCheckedModeBanner: false,
      theme: themeModel.isDarkTheme
          ? darkThemeData(context: context)
          : lightThemeData(context: context),
      home: onceUser == null //ユーザーが存在していないなら
          ? const LoginPage() //ログインページへ
          : onceUser.emailVerified //ユーザーが存在していて、かつメールアドレスが確認済みなら
              ? MyHomePage(
                  themeModel: themeModel,
                )
              : const VerifyEmailPage(),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key, required this.themeModel});

  final ThemeModel themeModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //MainModelが起動し、init()が実行される
    final MainModel mainModel = ref.watch(mainProvider);

    final SNSBottomNavigationBarModel snsBottomNavigationBarModel =
        ref.watch(snsBottomNavigationBarProvider);

    return Scaffold(
      body: mainModel.isLoading
          ? Center(
              child: Text(returnL10n(context: context).loading),
            )
          : PageView(
              controller: snsBottomNavigationBarModel.pageController,
              onPageChanged: (index) =>
                  snsBottomNavigationBarModel.onPageChanged(index: index),
              //childrenの個数はElementsの個数と同じ
              children: [
                HomeScreen(
                  mainModel: mainModel,
                  themeModel: themeModel,
                ),
                SearchPage(
                  mainModel: mainModel,
                ),
                const ArticlesScreen(),
                ProfileScreen(
                  mainModel: mainModel,
                  themeModel: themeModel,
                )
              ],
            ),
      bottomNavigationBar: SNSBottomNavigationBar(
          snsBottomNavigationBarModel: snsBottomNavigationBarModel),
    );
  }
}
