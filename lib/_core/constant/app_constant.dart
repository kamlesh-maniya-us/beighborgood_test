import 'package:flutter/widgets.dart';
import 'package:neighborgood/infrastructure/add_post/dtos/users.dart';

import '../configs/injection.dart';
import '../configs/page_refresh_provider.dart';
import '../services/navigation_service.dart';

final mainNavigatorKey = GlobalKey<NavigatorState>();
NavigationService mainNavigator = navigator<NavigationService>(param1: mainNavigatorKey);

final navigatorKeys = {
  0: GlobalKey<NavigatorState>(),
  1: GlobalKey<NavigatorState>(),
  2: GlobalKey<NavigatorState>(),
  3: GlobalKey<NavigatorState>(),
};

GlobalKey<NavigatorState> currentSelectedNavKey = navigatorKeys[0]!;

Users currentUser = Users(name: "", photoURL: "");

late PageRefresh pageRefresh;

bool isConnected = false;
