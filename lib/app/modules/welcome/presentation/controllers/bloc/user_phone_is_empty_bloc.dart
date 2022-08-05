import 'package:app/app/core/presentation/controller/app_state.dart';
import 'package:app/app/core/utils/validations/validations.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../event/welcome_event.dart';

class UserPhoneIsEmptyBloc extends Bloc<WelcomeEvent, AppState>
    implements Disposable {
  UserPhoneIsEmptyBloc() : super(InitialState()) {
    on<PhoneIsEmptyEvent>(_onUserPhoneEmpty);
  }
  String? phone = '';

  _onUserPhoneEmpty(PhoneIsEmptyEvent event, Emitter<AppState> emit) {
    emit(ProcessingState());

    if (event.phone.isEmpty) {
      emit(PhoneEmptyErrorState('Seu telefone não pode está vazio'));
    }

    if (!Validations.phoneValidation(phone: event.phone)) {
      emit(PhoneInvalidErrorState('Telefone Inserido é inválido'));
    }

    if (Validations.emailValidation(email: event.phone)) {
      phone = event.phone;
      emit(SuccessState());
    }
  }

  @override
  void dispose() {
    close();
  }
}
