import 'package:app/app/modules/splash/presentation/splash_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'domain/usecases/logged_user.dart';
import 'external/firebase_refresh_account.dart';
import 'infra/repositories/refresh_account_repository_impl.dart';
import 'presentation/controllers/splash_bloc.dart';

class SplashModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => FirebaseRefreshAccount(i(), i())),
        Bind((i) => RefreshAccountRepositoryImpl(i(), i())),
        Bind((i) => LoggedUser(i())),
        Bind((i) => SplashBloc(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(Modular.initialRoute, child: (context, args) => SplashPage())
      ];
}
