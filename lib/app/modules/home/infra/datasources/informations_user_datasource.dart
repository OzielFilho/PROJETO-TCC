import 'package:app/app/modules/auth/infra/models/auth_result_model.dart';

abstract class InformationUserDatasource {
  Future<AuthResultModel> getUserHome();
}
