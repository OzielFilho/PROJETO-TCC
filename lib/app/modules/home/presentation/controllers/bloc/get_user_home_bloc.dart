import 'package:app/app/core/presentation/controller/app_state.dart';
import 'package:app/app/core/usecases/usecase.dart';
import 'package:app/app/modules/home/domain/usecases/get_user_home.dart';
import 'package:app/app/modules/home/presentation/controllers/events/home_event.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../domain/entities/user_result_home.dart';

class GetUserHomeBloc extends Bloc<HomeEvent, AppState> implements Disposable {
  final GetUserHome _usecase;
  GetUserHomeBloc(this._usecase) : super(InitialState()) {
    on<GetUserHomeEvent>(_onGetUserHome);
  }
  UserResultHome? user;
  _onGetUserHome(GetUserHomeEvent event, Emitter<AppState> emit) async {
    emit(ProcessingState());
    final result = await _usecase.call(NoParams());
    emit(result
        .fold((failure) => ErrorState('Não foi possível capturar seu usuário'),
            (success) {
      user = success;
      return SuccessGetUserState();
    }));
  }

  @override
  void dispose() {
    close();
  }
}
