import '../../domain/entities/auth_result.dart';

class AuthResultModel extends AuthResult {
  AuthResultModel(String email, String? tokenId, bool welcomePage)
      : super(email, tokenId, welcomePage);
  AuthResultModel.empty(
      {String email = '', String? tokenId = '', bool welcomePage = false})
      : super('', '', false);
  factory AuthResultModel.fromDocument(Map<String, dynamic> data) =>
      AuthResultModel(data['email'], '', data['welcomePage']);
}
