import 'dart:io';

import '../models/user_create_account_model.dart';

abstract class CreateAccountDatasource {
  Future<String> createWithEmailAndPassword(
      UserCreateAccountModel user, File? image);
}
