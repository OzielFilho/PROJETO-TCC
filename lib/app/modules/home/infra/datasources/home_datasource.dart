import '../../../auth/infra/models/auth_result_model.dart';
import '../models/current_position_model.dart';

abstract class HomeDatasource {
  Future<void> logoutUser();
  Future<CurrentPositionModel> getCurrentLocation();
  Future<AuthResultModel> getUserHome();
}
