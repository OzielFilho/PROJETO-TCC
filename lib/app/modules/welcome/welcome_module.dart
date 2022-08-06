import 'domain/usecases/get_user_create.dart';
import 'domain/usecases/update_user_create.dart';
import 'infra/repositories/welcome_repository_impl.dart';
import 'presentation/controllers/bloc/update_user_create_bloc.dart';
import 'presentation/controllers/bloc/user_phone_is_empty_bloc.dart';
import 'presentation/pages/welcome_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'external/firebase_welcome_datasource_impl.dart';
import 'presentation/controllers/bloc/get_user_welcome_bloc.dart';

class WelcomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => FirebaseWelcomeDatasourceImpl(i(), i())),
    Bind((i) => WelcomeRepositoryImpl(i())),
    Bind((i) => GetUserCreate(i())),
    Bind((i) => GetUserWelcomeBloc(i())),
    Bind((i) => UpdateUserCreate(i())),
    Bind((i) => UpdateUserCreateBloc(i())),
    Bind((i) => UserPhoneIsEmptyBloc()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (context, args) {
      return WelcomePage();
    },
        transition: TransitionType.leftToRight,
        duration: Duration(milliseconds: 500))
  ];
}
