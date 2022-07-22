import 'package:app/app/core/presentation/controller/app_state.dart';
import 'package:app/app/modules/splash/domain/usecases/logged_user.dart';
import 'package:app/app/modules/splash/presentation/controllers/splash_event.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';

class SplashBloc extends Bloc<SplashEvent, AppState> implements Disposable {
  final LoggedUser _usecase;
  SplashBloc(this._usecase) : super(InitialState()) {
    on<LoggedUserEvent>(_onLoggedUserEvent);
  }

  _onLoggedUserEvent(LoggedUserEvent event, Emitter<AppState> emit) async {
    emit(ProcessingState());
    final result = await _usecase.call(NoParams());

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
