import 'package:flutter/material.dart';

import '../models/authentication_params_model.dart';

abstract class AuthenticationEmailAndPasswordPresenterProvider {
  Stream<Object> get outAuthController;

  Future<void> authenticationEmailAndPassword(
      {required AuthenticationParamsModel params});
}
