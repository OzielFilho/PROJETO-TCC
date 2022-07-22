import 'dart:developer';

import 'package:app/app/modules/splash/infra/datasources/refresh_account_datasource.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseRefreshAccount implements RefreshAccountDatasource {
  final FirebaseAuth auth;

  FirebaseRefreshAccount(this.auth);

  @override
  Future<bool> loggedUser() async {
    final result = await auth.currentUser?.getIdToken() ?? '';
    return result.isNotEmpty;
  }
}
