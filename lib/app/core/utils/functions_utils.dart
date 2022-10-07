import '../services/locations_service.dart';
import '../../modules/home/domain/entities/current_position.dart';

class FunctionUtils {
  static String currentLocationMessage(CurrentPosition position) {
    return 'Olá, minha localização atual é https://www.google.com/maps/place/${position.lat},${position.long}';
  }

  static Future<CurrentPosition> getLocation() async {
    final location = await LocationsServiceImpl().getCurrentLocation();
    return CurrentPosition(location.latitude, location.longitude);
  }
}
