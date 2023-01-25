import '../auth/infra/repositories/create_account_repository_impl.dart';
import '../auth/presentation/controllers/create_account_controller/create_account_with_email_and_password_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../home/home_module.dart';
import '../auth/domain/usecases/create_account_with_email_and_password.dart';
import '../auth/domain/usecases/recovery_password.dart';
import '../auth/infra/repositories/recovery_repository_impl.dart';
import '../auth/presentation/controllers/recovery_account_controller/recovery_account_bloc.dart';
import '../auth/presentation/pages/auth_page.dart';
import '../auth/presentation/pages/create_account_page.dart';
import 'ui/login_app_page.dart';
import '../auth/presentation/pages/recovery_account_page.dart';

class AuthModule extends Module {
  @override
  final List<Bind> binds = [
    //CREATE ACCOUNT
    Bind((i) => CreateAccountRepositoryImpl(i(), i())),
    Bind((i) => CreateAccountWithEmailAndPassword(i())),
    Bind((i) => CreateAccountWithEmailAndPasswordBloc(i())),

    //RECOVERY ACCOUNT
    Bind((i) => RecoveryRepositoryImpl(i(), i())),
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
