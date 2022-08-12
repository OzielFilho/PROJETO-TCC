import 'package:bloc/bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/presentation/controller/app_state.dart';
import '../../../../../core/utils/constants/encrypt_data.dart';
import '../../../domain/entities/update_user.dart';
import '../../../domain/usecases/update_user_create.dart';
import '../event/welcome_event.dart';

class UpdateUserCreateBloc extends Bloc<WelcomeEvent, AppState>
    implements Disposable {
  final UpdateUserCreate _usecase;
  UpdateUserCreateBloc(this._usecase) : super(InitialState()) {
    on<UpdateUserCreateEvent>(_onUpdateUserCreatesEvent);
  }
  _onUpdateUserCreatesEvent(
      UpdateUserCreateEvent event, Emitter<AppState> emit) async {
    emit(ProcessingState());

    String phone = event.phone;
    if (!phone.startsWith('(')) {
      phone = EncryptData().decrypty(phone);
    }

    UpdateUserWelcome userWelcome = UpdateUserWelcome(
        contacts: event.contacts,
        email: event.email,
        name: event.name,
        phone: phone,
        welcomePage: event.welcomePage);

    final result = await _usecase.call(userWelcome);
    emit(result.fold((failure) {
      switch (failure.runtimeType) {
        case PhoneEmptyFailure:
          return PhoneEmptyErrorState('Telefone não pode está vazio');
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
