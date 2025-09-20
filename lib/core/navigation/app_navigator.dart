import 'dart:async';
import 'package:ecommerce_app/core/app/app_body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppNavigator {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  PageRoute createSlidePageRoute({required Widget screen}) {
    return CupertinoPageRoute(
      builder: (context) => screen,
      settings: const RouteSettings(),
      maintainState: true,
      fullscreenDialog: false,
    );
  }

  PageRoute createFadePageRoute({required Widget screen}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = 0.0;
        const end = 1.0;
        const curve = Curves.easeInOut;
        Animatable<double> tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return FadeTransition(opacity: animation.drive(tween), child: child);
      },
    );
  }

  Future<void> push({required Widget screen, bool isFade = false}) async {
    await navigatorKey.currentState!.push(
      isFade? createFadePageRoute(screen: screen) : createSlidePageRoute(screen: screen)
    );
  }

  Future<void> pushReplacement({required Widget screen, bool isFade = false}) async {
    await navigatorKey.currentState!.pushReplacement(
      isFade? createFadePageRoute(screen: screen) : createSlidePageRoute(screen: screen)
    );
  }

  dynamic pushAndRemoveUntil({required Widget screen, bool isFade = false}) {
    return navigatorKey.currentState!.pushAndRemoveUntil(
      isFade? createFadePageRoute(screen: screen) : createSlidePageRoute(screen: screen),
      (route) => false
    );
  }

  dynamic pop({dynamic object}) {
    return navigatorKey.currentState!.pop<dynamic>(object);
  }

  dynamic popToFrist({dynamic object}) {
    return navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  dynamic exitApp({dynamic object}) {
    return navigatorKey.currentState!.pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => const MyApp()),(Route<dynamic> route) => false);
  }
}
