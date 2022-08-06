import 'package:geolocator/geolocator.dart';

abstract class LocationsService {
  Future<Position> getCurrentLocation();
}

class LocationsServiceImpl implements LocationsService {
  @override
  Future<Position> getCurrentLocation() async {
    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever ||
        permission == LocationPermission.unableToDetermine) {
      await Geolocator.requestPermission();
    }
    return await Geolocator.getCurrentPosition();
  }
}
