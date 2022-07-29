import 'package:app/app/core/usecases/usecase.dart';
import 'package:app/app/modules/welcome/domain/usecases/get_user_create.dart';
import 'package:app/app/modules/welcome/presentation/controllers/welcome_event.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/presentation/controller/app_state.dart';
import '../../../auth/domain/entities/auth_result.dart';

class GetUserWelcomeBloc extends Bloc<WelcomeEvent, AppState>
    implements Disposable {
  final GetUserCreate _userCreate;
  GetUserWelcomeBloc(this._userCreate) : super(InitialState()) {
    on<GetUserEvent>(_onGetUserEvent);
  }
  AuthResult? user;

  _onGetUserEvent(GetUserEvent event, Emitter<AppState> emit) async {
    emit(ProcessingState());
    final result = await _userCreate.call(NoParams());
    emit(result.fold((failure) => ErrorState('Serviço indisponível no momento'),
        (success) {
      user = success;
      return SuccessGetUserState();
    }));
  }

  @override
  void dispose() {
    close();
  }
}
