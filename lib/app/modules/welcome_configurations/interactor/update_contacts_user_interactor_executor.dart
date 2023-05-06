import 'package:app/app/core/models/user_account.dart';
import 'package:app/app/core/services/firebase_auth_service.dart';
import 'package:app/app/core/services/firestore_service.dart';
import 'package:app/app/core/services/network_service.dart';
import 'package:app/app/modules/welcome_configurations/interactor/update_contacts_user_interactor_provider.dart';
import 'package:app/app/modules/welcome_configurations/interactor/update_contacts_user_interactor_receiver.dart';
import 'package:app/app/modules/welcome_configurations/presenter/update_contacts_user_presenter_listener.dart';
import 'package:app/app/modules/welcome_configurations/repository/update_contacts_user_repository_execute.dart';
import 'package:app/app/modules/welcome_configurations/repository/update_contacts_user_repository_firebase.dart';
import 'package:flutter_modular/flutter_modular.dart';

class UpdateContactsUserInteractorExecutor
    implements
        UpdateContactsUserInteractorProvider,
        UpdateContactsUserInteractorReceiver {
  late UpdateContactsUserRepositoryExecute _repositoryExecute;
  late UpdateContactsUserPresenterListener _updateContactsUserPresenterListener;
  late FirebaseAuthService _authService;
  late FirestoreService _firestore;
  late NetworkService _networkService;

  UpdateContactsUserInteractorExecutor(
      {UpdateContactsUserPresenterListener? listener,
      UpdateContactsUserRepositoryExecute? repository,
      FirebaseAuthService? authService,
      FirestoreService? firestoreService,
      NetworkService? networkService}) {
    _updateContactsUserPresenterListener = listener!;
    _networkService = networkService ?? Modular.get<NetworkServiceImpl>();
    _authService =
        authService ?? authService ?? Modular.get<FirebaseAuthServiceImpl>();
    this._firestore = firestoreService ?? Modular.get<FirestoreServiceImpl>();
    _repositoryExecute = repository ??
        UpdateContactsUserRepositoryFirebase(
            this, _networkService, _firestore, _authService);
  }

  @override
  void handleUpdateContactsUserException(Exception exception) {
    _updateContactsUserPresenterListener
        .handleUpdateContactsUserException(exception);
  }

  @override
  Future<void> updateContactsUser(UserAccount userActual) async {
    await _repositoryExecute.execute(userActual);
  }

  @override
  void updateContactsUserReceiver(bool result) {
    _updateContactsUserPresenterListener.updateContactsUserReceiver(result);
  }
}
