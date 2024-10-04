import 'package:flutter/material.dart';

import '../../../_core/constant/app_constant.dart';
import '../../_core/router/routing_config.dart';

class InternalNavigator extends StatelessWidget {
  final int index;

  const InternalNavigator({
    super.key,
    required this.index,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return HeroControllerScope(
      controller: MaterialApp.createMaterialHeroController(),
      child: Navigator(
        key: navigatorKeys[index],
        onGenerateRoute: (rSettings) => internalNavigation(
          rSettings,
          index,
        ),
      ),
    );
  }
}
