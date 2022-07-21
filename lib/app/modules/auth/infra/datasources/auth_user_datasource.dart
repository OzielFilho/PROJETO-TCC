import '../../domain/entities/auth_result.dart';

abstract class AuthUserDatasource {
  Future<AuthResult> login(String email, String password);
  Future<bool> loginGoogle(String idToken, String accessToken);
  Future<bool> createUser(String email, String password);
  Future<bool> recoveryPassword(String email);
}
