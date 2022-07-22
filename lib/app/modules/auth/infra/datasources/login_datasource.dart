import '../../domain/entities/auth_result.dart';

abstract class LoginDatasource {
  Future<AuthResult> loginWithEmailAndPassword(String email, String password);
  Future<AuthResult> loginWithGoogle();
}
