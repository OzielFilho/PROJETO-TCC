import 'package:app/app/modules/welcome/domain/usecases/get_user_create.dart';
import 'package:app/app/modules/welcome/infra/repositories/welcome_repository_impl.dart';
import 'package:app/app/modules/welcome/presentation/pages/welcome_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'external/firebase_welcome_datasource_impl.dart';
import 'presentation/controllers/get_user_welcome_bloc.dart';

class WelcomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => FirebaseWelcomeDatasourceImpl(i(), i())),
    Bind((i) => WelcomeRepositoryImpl(i())),
    Bind((i) => GetUserCreate(i())),
    Bind((i) => GetUserWelcomeBloc(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (context, args) {
      return WelcomePage();
    }, transition: TransitionType.leftToRight, duration: Duration(seconds: 1))
  ];
}
