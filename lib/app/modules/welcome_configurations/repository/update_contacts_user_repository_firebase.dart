import 'dart:async';

import 'package:app/app/core/models/user_account.dart';
import 'package:app/app/core/services/firebase_auth_service.dart';
import 'package:app/app/core/services/firestore_service.dart';
import 'package:app/app/core/services/network_service.dart';
import 'package:app/app/core/utils/constants/encrypt_data.dart';
import 'package:app/app/modules/welcome_configurations/interactor/update_contacts_user_interactor_receiver.dart';
import 'package:app/app/modules/welcome_configurations/repository/update_contacts_user_repository_execute.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/error/exceptions.dart';

class UpdateContactsUserRepositoryFirebase
    implements UpdateContactsUserRepositoryExecute {
  final UpdateContactsUserInteractorReceiver _receiver;
  final NetworkService _networkService;
  final FirestoreService _firestoreService;
  final FirebaseAuthService _fireAuthService;

  UpdateContactsUserRepositoryFirebase(this._receiver, this._networkService,
      this._firestoreService, this._fireAuthService);

  @override
  Future<void> execute(UserAccount? userActual) async {
    try {
      if (await _networkService.hasConnection) {
        final user = userActual ?? UserAccount.instance;
        final token = user.token ?? await _fireAuthService.getToken();
        if (user.phone.isNotEmpty) {
          final phoneCrypt = EncryptData().encrypty(user.phone).base16;
          final existeDoc =
              await _firestoreService.existDocument('contacts', phoneCrypt);
          if (!(existeDoc)) {
            await _firestoreService
                .createDocument('contacts', phoneCrypt, {'tokenId': token});
          }
        }
        user.contacts =
            user.contacts.map((e) => EncryptData().encrypty(e).base16).toList();

        await _firestoreService.updateDocument('users', token, user.toJson);

        _receiver.updateContactsUserReceiver(true);
        return;
      }
      _receiver.handleUpdateContactsUserException(NetworkException());
    } on NetworkException catch (exception) {
      _receiver.handleUpdateContactsUserException(exception);
    } on TimeoutException catch (exception) {
      _receiver.handleUpdateContactsUserException(exception);
    } on FirebaseAuthException catch (exception) {
      _receiver.handleUpdateContactsUserException(exception);
    } on FirebaseException catch (exception) {
      _receiver.handleUpdateContactsUserException(exception);
    } on Exception catch (exception) {
      _receiver.handleUpdateContactsUserException(exception);
    }
  }
}
