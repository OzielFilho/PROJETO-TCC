import 'package:app/app/modules/auth/external/firebase_auth_datasource_impl.dart';
import 'package:app/app/modules/auth/presentation/pages/auth_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => FirebaseAuthDatasourceImpl(authClient: FirebaseAuth.instance)),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (p0, p1) => AuthPage(),
    )
  ];
}
