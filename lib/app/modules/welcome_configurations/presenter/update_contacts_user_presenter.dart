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
  final _controller = StreamController<Object>();

  late UpdateContactsUserInteractorProvider _provider;

  UpdateContactsUserPresenter(
      {UpdateContactsUserInteractorProvider? provider}) {
    _provider =
        provider ?? UpdateContactsUserInteractorExecutor(listener: this);
  }

  @override
  void handleUpdateContactsUserException(Exception exception) {
    _controller.sink.add(exception);
  }

  @override
  Stream<Object> get outUpdateContactsUser => _controller.stream;

  @override
  Future<void> updateContactsUser(UserAccount userAccount) async {
    await _provider.updateContactsUser(userAccount);
  }

  @override
  void updateContactsUserReceiver(bool result) {
    _controller.sink.add(result);
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
