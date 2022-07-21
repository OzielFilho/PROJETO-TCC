import 'package:app/app/modules/auth/domain/entities/auth_result.dart';

class AuthResultModel extends AuthResult {
  AuthResultModel(String email, String? tokenId) : super(email, tokenId);
  AuthResultModel.empty({String email = '', String? tokenId = ''})
      : super('', '');
}
