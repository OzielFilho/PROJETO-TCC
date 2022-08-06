import 'package:geolocator/geolocator.dart';

abstract class LocationsService {
  Future<Position> getCurrentLocation();
}

class LocationsServiceImpl implements LocationsService {
  @override
  Future<Position> getCurrentLocation() async {
    return await Geolocator.getCurrentPosition();
  }
}
