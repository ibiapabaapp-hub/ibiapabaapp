import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SharedAxisPage<T> extends CustomTransitionPage<T> {
  SharedAxisPage({
    required super.child,
    required LocalKey super.key,
    SharedAxisTransitionType type = SharedAxisTransitionType.horizontal,
    Duration duration = const Duration(milliseconds: 450),
    Duration reverseDuration = const Duration(milliseconds: 350),
  }) : super(
         transitionDuration: duration,
         reverseTransitionDuration: reverseDuration,
         transitionsBuilder: (context, animation, secondaryAnimation, child) {
           return SharedAxisTransition(
             animation: animation,
             secondaryAnimation: secondaryAnimation,
             transitionType: type,
             child: child,
           );
         },
       );
}
