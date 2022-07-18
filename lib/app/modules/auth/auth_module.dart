import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'external/firebase_auth_datasource_impl.dart';
import 'presentation/pages/auth_page.dart';

class AuthModule extends Module {
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
