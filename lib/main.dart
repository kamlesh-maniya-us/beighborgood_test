import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neighborgood/_core/configs/bottom_nav_bar_provider.dart';
import 'package:neighborgood/_core/configs/theme_config.dart';
import 'package:neighborgood/_core/constant/string_constants.dart';
import 'package:neighborgood/presentation/_core/router/route_names.dart';
import 'package:neighborgood/presentation/_core/router/routing_config.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '_core/configs/injection.dart';
import '_core/configs/page_refresh_provider.dart';
import '_core/constant/app_constant.dart';
import '_core/services/network_service.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  configureInjection();
  setupLocator();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PageRefresh(),
        ),
        ChangeNotifierProvider(
          create: (context) => BottomNavigationBarProvider(),
        ),
      ],
      builder: (context, child) => const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late InternetConnectivityService _connectivityService;

  @override
  void initState() {
    _connectivityService = InternetConnectivityService.init();
    super.initState();
  }

  @override
  void dispose() {
    _connectivityService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, _, __) {
        return MaterialApp(
          title: StringConstants.title,
          theme: AppTheme.lightTheme,
          home: const Scaffold(),
          navigatorKey: mainNavigatorKey,
          builder: (context, child) {
            final MediaQueryData data = MediaQuery.of(context);
            child = MediaQuery(
              data: data.copyWith(
                textScaler: const TextScaler.linear(1.0),
              ),
              child: child ?? const SizedBox.shrink(),
            );
            return child;
          },
          onGenerateRoute: (settings) => authorizedNavigation(settings),
          initialRoute: AllRoutes.splashScreenRoute,
        );
      },
    );
  }
}
