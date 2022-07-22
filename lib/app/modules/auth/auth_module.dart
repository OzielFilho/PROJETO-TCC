import 'package:app/app/modules/auth/domain/usecases/login_user.dart';
import 'package:app/app/modules/auth/infra/repositories/auth_repository_impl.dart';
import 'package:app/app/modules/auth/presentation/controllers/login_controller/login_bloc.dart';
import 'package:app/app/modules/auth/presentation/widgets/create_account.dart';
import 'package:app/app/modules/auth/presentation/widgets/login_app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'external/firebase_auth_datasource_impl.dart';
import 'presentation/pages/auth_page.dart';

class AuthModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => FirebaseAuthDatasourceImpl(
        authClient: FirebaseAuth.instance, googleSignIn: GoogleSignIn())),
    Bind((i) => AuthUserRepositoryImpl(i())),
    Bind((i) => LoginUser(i())),
    Bind((i) => LoginBloc(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (p0, p1) => AuthPage(),
      transition: TransitionType.leftToRight,
      duration: Duration(milliseconds: 500),
    ),
    ChildRoute(
      '/login_app',
      child: (p0, p1) => LoginAppWidget(),
      transition: TransitionType.leftToRight,
      duration: Duration(milliseconds: 500),
    ),
    ChildRoute(
      '/create_account',
      child: (p0, p1) => CreateAccountWidget(),
      transition: TransitionType.leftToRight,
      duration: Duration(milliseconds: 500),
    )
  ];
}
