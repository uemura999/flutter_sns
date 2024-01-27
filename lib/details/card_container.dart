//flutter
import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {
  CardContainer(
      {Key? key,
      required this.borderColor,
      required this.child,
      required this.onTap})
      : super(key: key);
  final Color borderColor;
  final void Function()? onTap;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(16.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(32.0)),
        child: child,
      ),
    );
  }
}
