import 'package:flutter/material.dart';

class NavigationClass {
  static Future<void> pushWithSlideTransition({
    required BuildContext context,
    required Widget page,
    Duration transitionDuration = const Duration(milliseconds: 300),
  }) {
    return Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: transitionDuration,
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // Slide from right to left
          const end = Offset.zero; // End at center
          const curve = Curves.easeInOut; // Smooth curve

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }

  static Future<void> pushWithSlideUpTransition({
    required BuildContext context,
    required Widget page,
    Duration transitionDuration = const Duration(milliseconds: 300),
  }) {
    return Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: transitionDuration,
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0); // Slide from bottom to top
          const end = Offset.zero; // End at center
          const curve = Curves.easeInOut; // Smooth curve

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }

  static Future<void> pushReplacementWithSlideTransition({
    required BuildContext context,
    required Widget page,
    Duration transitionDuration = const Duration(milliseconds: 300),
  }) {
    return Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: transitionDuration,
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // Slide from right to left
          const end = Offset.zero; // End at center
          const curve = Curves.easeInOut; // Smooth curve

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }

  static Future<void> pushAndRemoveUntilWithSlideTransition({
    required BuildContext context,
    required Widget page,
    Duration transitionDuration = const Duration(milliseconds: 300),
  }) {
    return Navigator.of(context).pushAndRemoveUntil(
        PageRouteBuilder(
          transitionDuration: transitionDuration,
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0); // Slide from right to left
            const end = Offset.zero; // End at center
            const curve = Curves.easeInOut; // Smooth curve

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        ),
        (Route<dynamic> route) => false);
  }
}
