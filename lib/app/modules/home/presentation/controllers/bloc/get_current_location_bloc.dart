import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/presentation/controller/app_state.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../../../core/utils/constants/constants.dart';
import '../../../domain/usecases/get_current_position.dart';
import '../events/home_event.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import '../../../domain/entities/current_position.dart';

class GetCurrentLocationBloc extends Bloc<HomeEvent, AppState>
    implements Disposable {
  GetCurrentPosition _usecase;

  GetCurrentLocationBloc(this._usecase) : super(InitialState()) {
    on<GetCurrentLocationEvent>(_onGetCurrentLocation);
  }
  CurrentPosition? location;
  CameraPosition? position;

  final _places =
      GoogleMapsPlaces(apiKey: "AIzaSyBqhOxHQZ1hk4KFC4086Ia2Y4X8Xt7JcK8");

  Set<Marker> markers = {};
  Future<void> _retrieveNearbyPolices(CurrentPosition _userLocation) async {
    PlacesSearchResponse _response = await _places.searchNearbyWithRadius(
        Location(lat: _userLocation.lat, lng: _userLocation.long), 50000,
        type: "police");
    BitmapDescriptor markerbitmap = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(100, 100)),
        "assets/images/marker_custom.png",
        mipmaps: false);
    Set<Marker> _restaurantMarkers = _response.results.map((result) {
      return Marker(
          markerId: MarkerId(result.name),
          icon: markerbitmap,
          infoWindow: InfoWindow(
              title: result.name,
              onTap: () async {
                await launchUrlString(Constants.urlGoogleMaps(
                    result.geometry!.location.lat,
                    result.geometry!.location.lng));
              },
              snippet: "${result.vicinity}"),
          position: LatLng(
              result.geometry!.location.lat, result.geometry!.location.lng));
    }).toSet();

    markers.addAll(_restaurantMarkers);
  }

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
        zoom: 15,
      );

      return ProcessingState();
    }));
    await _retrieveNearbyPolices(location!)
        .whenComplete(() => emit(SuccessGetCurrentLocationState()));
  }

  @override
  void dispose() {
    close();
  }
}
