import 'package:app/app/core/presentation/controller/app_state.dart';
import 'package:app/app/modules/auth/domain/usecases/create_account_with_email_and_password.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../core/error/failure.dart';
import 'create_account_event.dart';

class CreateAccountWithEmailAndPasswordBloc
    extends Bloc<CreateAccountEvent, AppState> implements Disposable {
  final CreateAccountWithEmailAndPassword _createAccount;
  CreateAccountWithEmailAndPasswordBloc(this._createAccount)
      : super(InitialState()) {
    on<CreateAccountWithEmailAndPasswordEvent>(
        _onCreateAccountWithEmailAndPasswordEvent);
  }

  void _onCreateAccountWithEmailAndPasswordEvent(
      CreateAccountWithEmailAndPasswordEvent event,
      Emitter<AppState> emit) async {
    emit(ProcessingState());
    final params = Params(email: event.email, password: event.password);
    final result = await _createAccount.call(params);
    if (event.phone.isEmpty) {
      return emit(EmptyParamsErrorState('O telefone é obrigatório'));
    }
    emit(result.fold((failure) {
      switch (failure.runtimeType) {
        case ParamsEmptyUserFailure:
          return EmailOrPasswordEmptyErrorState('Email ou Senha estão vazios');
        case ParamsInvalidUserFailure:
          return EmailOrPasswordInvalidErrorState('Email ou Senha inválidos');
        default:
          return ErrorState('Não foi possível realizar o cadastro');
      }
    }, (success) => SuccessState()));
  }

  @override
  void dispose() {
    close();
  }
}
