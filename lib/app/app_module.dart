import 'modules/auth/auth_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute,
        module: AuthModule(),
        transition: TransitionType.leftToRight,
        duration: Duration(seconds: 1)),
  ];
}
