import 'package:app/app/app_store.dart';
import 'package:app/app/modules/home/home_store.dart';
import 'package:app/app/modules/home/pages/initial/initial_store.dart';
import 'package:app/app/modules/login/login_module.dart';
import 'package:app/app/modules/login/login_store.dart';
import 'package:app/app/modules/splash/splash_module.dart';
import 'package:app/app/modules/splash/splash_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'modules/home/home_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => AppStore()),
    Bind((i) => SplashStore()),
    Bind((i) => HomeStore()),
    Bind((i) => LoginStore()),
    Bind((i) => InitialStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: SplashModule()),
    ModuleRoute('/home', module: HomeModule()),
    ModuleRoute('/login', module: LoginModule())
  ];
}
