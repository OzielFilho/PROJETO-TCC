import 'package:app/app/modules/auth/infra/models/auth_result_model.dart';
import 'package:app/app/modules/welcome/infra/datasources/welcome_datasource.dart';
import 'package:app/app/modules/welcome/infra/models/finalization_user_model.dart';

class FirebaseAuthDatasourceImpl implements WelcomeDatasource {
  @override
  Future<AuthResultModel> finalizationUserCreate(FinalizationUserModel user) {
    // TODO: implement finalizationUserCreate
    throw UnimplementedError();
  }
}
