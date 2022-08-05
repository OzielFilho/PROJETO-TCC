import 'package:flutter_modular/flutter_modular.dart';

import '../home/home_module.dart';
import 'domain/usecases/create_account_with_email_and_password.dart';
import 'domain/usecases/login_with_email_and_password.dart';
import 'domain/usecases/login_with_google_user.dart';
import 'domain/usecases/recovery_password.dart';
import 'infra/repositories/create_account_repository_impl.dart';
import 'infra/repositories/login_repository_impl.dart';
import 'infra/repositories/recovery_repository_impl.dart';
import 'presentation/controllers/create_account_controller/create_account_bloc.dart';
import 'presentation/controllers/login_controller/login_bloc.dart';
import 'presentation/controllers/login_google_controller/login_google_bloc.dart';
import 'presentation/controllers/recovery_account_controller/recovery_account_bloc.dart';
import 'presentation/pages/auth_page.dart';
import 'presentation/pages/create_account_page.dart';
import 'presentation/pages/login_app_page.dart';
import 'presentation/pages/recovery_account_page.dart';

class AuthModule extends Module {
  @override
  final List<Bind> binds = [
    //LOGIN
    Bind((i) => LoginRepositoryImpl(i())),
    Bind((i) => LoginWithEmailAndPassword(i())),
    Bind((i) => LoginWithEmailAndPasswordBloc(i())),
    Bind((i) => LoginWithGoogle(i())),
    Bind((i) => LoginWithGoogleBloc(i())),

    //CREATE ACCOUNT
    Bind((i) => CreateAccountRepositoryImpl(i())),
    Bind((i) => CreateAccountWithEmailAndPassword(i())),
    Bind((i) => CreateAccountBloc(i())),

    //RECOVERY ACCOUNT
    Bind((i) => RecoveryRepositoryImpl(i())),
    Bind((i) => RecoveryPassword(i())),
    Bind((i) => RecoveryAccountBloc(i())),
  ];

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
