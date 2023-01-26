import 'dart:io';

import '../../../authentication/create_account_with_email_and_password/models/user_create_account_model.dart';

abstract class CreateAccountDatasource {
  Future<String> createWithEmailAndPassword(
      UserCreateAccountModel user, File? image);
}
