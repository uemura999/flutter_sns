//constants
import 'package:udemy_flutter_sns/constants/strings.dart';

class SearchTabBarElement {
  SearchTabBarElement(this.title);
  final String title;
}

final List<SearchTabBarElement> searchTabBarElements = [
  SearchTabBarElement(usersText),
  SearchTabBarElement(postsText),
];
