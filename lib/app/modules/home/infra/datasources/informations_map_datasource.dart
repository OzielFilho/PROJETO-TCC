import '../models/current_position_model.dart';

abstract class InformationMapDatasource {
  Future<CurrentPositionModel> getCurrentLocation();
}
