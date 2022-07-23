import '../models/user_create_model.dart';

import '../../domain/entities/auth_result.dart';

abstract class CreateAccountDatasource {
  Future<AuthResult> createAccountWithEmailAndPassword(UserCreateModel user);
}
