import '../../../../../core/error/failure.dart';
import '../../../../../core/presentation/controller/app_state.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../domain/usecases/get_current_position.dart';
import '../events/home_event.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../domain/entities/current_position.dart';

class GetCurrentLocationBloc extends Bloc<HomeEvent, AppState>
    implements Disposable {
  GetCurrentPosition _usecase;

  GetCurrentLocationBloc(this._usecase) : super(InitialState()) {
    on<GetCurrentLocationEvent>(_onGetCurrentLocation);
  }
  CurrentPosition? location;
  CameraPosition? position;
  _onGetCurrentLocation(
      GetCurrentLocationEvent event, Emitter<AppState> emit) async {
    emit(ProcessingState());
    final result = await _usecase.call(NoParams());
    emit(result.fold((failure) {
      switch (failure.runtimeType) {
        case NetworkFailure:
          return NetworkErrorState('Sem conexão com a internet');
        default:
          return ErrorState('Não foi possível capturar sua localização');
      }
    }, (success) {
      location = success;
      position = CameraPosition(
        target: LatLng(location!.lat, location!.long),
        zoom: 17,
      );
      return SuccessGetCurrentLocationState();
    }));
  }

  @override
  void dispose() {
    close();
  }
}
