import '../models/user_logged_info_model.dart';

abstract class RefreshAccountDatasource {
  Future<UserLoggedInfoModel> loggedUser();
}
