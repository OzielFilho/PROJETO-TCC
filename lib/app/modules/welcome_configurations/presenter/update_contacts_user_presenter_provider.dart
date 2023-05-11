import 'dart:async';

import 'package:app/app/core/models/user_account.dart';

abstract class UpdateContactsUserPresenterProvider {
  Future<void> updatePhoneUser(UserAccount userAccount);
  Future<void> updateContactsUser(UserAccount userAccount);
  Stream<Object> get outUpdatePhoneUser;
  Stream<Object> get outUpdateContactsUser;
}
