import 'package:app/app/modules/auth/presentation/controllers/login_controller/login_event.dart';
import 'package:app/app/modules/auth/presentation/controllers/login_controller/login_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/usecases/login_with_email_and_password.dart';

class LoginWithEmailAndPasswordBloc extends Bloc<LoginEvent, AppState>
    implements Disposable {
  final LoginWithEmailAndPassword _loginUser;
  LoginWithEmailAndPasswordBloc(this._loginUser) : super(InitialState()) {
    on<LoginWithEmailAndPasswordEvent>(_onLoginWithEmailAndPasswordEvent);
  }
  void _onLoginWithEmailAndPasswordEvent(
      LoginWithEmailAndPasswordEvent event, Emitter<AppState> emit) async {
    emit(ProcessingState());

    final params = Params(email: event.email, password: event.password);
    final result = await _loginUser.call(params);
    emit(result.fold((failure) {
      switch (failure.runtimeType) {
        case ParamsEmptyUserFailure:
          return EmailOrPasswordEmptyErrorState('Email ou Senha estão vazios');
        case ParamsInvalidUserFailure:
          return EmailOrPasswordInvalidErrorState('Email ou Senha inválidos');
        case UserNotFoundFailure:
          return UserNotFoundErrorState('Usuário não existe');
        default:
          return ErrorState('Não foi possível realizar o login');
      }
    }, (success) => SuccessState()));
  }

  @override
  void dispose() => close();
}
