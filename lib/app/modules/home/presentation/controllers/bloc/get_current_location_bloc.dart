import 'package:app/app/core/presentation/controller/app_state.dart';
import 'package:app/app/core/usecases/usecase.dart';
import 'package:app/app/modules/home/domain/usecases/get_current_position.dart';
import 'package:app/app/modules/home/presentation/controllers/events/home_event.dart';
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
  CurrentPosition? _location;
  CameraPosition? position;
  _onGetCurrentLocation(
      GetCurrentLocationEvent event, Emitter<AppState> emit) async {
    emit(ProcessingState());
    final result = await _usecase.call(NoParams());
    emit(result.fold(
        (failure) => ErrorState('Não foi possível capturar sua localização'),
        (success) {
      _location = success;
      position = CameraPosition(
        target: LatLng(_location!.lat, _location!.long),
        zoom: 14.4746,
      );
      return SuccessGetCurrentLocationState();
    }));
  }

  @override
  void dispose() {
    close();
  }
}
