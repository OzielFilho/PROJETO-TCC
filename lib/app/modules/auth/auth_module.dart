import 'package:app/app/modules/auth/infra/repositories/create_account_repository_impl.dart';
import 'package:app/app/modules/splash/presentation/controllers/splash_bloc.dart';

import 'domain/usecases/login_with_email_and_password.dart';
import 'infra/repositories/login_repository_impl.dart';
import 'infra/repositories/recovery_repository_impl.dart';
import 'presentation/controllers/create_account_controller/create_account_bloc.dart';
import 'presentation/controllers/login_controller/login_bloc.dart';
import 'presentation/controllers/recovery_account_controller/recovery_account_bloc.dart';
import 'presentation/controllers/create_account_controller/create_account_form/create_account_form_bloc.dart';
import 'presentation/pages/create_account/create_account_finalization.dart';
import 'presentation/pages/create_account/create_account_form.dart';
import 'presentation/pages/login_app.dart';
import 'presentation/pages/recovery_account.dart';
import '../home/home_module.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'domain/usecases/create_account_with_email_and_password.dart';
import 'domain/usecases/login_with_google_user.dart';
import 'domain/usecases/recovery_password.dart';
import 'external/firebase_auth_datasource_impl.dart';
import 'presentation/controllers/login_google_controller/login_google_bloc.dart';
import 'presentation/pages/auth_page.dart';

class AuthModule extends Module {
  @override
  final List<Bind> binds = [
    //DATASOURCE GENERAL
    Bind((i) => FirebaseAuthDatasourceImpl(
        authClient: FirebaseAuth.instance, googleSignIn: GoogleSignIn())),

    //LOGIN
    Bind((i) => LoginRepositoryImpl(i())),
    Bind((i) => LoginWithEmailAndPassword(i())),
    Bind((i) => LoginWithEmailAndPasswordBloc(i())),
    Bind((i) => LoginWithGoogle(i())),
    Bind((i) => LoginWithGoogleBloc(i())),

    //CREATE ACCOUNT
    Bind((i) => CreateAccountRepositoryImpl(i())),
    Bind((i) => CreateAccountWithEmailAndPassword(i())),
    Bind((i) => CreateAccountWithEmailAndPasswordBloc(i())),
    Bind((i) => CreateAccountFormBloc()),

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
      child: (p0, p1) => LoginAppWidget(),
      transition: TransitionType.leftToRight,
      duration: Duration(milliseconds: 500),
    ),
    ChildRoute(
      '/recovery_account',
      child: (p0, p1) => RecoveryAccount(),
      transition: TransitionType.leftToRight,
      duration: Duration(milliseconds: 500),
    ),
    ChildRoute(
      '/create_account_form',
      child: (p0, p1) => CreateAccountForm(),
      transition: TransitionType.leftToRight,
      duration: Duration(milliseconds: 500),
    ),
    ChildRoute(
      '/create_account_finalization',
      child: (p0, args) =>
          CreateAccountFinalization(userCreate: args.data['userCreate']),
      transition: TransitionType.leftToRight,
      duration: Duration(milliseconds: 500),
    )
  ];
}
