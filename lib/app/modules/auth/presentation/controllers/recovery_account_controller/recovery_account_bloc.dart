import 'package:app/app/modules/auth/presentation/controllers/login_controller/login_state.dart';
import 'package:app/app/modules/auth/presentation/controllers/recovery_account_controller/recovery_account_event.dart';
import 'package:app/app/modules/auth/presentation/pages/recovery_account.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/usecases/recovery_password.dart';

class RecoveryAccountBloc extends Bloc<RecoveryAccountWithEmailEvent, AppState>
    implements Disposable {
  final RecoveryPassword _recoveryPassword;
  RecoveryAccountBloc(this._recoveryPassword) : super(InitialState()) {
    on<RecoveryAccountWithEmailEvent>(_onRecoveryAccountEvent);
  }
  void _onRecoveryAccountEvent(
      RecoveryAccountWithEmailEvent event, Emitter<AppState> emit) async {
    emit(ProcessingState());

    final params = Params(email: event.email);
    final result = await _recoveryPassword.call(params);
    emit(result.fold((failure) {
      switch (failure.runtimeType) {
        case ParamsEmptyUserFailure:
          return EmailOrPasswordEmptyErrorState('Email está vazio');
        case ParamsInvalidUserFailure:
          return EmailOrPasswordInvalidErrorState('Email inválido');
        case RecoveryPasswordFailure:
          return ErrorState('Usuário não encotrado');
        default:
          return ErrorState('Erro ao enviar o link');
      }
    }, (success) => SuccessState()));
  }

  @override
  void dispose() {
    close();
  }
}
