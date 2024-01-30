import 'package:flutter/material.dart';
import 'package:udemy_flutter_sns/constants/strings.dart';

final List<BottomNavigationBarItem> bottomNavigationBarElements = [
  const BottomNavigationBarItem(icon: Icon(Icons.home), label: homeText),
  const BottomNavigationBarItem(icon: Icon(Icons.search), label: searchText),
  const BottomNavigationBarItem(icon: Icon(Icons.article), label: articleText),
  const BottomNavigationBarItem(icon: Icon(Icons.person), label: profileText),
];
