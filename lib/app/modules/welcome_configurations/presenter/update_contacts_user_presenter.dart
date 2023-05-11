import 'dart:async';

import 'package:app/app/core/models/user_account.dart';
import 'package:app/app/modules/welcome_configurations/interactor/update_contacts_user_interactor_executor.dart';
import 'package:app/app/modules/welcome_configurations/interactor/update_contacts_user_interactor_provider.dart';
import 'package:app/app/modules/welcome_configurations/presenter/update_contacts_user_presenter_listener.dart';
import 'package:app/app/modules/welcome_configurations/presenter/update_contacts_user_presenter_provider.dart';
import 'package:flutter/cupertino.dart';

class UpdateContactsUserPresenter extends ChangeNotifier
    implements
        UpdateContactsUserPresenterProvider,
        UpdateContactsUserPresenterListener {
  final _controllerContacts = StreamController<Object>();
  final _controllerPhone = StreamController<Object>();

  late UpdateContactsUserInteractorProvider _provider;
  late bool _isUpdateContact;

  UpdateContactsUserPresenter(
      {UpdateContactsUserInteractorProvider? provider}) {
    _provider =
        provider ?? UpdateContactsUserInteractorExecutor(listener: this);
  }

  @override
  void handleUpdateContactsUserException(Exception exception) {
    _isUpdateContact
        ? _controllerContacts.sink.add(exception)
        : _controllerPhone.sink.add(exception);
  }

  @override
  Stream<Object> get outUpdatePhoneUser => _controllerContacts.stream;

  @override
  Future<void> updateContactsUser(UserAccount userAccount) async {
    _isUpdateContact = true;
    await _provider.updateContactsUser(userAccount);
  }

  @override
  void updateContactsUserReceiver(bool result) {
    _isUpdateContact
        ? _controllerContacts.sink.add(result)
        : _controllerPhone.sink.add(result);
  }

  @override
  void dispose() {
    _controllerContacts.close();
    _controllerPhone.close();
    super.dispose();
  }

  @override
  Stream<Object> get outUpdateContactsUser => _controllerContacts.stream;

  @override
  Future<void> updatePhoneUser(UserAccount userAccount) async {
    _isUpdateContact = false;
    await _provider.updateContactsUser(userAccount);
  }
}
