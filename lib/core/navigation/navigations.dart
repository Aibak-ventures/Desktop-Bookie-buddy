import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// class PageNavigations {
//   void push(Widget widget,
//       {TransitionType transitionType = TransitionType.normal}) {
//     navigatorKey.currentState!.push(_createRoute(widget, transitionType));
//   }

//   void pop() {
//     navigatorKey.currentState!.pop();
//   }

//   void pushRePlacement(Widget widget,
//       {TransitionType transitionType = TransitionType.normal}) {
//     navigatorKey.currentState!
//         .pushReplacement(_createRoute(widget, transitionType));
//   }

//   void pushAndRemoveUntil(Widget widget,
//       {TransitionType transitionType = TransitionType.normal}) {
//     navigatorKey.currentState!
//         .pushAndRemoveUntil(_createRoute(widget, transitionType), (_) => false);
//   }

//   Route _createRoute(Widget widget, TransitionType transitionType) {
//     switch (transitionType) {
//       case TransitionType.fade:
//         return PageRouteBuilder(
//           pageBuilder: (context, animation, secondaryAnimation) => widget,
//           transitionsBuilder: (context, animation, secondaryAnimation, child) {
//             return FadeTransition(
//               opacity: animation,
//               child: child,
//             );
//           },
//         );
//       case TransitionType.normal:
//         return MaterialPageRoute(builder: (context) => widget);
//     }
//   }
// }
