import 'package:flutter/material.dart';

class CustomPopupAnimationTransition extends PageRouteBuilder {
  final Widget enterWidget;

  CustomPopupAnimationTransition({required this.enterWidget})
      : super(
    opaque: false,
    pageBuilder: (context, animation, secondaryAnimation) => enterWidget,
    transitionDuration: const Duration(milliseconds: 1500),
    reverseTransitionDuration: const Duration(milliseconds: 500),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      animation = CurvedAnimation(
          parent: animation,
          curve: Curves.fastLinearToSlowEaseIn,
          reverseCurve: Curves.fastOutSlowIn);
      return ScaleTransition(
          alignment: const Alignment(0.0, 0.87),
          scale: animation,
          child: child);
    },
  );
}
