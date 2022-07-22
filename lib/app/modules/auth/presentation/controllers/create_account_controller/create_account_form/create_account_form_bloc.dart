import 'package:app/app/core/presentation/controller/app_state.dart';
import 'package:app/app/core/utils/validations/validations.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'create_account_form_event.dart';

class CreateAccountFormBloc extends Bloc<CreateAccountFormEvent, AppState>
    implements Disposable {
  CreateAccountFormBloc() : super(InitialState()) {
    on<CreateAccountFormEvent>(_onCreateAccountFormEvent);
  }
  _onCreateAccountFormEvent(
      CreateAccountFormEvent event, Emitter<AppState> emit) {
    emit(ProcessingState());

    if (event.name.isEmpty ||
        event.email.isEmpty ||
        event.password.isEmpty ||
        event.confirmePassword.isEmpty) {
      emit(EmptyParamsErrorState('Alguma informação está vazia'));
    } else if (event.password != event.confirmePassword) {
      emit(ErrorState('As senhas inseridas são diferentes'));
    } else if (!(Validations.passwordValidation(password: event.password))) {
      emit(ErrorState('A Senha é inválido'));
    } else if (!(Validations.passwordValidation(
        password: event.confirmePassword))) {
      emit(ErrorState('A Senha de Confirmação é inválida'));
    } else if (!(Validations.emailValidation(email: event.email))) {
      emit(ErrorState('Email informado é inválido'));
    } else {
    emit(SuccessState());
    }
  }

  @override
  void dispose() {
    close();
  }
}
