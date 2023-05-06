import 'package:app/app/core/models/user_account.dart';

abstract class UpdateContactsUserRepositoryExecute {
  Future<void> execute(UserAccount? userActual);
}
