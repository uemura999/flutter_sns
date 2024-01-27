import 'package:flutter/material.dart';
//packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udemy_flutter_sns/constants/strings.dart';

final themeProvider = ChangeNotifierProvider((ref) => ThemeModel());

class ThemeModel extends ChangeNotifier {
  late SharedPreferences preferences;
  bool isDarkTheme = true;
  ThemeModel() {
    init();
  }

  Future<void> init() async {
    //端末に保存されているフラグなどを全部取得
    preferences = await SharedPreferences.getInstance();
    final x = preferences.getBool(isDarkThemePrefsKey);
    if (x != null) isDarkTheme = x;
    notifyListeners();
  }

  Future<void> setIsDarkTheme({required bool value}) async {
    isDarkTheme = value;
    await preferences.setBool(isDarkThemePrefsKey, value);
    notifyListeners();
  }
}
