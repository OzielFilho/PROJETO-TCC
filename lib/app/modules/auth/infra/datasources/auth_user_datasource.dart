abstract class AuthUserDatasource {
  Future<bool> login(String email, String password);
}
