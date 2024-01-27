import 'package:flutter/material.dart';

//packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udemy_flutter_sns/constants/ints.dart';

final snsBottomNavigationBarProvider =
    ChangeNotifierProvider((ref) => SNSBottomNavigationBarModel());

class SNSBottomNavigationBarModel extends ChangeNotifier {
  int currentIndex = 0;
  late PageController pageController;

  SNSBottomNavigationBarModel() {
    init();
  }
  void init() {
    pageController = PageController(
      initialPage: currentIndex,
    );
    notifyListeners();
  }

  void onPageChanged({required int index}) {
    currentIndex = index;
    notifyListeners();
  }

  void onTabTapped({required int index}) {
    pageController.animateToPage(index,
        duration: Duration(milliseconds: pageAnimationDuration),
        curve: Curves.easeIn);
  }

  void setPageController() {
    pageController = PageController(initialPage: currentIndex);
    notifyListeners();
  }
}
