import 'package:app/app/core/models/user_actual.dart';

abstract class UpdateContactsUserInteractorProvider {
  Future<void> updateContactsUser(UserActual userActual);
}
