
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:neighborgood/_core/configs/injection.config.dart';

import '../services/navigation_service.dart';


final getIt = GetIt.instance;

@injectableInit
void configureInjection() => getIt.init(); //$initGetIt(getIt);

GetIt navigator = GetIt.instance;

void setupLocator() {
  navigator.registerFactoryParam<NavigationService, GlobalKey<NavigatorState>,
      dynamic>((param1, param2) => NavigationService(param1));
}
