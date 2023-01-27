import 'package:app/app/core/services/firebase_auth_service.dart';
import 'package:app/app/core/services/network_service.dart';
import 'package:app/app/modules/authentication/create_account_with_email_and_password/models/user_create_account_model.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'dart:io';

import '../presenter/create_account_with_email_and_password_presenter_listener.dart';
import '../repository/create_account_with_email_and_password_firebase_repository.dart';
import 'create_account_with_email_and_password_provider.dart';
import 'create_account_with_email_and_password_receiver.dart';

class CreateAccountWithEmailAndPasswordExecutor
    implements
        CreateAccountWithEmailAndPasswordProvider,
        CreateAccountWithEmailAndPasswordReceiver {
  late CreateAccountWithEmailAndPasswordPresenterListener _listener;
  late FirebaseAuthService _authService;
  late NetworkService _networkService;

  CreateAccountWithEmailAndPasswordExecutor(
      {CreateAccountWithEmailAndPasswordPresenterListener? listener,
      FirebaseAuthService? authService,
      NetworkService? networkService})
      : _listener = listener!,
        _authService = authService ?? Modular.get<FirebaseAuthServiceImpl>(),
        _networkService = networkService ?? Modular.get<NetworkServiceImpl>();

  @override
  Future<void> createAccount(
      UserCreateAccountModel userCreateAccountModel, File? image) async {
    final repository = CreateAccountWithEmailAndPasswordFirebaseRepository(
        this, _authService, _networkService);
    await repository.createAccount(userCreateAccountModel, image);
  }

  @override
  void createdAccountReceiver(String result) {
    _listener.createdAccountReceiver(result);
  }

  @override
  void handleCreateAccountExceptionReceiver(Exception exception) {
    _listener.handleCreateAccountExceptionReceiver(exception);
  }
}
