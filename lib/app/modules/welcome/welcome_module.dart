import 'package:app/app/modules/welcome/presentation/pages/welcome_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class WelcomeModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (context, args) => WelcomePage(),
        transition: TransitionType.leftToRight,
        duration: Duration(seconds: 1))
  ];
}
