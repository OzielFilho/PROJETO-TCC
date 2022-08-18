import 'package:bloc/bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/presentation/controller/app_state.dart';
import '../../../domain/entities/user_create.dart';
import '../../../domain/usecases/create_account_with_email_and_password.dart';
import 'create_account_event.dart';

class CreateAccountBloc
    extends Bloc<CreateAccountWithEmailAndPasswordEvent, AppState>
    implements Disposable {
  final CreateAccountWithEmailAndPassword _createUser;
  CreateAccountBloc(this._createUser) : super(InitialState()) {
    on<CreateAccountWithEmailAndPasswordEvent>(
        _onCreateAccountWithEmailAndPasswordEvent);
  }

  _onCreateAccountWithEmailAndPasswordEvent(
      CreateAccountWithEmailAndPasswordEvent event,
      Emitter<AppState> emit) async {
    emit(ProcessingState());

    final result = await _createUser.call(UserCreate(
        email: event.email,
        password: event.password,
        name: event.name,
        welcomePage: event.welcomePage,
        confirmePassword: event.confirmePassword,
        contacts: event.contacts,
        photo: event.photo,
        phone: event.phone));
    emit(result.fold((failure) {
      switch (failure.runtimeType) {
        case ParamsEmptyUserFailure:
          return EmptyParamsErrorState(
              'Para realizar o cadastro todas as informações devem ser fornecidas');
        case PasswordAndConfirmePasswordDifferenceFailure:
          return PasswordDifferenceInvalidErrorState(
              'As senhas não correspondem');
        case PhoneInvalidFailure:
          return PhoneInvalidErrorState('Telefone inválido');
        case NetworkFailure:
          return NetworkErrorState('Sem conexão com a internet');
        case PhoneExistFailure:
          return PhoneInvalidErrorState('Telefone já existe');
        case ParamsInvalidUserFailure:
          return EmailOrPasswordInvalidErrorState('Email ou Senha Inválidos');
        default:
          return ErrorState('Não foi possível realizar o cadastro');
      }
    }, (success) => SuccessCreateAccountState()));
  }

  @override
  void dispose() {
    close();
  }
}
