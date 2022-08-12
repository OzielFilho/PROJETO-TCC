import 'package:bloc/bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/presentation/controller/app_state.dart';
import '../../../../core/services/network_service.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/logged_user.dart';
import 'splash_event.dart';

class SplashBloc extends Bloc<SplashEvent, AppState> implements Disposable {
  final LoggedUser _logged;
  final NetworkService _networkService;
  SplashBloc(this._logged, this._networkService) : super(InitialState()) {
    on<LoggedUserEvent>(_onLoggedUserEvent);
  }

  _onLoggedUserEvent(LoggedUserEvent event, Emitter<AppState> emit) async {
    emit(ProcessingState());
    if (!await _networkService.hasConnection) {
      emit(NetworkErrorState('Sem conexão com a internet'));
    }
    final result = await _logged.call(NoParams());

    emit(result.fold((failure) {
      switch (failure.runtimeType) {
        case LoggedUserFailure:
          return ErrorState('');
        default:
          return ErrorState('Erro ao entrar no app');
      }
    },
        (success) => success.logged
            ? !success.welcomePage
                ? SuccessWelcomeState()
                : SuccessHomeState()
            : UserNotLoggedState()));
  }

  @override
  void dispose() {
    close();
  }
}
