import '../../../../../core/presentation/controller/app_state.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../domain/usecases/logout_user.dart';
import '../events/home_event.dart';
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
