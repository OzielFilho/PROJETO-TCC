import 'package:app/app/core/models/user_actual.dart';
import 'package:app/app/modules/welcome_configurations/interactor/update_contacts_user_interactor_provider.dart';
import 'package:app/app/modules/welcome_configurations/interactor/update_contacts_user_interactor_receiver.dart';

class UpdateContactsUserInteractorExecutor
    implements
        UpdateContactsUserInteractorProvider,
        UpdateContactsUserInteractorReceiver {
  @override
  void handleUpdateContactsUserException(Exception exception) {
    // TODO: implement handleUpdateContactsUserException
  }

  @override
  Future<void> updateContactsUser(UserActual userActual) {
    // TODO: implement updateContactsUser
    throw UnimplementedError();
  }

  @override
  void updateContactsUserReceiver(bool result) {
    // TODO: implement updateContactsUserReceiver
  }
}
