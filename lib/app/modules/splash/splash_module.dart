import 'package:flutter_modular/flutter_modular.dart';
import 'ui/splash_page.dart';

class SplashModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(Modular.initialRoute, child: (context, args) => SplashPage())
      ];
}
