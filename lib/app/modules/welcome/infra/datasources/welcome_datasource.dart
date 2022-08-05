import '../../../auth/infra/models/auth_result_model.dart';
import '../models/update_user_model.dart';

abstract class WelcomeDatasource {
  Future<void> updateUserCreate(UpdateUserWelcomeModel user);
  Future<AuthResultModel> getUserCreate();
}
