import 'package:bloc/bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../core/presentation/controller/app_state.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../domain/usecases/login_with_google_user.dart';
import 'login_google_event.dart';

class LoginWithGoogleBloc extends Bloc<LoginWithGoogleEvent, AppState>
    implements Disposable {
  final LoginWithGoogle _loginGoogleUser;
  LoginWithGoogleBloc(this._loginGoogleUser) : super(InitialState()) {
    on<LoginWithGoogleEvent>(_onLoginWithGoogleEvent);
  }

  _onLoginWithGoogleEvent(
      LoginWithGoogleEvent event, Emitter<AppState> emit) async {
    emit(ProcessingState());

    final result = await _loginGoogleUser.call(NoParams());
    emit(result
        .fold((failure) => ErrorState('Não foi possível realizar o login'),
            (success) {
      return !success.welcomePage ? SuccessWelcomeState() : SuccessHomeState();
    }));
  }

  @override
  void dispose() => close();
}
