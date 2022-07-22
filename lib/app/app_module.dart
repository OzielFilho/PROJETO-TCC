import 'package:app/app/modules/home/home_module.dart';
import 'package:app/app/modules/splash/splash_module.dart';

import 'modules/auth/auth_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute,
        module: SplashModule(),
        transition: TransitionType.leftToRight,
        duration: Duration(seconds: 1)),
    ModuleRoute('/auth',
        module: AuthModule(),
        transition: TransitionType.leftToRight,
        duration: Duration(seconds: 1)),
    ModuleRoute('/home',
        module: HomeModule(),
        transition: TransitionType.leftToRight,
        duration: Duration(seconds: 1)),
  ];
}
