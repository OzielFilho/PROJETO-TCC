import '../../../../core/presentation/controller/app_state.dart';
import '../../domain/usecases/logged_user.dart';
import 'splash_event.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';

class SplashBloc extends Bloc<SplashEvent, AppState> implements Disposable {
  final LoggedUser _logged;
  SplashBloc(this._logged) : super(InitialState()) {
    on<LoggedUserEvent>(_onLoggedUserEvent);
  }

  _onLoggedUserEvent(LoggedUserEvent event, Emitter<AppState> emit) async {
    emit(ProcessingState());
    final result = await _logged.call(NoParams());

    emit(result.fold((failure) {
      switch (failure.runtimeType) {
        case LoggedUserFailure:
          return ErrorState('');
        default:
          return ErrorState('');
      }
    }, (success) => success ? SuccessState() : UserNotLoggedState()));
  }

  @override
  void dispose() {
    close();
  }
}
