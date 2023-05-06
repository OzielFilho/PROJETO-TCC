import 'package:app/app/core/models/user_account.dart';

abstract class UpdateContactsUserInteractorProvider {
  Future<void> updateContactsUser(UserAccount userActual);
}
