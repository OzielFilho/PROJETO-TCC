import '../../domain/entities/auth_result.dart';

abstract class CreateAccountDatasource {
  Future<AuthResult> createAccountWithEmailAndPassword(
      String email, String password);
}
