import 'package:app/app/modules/home/domain/usecases/get_current_position.dart';
import 'package:app/app/modules/home/domain/usecases/get_user_home.dart';
import 'package:app/app/modules/home/external/information_map_from_google.dart';
import 'package:app/app/modules/home/infra/repositories/informations_user_repository_impl.dart';
import 'package:app/app/modules/home/presentation/controllers/bloc/get_user_home_bloc.dart';
import 'package:app/app/modules/home/presentation/pages/home_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'external/information_user_from_firebase.dart';
import 'infra/repositories/informations_map_repository_impl.dart';
import 'presentation/controllers/bloc/get_current_location_bloc.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => InformationsUserFromFirebase(
            firestoreService: i(), authService: i())),
        Bind((i) => InformationsMapFromGoogle(i())),
        Bind((i) => InformationsUserRepositoryImpl(i())),
        Bind((i) => InformationsMapRepositoryImpl(i())),
        Bind((i) => GetUserHome(i())),
        Bind((i) => GetCurrentPosition(i())),
        Bind((i) => GetCurrentLocationBloc(i())),
        Bind((i) => GetUserHomeBloc(i())),
      ];

  @override
  List<ModularRoute> get routes =>
      [ChildRoute(Modular.initialRoute, child: (context, args) => HomePage())];
}
