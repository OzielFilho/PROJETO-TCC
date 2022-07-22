import 'package:app/app/core/usecases/usecase.dart';
import 'package:app/app/modules/auth/domain/usecases/login_google_user.dart';
import 'package:app/app/modules/auth/presentation/controllers/login_controller/login_state.dart';
import 'package:app/app/modules/auth/presentation/controllers/login_google_controller/login_google_event.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginGoogleBloc extends Bloc<LoginWithGoogleEvent, AppState>
    implements Disposable {
  final LoginGoogleUser _loginGoogleUser;
  LoginGoogleBloc(this._loginGoogleUser) : super(InitialState()) {
    on<LoginWithGoogleEvent>(_onLoginWithGoogleEvent);
  }

  _onLoginWithGoogleEvent(
      LoginWithGoogleEvent event, Emitter<AppState> emit) async {
    emit(ProcessingState());

    final result = await _loginGoogleUser.call(NoParams());
    emit(result.fold(
        (failure) => ErrorState('Não foi possível realizar o login'),
        (success) => SuccessState()));
  }

  @override
  void dispose() => close();
}
