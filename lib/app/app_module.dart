import 'package:app/app/modules/home/presentation/pages/tutorial_home_page.dart';

import 'core/services/firestorage_service.dart';
import 'core/services/sms_service.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'core/services/audio_service.dart';
import 'core/services/locations_service.dart';
import 'core/services/network_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'core/services/firebase_auth_service.dart';
import 'core/services/firestore_service.dart';
import 'modules/authentication/auth_module.dart';
import 'modules/home/home_module.dart';
import 'modules/splash/splash_module.dart';
import 'modules/welcome_configurations/welcome_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    //DATASOURCE GENERAL
    Bind((i) => FirestoreServiceImpl(FirebaseFirestore.instance)),

    Bind((i) => NetworkServiceImpl()),
    Bind((i) => LocationsServiceImpl()),
    Bind((i) => AudioServiceImpl(AudioPlayer())),
    Bind((i) => FirestorageServiceImpl(FirebaseStorage.instance)),
    Bind((i) => FirebaseAuthServiceImpl(FirebaseAuth.instance, i(), i())),
    Bind((i) => SmsServiceImpl()),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute,
        module: SplashModule(),
        transition: TransitionType.leftToRight,
        duration: Duration(milliseconds: 500)),
    ModuleRoute('/auth',
        module: AuthModule(),
        transition: TransitionType.leftToRight,
        duration: Duration(milliseconds: 500)),
    ModuleRoute('/welcome',
        module: WelcomeModule(),
        transition: TransitionType.leftToRight,
        duration: Duration(milliseconds: 500)),
    ModuleRoute('/home',
        module: HomeModule(),
        transition: TransitionType.leftToRight,
        duration: Duration(milliseconds: 500)),
    ChildRoute('/tutorial',
        child: (context, args) => TutorialPage(),
        transition: TransitionType.leftToRight,
        duration: Duration(milliseconds: 500)),
  ];
}
