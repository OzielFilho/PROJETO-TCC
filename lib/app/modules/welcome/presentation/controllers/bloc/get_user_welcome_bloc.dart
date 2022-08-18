import 'dart:developer';

import '../../../../../core/error/failure.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../domain/usecases/get_user_create.dart';
import '../event/welcome_event.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../core/presentation/controller/app_state.dart';
import '../../../../auth/domain/entities/auth_result.dart';

class GetUserWelcomeBloc extends Bloc<WelcomeEvent, AppState>
    implements Disposable {
  final GetUserCreate _userCreate;
  GetUserWelcomeBloc(this._userCreate) : super(InitialState()) {
    on<GetUserEvent>(_onGetUserEvent);
  }
  AuthResult? user;
  _onGetUserEvent(GetUserEvent event, Emitter<AppState> emit) async {
    emit(ProcessingState());
    final result = await _userCreate.call(NoParams());
    log('result $result');
    emit(result.fold((failure) {
      switch (failure.runtimeType) {
        case NetworkFailure:
          return NetworkErrorState('Sem conexão com a internet');
        default:
          return ErrorState('Serviço indisponível no momento');
      }
    }, (success) {
      user = success;

      return SuccessGetUserState();
    }));
  }

  @override
  void dispose() {
    close();
  }
}
