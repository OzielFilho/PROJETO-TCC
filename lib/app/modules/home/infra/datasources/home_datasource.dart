import '../models/current_position_model.dart';
import '../models/user_result_home_model.dart';

abstract class HomeDatasource {
  Future<void> logoutUser();
  Future<CurrentPositionModel> getCurrentLocation();
  Future<UserResultHomeModel> getUserHome();
}
