import 'dart:async';

import 'package:app/app/core/models/user_account.dart';

abstract class UpdateContactsUserPresenterProvider {
  Future<void> updateContactsUser(UserAccount userAccount);
  Stream<Object> get outUpdateContactsUser;
}
