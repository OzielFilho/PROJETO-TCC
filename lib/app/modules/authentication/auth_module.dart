import 'package:flutter_modular/flutter_modular.dart';
import '../home/home_module.dart';
import 'ui/auth_page.dart';
import 'ui/create_account_page.dart';
import 'ui/login_app_page.dart';
import 'ui/recovery_account_page.dart';

class AuthModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (p0, p1) => AuthPage(),
      transition: TransitionType.leftToRight,
      duration: Duration(milliseconds: 500),
    ),
    ModuleRoute(
      '/home',
      module: HomeModule(),
      transition: TransitionType.leftToRight,
      duration: Duration(milliseconds: 500),
    ),
    ChildRoute(
      '/login_app',
      child: (p0, p1) => LoginAppPage(),
      transition: TransitionType.leftToRight,
      duration: Duration(milliseconds: 500),
    ),
    ChildRoute(
      '/recovery_account',
      child: (p0, p1) => RecoveryAccountPage(),
      transition: TransitionType.leftToRight,
      duration: Duration(milliseconds: 500),
    ),
    ChildRoute(
      '/create_account',
      child: (p0, p1) => CreateAccountPage(),
      transition: TransitionType.leftToRight,
      duration: Duration(milliseconds: 500),
    ),
  ];
}
