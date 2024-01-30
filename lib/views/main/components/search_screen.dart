//flutter
import 'package:flutter/material.dart';
//packages
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
//constants
import 'package:udemy_flutter_sns/constants/strings.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen(
      {Key? key,
      required this.onQueryChanged,
      required this.axisAlignment,
      required this.width,
      required this.child})
      : super(key: key);
  final Function(String)? onQueryChanged;
  final double? axisAlignment, width;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FloatingSearchBar(
      clearQueryOnClose: true,
      onQueryChanged: onQueryChanged,
      hint: searchHintText,
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 500),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: axisAlignment,
      openAxisAlignment: 0.0,
      width: width,
      debounceDelay: const Duration(milliseconds: 300),
      body: IndexedStack(
        children: [
          FloatingSearchBarScrollNotifier(
            child: Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: child,
            ),
          )
        ],
      ),
      builder: ((context, transition) {
        return Container();
      }),
    );
  }
}
