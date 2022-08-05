import 'package:app/app/modules/welcome/domain/usecases/update_user_create.dart';
import 'package:app/app/modules/welcome/presentation/controllers/event/welcome_event.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/presentation/controller/app_state.dart';
import '../../../domain/entities/update_user.dart';

class UpdateUserCreateBloc extends Bloc<WelcomeEvent, AppState>
    implements Disposable {
  final UpdateUserCreate _usecase;
  UpdateUserCreateBloc(this._usecase) : super(InitialState()) {
    on<UpdateUserCreateEvent>(_onUpdateUserCreatesEvent);
  }
  ScrollController scrollController = ScrollController();
  _onUpdateUserCreatesEvent(
      UpdateUserCreateEvent event, Emitter<AppState> emit) async {
    emit(ProcessingState());

    UpdateUserWelcome userWelcome = UpdateUserWelcome(
        contacts: event.contacts,
        email: event.email,
        name: event.name,
        phone: event.phone,
        welcomePage: event.welcomePage);

    final result = await _usecase.call(userWelcome);
    emit(result.fold((failure) {
      switch (failure.runtimeType) {
        case PhoneEmptyFailure:
          return PhoneInvalidErrorState('Telefone não pode está vazio');
        case PhoneInvalidFailure:
          return PhoneInvalidErrorState('Telefone inserido inválido');
        case ListContactsEmptyFailure:
          return ListContactsErrorState('Insira no mínimo um telefone');
        default:
          return ErrorState('Serviço indisponível no momento');
      }
    }, (success) {
      return SuccessUpdateUserCreateState();
    }));
  }

  @override
  void dispose() {
    close();
  }
}
