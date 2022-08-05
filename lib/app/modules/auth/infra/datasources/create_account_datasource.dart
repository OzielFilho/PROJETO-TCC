import '../../domain/entities/auth_result.dart';
import '../models/user_create_model.dart';

abstract class CreateAccountDatasource {
  Future<AuthResult> createAccountWithEmailAndPassword(UserCreateModel user);
}
