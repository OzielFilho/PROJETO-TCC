import 'package:app/app/core/presentation/controller/app_state.dart';
import 'package:app/app/core/usecases/usecase.dart';
import 'package:app/app/modules/home/domain/usecases/logout_user.dart';
import 'package:app/app/modules/home/presentation/controllers/events/home_event.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LogoutUserBloc extends Bloc<HomeEvent, AppState> implements Disposable {
  final LogoutUser _usecase;
  LogoutUserBloc(this._usecase) : super(InitialState()) {
    on<LogoutUserEvent>(_onLogoutUser);
  }

  @override
  void dispose() {
    close();
  }

  _onLogoutUser(LogoutUserEvent event, Emitter<AppState> emit) async {
    emit(ProcessingState());

    final result = await _usecase.call(NoParams());
    emit(result.fold(
        (failure) => ErrorState('Não foi possível deslogar o seu usuário'),
        (success) => SuccessLogoutUserState()));
  }
}
