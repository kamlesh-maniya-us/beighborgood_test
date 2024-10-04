import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neighborgood/_core/constant/extension_methods.dart';
import 'package:neighborgood/presentation/add_post/add_post_screen.dart';
import 'package:neighborgood/presentation/chat/chat_screen.dart';
import 'package:neighborgood/presentation/home/main_home.dart';
import 'package:neighborgood/presentation/_core/router/route_names.dart';
import 'package:neighborgood/presentation/auth/sign_up_screen.dart';
import 'package:neighborgood/presentation/home/screen/home_screen.dart';
import 'package:neighborgood/presentation/home/screen/splash_screen.dart';
import 'package:neighborgood/presentation/profile/profile_screen.dart';
import 'package:neighborgood/presentation/search/search_screen.dart';

import '../../home/screen/error_screen.dart';

Route<dynamic> authorizedNavigation(RouteSettings settings) {
  final routingData = settings.name!.getRoutingData; // Get the routing Data
  switch (routingData.route) {
    case AllRoutes.signupBeginRoute:
      return getPageRoute(const SignUpScreen(), settings);
    case AllRoutes.homeRoute:
      return getPageRoute(const MainHome(), settings);
    case AllRoutes.addPostRoute:
      return getPageRoute(const AddPostScreen(), settings);
    case AllRoutes.splashScreenRoute:
      return getPageRoute(const SplashScreen(), settings);
    default:
      {
        return getPageRoute(
          const ErrorScreen(),
          settings,
        );
      }
  }
}

PageRoute getPageRoute(
  Widget child,
  RouteSettings settings, {
  bool mainRoute = false,
  bool isPreset = false,
}) {
  if (isPreset) {
    return AnimatedRoute(child: child, routeName: settings.name ?? "");
  } else if (Platform.isIOS && !mainRoute) {
    return CupertinoPageRoute(
      builder: (BuildContext context) {
        return child;
      },
    );
  } else if (Platform.isAndroid && !mainRoute) {
    return CupertinoPageRoute(
      builder: (BuildContext context) {
        return child;
      },
    );
  } else {
    return _FadeRoute(child: child, routeName: settings.name ?? "");
  }
}

class _FadeRoute extends PageRouteBuilder {
  _FadeRoute({required this.child, required this.routeName})
      : super(
          settings: RouteSettings(name: routeName),
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              child,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );

  final Widget child;
  final String routeName;
}

class AnimatedRoute extends PageRouteBuilder {
  AnimatedRoute({required this.child, required this.routeName})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => child,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = const Offset(0.0, 1.0);
            var end = Offset.zero;
            var tween = Tween(begin: begin, end: end);
            var offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );

  final Widget child;
  final String routeName;
}

Route<dynamic> internalNavigation(
  RouteSettings settings,
  int index,
) {
  return getPageRoute(
    getBasePage(index),
    settings,
  );
}

Widget getBasePage(
  int index,
) {
  if (index == 0) {
    return const HomeScreen();
  } else if (index == 1) {
    return const SearchScreen();
  } else if (index == 2) {
    return const Scaffold(
      body: Center(
        child: Text('Add Post'),
      ),
    );
  } else if (index == 3) {
    return const ChatScreen();
  } else {
    return const ProfileScreen();
  }
}
