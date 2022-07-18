abstract class AuthUserDatasource {
  Future<bool> login(String email, String password);
  Future<bool> loginGoogle(String idToken, String accessToken);
  Future<bool> createUser(String email, String password);
}
