import 'package:app/app/modules/welcome/infra/models/finalization_user_model.dart';

import '../../../auth/infra/models/auth_result_model.dart';

abstract class WelcomeDatasource {
  Future<AuthResultModel> finalizationUserCreate(FinalizationUserModel user);
}
