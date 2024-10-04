import 'package:flutter/widgets.dart';

class NavigationService<T> {
  final GlobalKey<NavigatorState> navigatorKey;

  NavigationService(this.navigatorKey);

  Future<T?> navigateTo(
    String routeName, {
    Map<String, String> queryParams = const {},
    bool isClearStack = false,
    bool isReplace = false,
    dynamic arguments,
    dynamic result,
  }) async {
    String newRouteName = routeName;
    newRouteName = Uri(path: routeName, queryParameters: queryParams).toString();
    if (isClearStack) {
      return navigatorKey.currentState!.pushNamedAndRemoveUntil<T>(
        newRouteName,
        ModalRoute.withName("/"),
        arguments: arguments,
      );
    } else if (isReplace) {
      return navigatorKey.currentState!.pushReplacementNamed<T, T>(
        newRouteName,
        arguments: arguments,
        result: result,
      );
    } else {
      return navigatorKey.currentState!.pushNamed<T>(newRouteName, arguments: arguments);
    }
  }

  BuildContext get getNavContext => navigatorKey.currentState!.context;

  GlobalKey<NavigatorState> get getNavKey => navigatorKey;
}


