import '../../domain/entities/auth_result.dart';

class AuthResultModel extends AuthResult {
  AuthResultModel(String email, String? tokenId, bool welcomePage, String phone,
      String name)
      : super(email, tokenId, welcomePage, phone, name);
  AuthResultModel.empty(
      {String email = '', String? tokenId = '', bool welcomePage = false})
      : super('', '', false, '', '');
  factory AuthResultModel.fromDocument(Map<String, dynamic> data) =>
      AuthResultModel(
          data['email'], '', data['welcomePage'], data['phone'], data['name']);
}
