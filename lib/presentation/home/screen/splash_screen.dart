import 'package:flutter/material.dart';
import 'package:neighborgood/_core/constant/app_constant.dart';
import 'package:neighborgood/presentation/_core/router/route_names.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if ((currentUser.userId ?? "").isNotEmpty) {
        mainNavigator.navigateTo(AllRoutes.homeRoute);
      } else {
        mainNavigator.navigateTo(AllRoutes.signupBeginRoute);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
