import 'dart:async';

import 'package:app/app/core/services/network_service.dart';
import 'package:app/app/modules/authentication/create_account_with_email_and_password/models/user_create_account_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'dart:io';

import '../../../../core/error/exceptions.dart';
import '../../../../core/services/firebase_auth_service.dart';
import '../../../../core/utils/validations/validations.dart';
import '../interactor/create_account_with_email_and_password_receiver.dart';
import 'create_account_with_email_and_password_repository_executor.dart';

class CreateAccountWithEmailAndPasswordFirebaseRepository
    implements CreateAccountWithEmailAndPasswordRepositoryExecutor {
  final CreateAccountWithEmailAndPasswordReceiver _receiver;
  final FirebaseAuthService _authService;
  final NetworkService _networkService;

  CreateAccountWithEmailAndPasswordFirebaseRepository(
      this._receiver, this._authService, this._networkService);

  @override
  Future<void> createAccount(
      UserCreateAccountModel userCreateAccountModel, File? image) async {
    if (userCreateAccountModel.email.isEmpty ||
        userCreateAccountModel.password.isEmpty ||
        userCreateAccountModel.confirmePassword.isEmpty ||
        userCreateAccountModel.name.isEmpty ||
        userCreateAccountModel.phone.isEmpty) {
      _receiver
          .handleCreateAccountExceptionReceiver(ParamsEmptyUserException());
      return;
    }
    if (!(Validations.emailValidation(email: userCreateAccountModel.email))) {
      _receiver
          .handleCreateAccountExceptionReceiver(ParamsInvalidUserException());
      return;
    }
    if (!(Validations.phoneValidation(phone: userCreateAccountModel.phone))) {
      _receiver.handleCreateAccountExceptionReceiver(PhoneInvalidException());
      return;
    }
    if (userCreateAccountModel.password !=
        userCreateAccountModel.confirmePassword) {
      _receiver.handleCreateAccountExceptionReceiver(
          PasswordAndConfirmePasswordDifferenceException());
      return;
    }

    if (!(Validations.passwordValidation(
            password: userCreateAccountModel.password)) &&
        !(Validations.passwordValidation(
            password: userCreateAccountModel.confirmePassword))) {
      _receiver
          .handleCreateAccountExceptionReceiver(ParamsInvalidUserException());
      return;
    }

    try {
      if (await _networkService.hasConnection) {
        final result =
            await _authService.createAccount(userCreateAccountModel, image);
        _receiver.createdAccountReceiver(result);
        return;
      }
      _receiver.handleCreateAccountExceptionReceiver(NetworkException());
    } on NetworkException catch (exception) {
      _receiver.handleCreateAccountExceptionReceiver(exception);
    } on TimeoutException catch (exception) {
      _receiver.handleCreateAccountExceptionReceiver(exception);
    } on FirebaseAuthException catch (exception) {
      _receiver.handleCreateAccountExceptionReceiver(exception);
    } on FirebaseException catch (exception) {
      _receiver.handleCreateAccountExceptionReceiver(exception);
    } on Exception catch (exception) {
      _receiver.handleCreateAccountExceptionReceiver(exception);
    }
  }
}
