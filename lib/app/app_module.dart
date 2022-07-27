import 'package:app/app/core/services/network_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'core/services/firebase_auth_service.dart';
import 'core/services/firestore_service.dart';
import 'modules/auth/auth_module.dart';
import 'modules/auth/external/firebase_auth_datasource_impl.dart';
import 'modules/home/home_module.dart';
import 'modules/splash/splash_module.dart';
import 'modules/welcome/welcome_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    //DATASOURCE GENERAL
    Bind((i) => FirestoreServiceImpl(FirebaseFirestore.instance)),
    Bind((i) => FirebaseAuthServiceImpl(FirebaseAuth.instance)),
    Bind((i) => NetworkServiceImpl()),
    Bind((i) => FirebaseAuthDatasourceImpl(
        authService: i(), googleSignIn: GoogleSignIn(), firestore: i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute,
        module: SplashModule(),
        transition: TransitionType.leftToRight,
        duration: Duration(seconds: 1)),
    ModuleRoute('/auth',
        module: AuthModule(),
        transition: TransitionType.leftToRight,
        duration: Duration(seconds: 1)),
    ModuleRoute('/welcome',
        module: WelcomeModule(),
        transition: TransitionType.leftToRight,
        duration: Duration(seconds: 1)),
    ModuleRoute('/home',
        module: HomeModule(),
        transition: TransitionType.leftToRight,
        duration: Duration(seconds: 1)),
  ];
}
