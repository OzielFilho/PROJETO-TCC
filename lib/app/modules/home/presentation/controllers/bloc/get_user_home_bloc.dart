import 'package:bloc/bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/presentation/controller/app_state.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../domain/entities/user_result_home.dart';
import '../../../domain/usecases/get_user_home.dart';
import '../events/home_event.dart';

class GetUserHomeBloc extends Bloc<HomeEvent, AppState> implements Disposable {
  final GetUserHome _usecase;
  GetUserHomeBloc(this._usecase) : super(InitialState()) {
    on<GetUserHomeEvent>(_onGetUserHome);
  }
  UserResultHome? user;
  _onGetUserHome(GetUserHomeEvent event, Emitter<AppState> emit) async {
    emit(ProcessingState());
    final result = await _usecase.call(NoParams());
    emit(result.fold((failure) {
      switch (failure.runtimeType) {
        case NetworkFailure:
          return NetworkErrorState('Sem conexão com a internet');
        default:
          return ErrorState('Não foi possível capturar seu usuário');
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
