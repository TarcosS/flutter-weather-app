import 'package:flutter/material.dart';

class SlideAnimationRoute extends PageRouteBuilder {
  final Widget page;
  final Widget route;

  SlideAnimationRoute({required this.page, required this.route})
  : super(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionDuration: const Duration(milliseconds: 400),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      animation = CurvedAnimation(
        parent: animation, 
        curve: Curves.fastOutSlowIn,
      );
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(animation),
        child: route,
      );
    }
  );
}