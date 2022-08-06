import 'package:app/app/modules/home/infra/models/current_position_model.dart';

import '../../../core/services/locations_service.dart';
import '../infra/datasources/informations_map_datasource.dart';

class InformationsMapFromGoogle implements InformationMapDatasource {
  final LocationsService locationsService;
  InformationsMapFromGoogle(this.locationsService);

  @override
  Future<CurrentPositionModel> getCurrentLocation() async {
    final location = await locationsService.getCurrentLocation();
    return CurrentPositionModel(location.latitude, location.longitude);
  }
}
