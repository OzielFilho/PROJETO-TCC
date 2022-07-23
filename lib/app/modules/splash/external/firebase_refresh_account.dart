import '../../../core/services/firebase_auth_service.dart';
import '../infra/datasources/refresh_account_datasource.dart';

class FirebaseRefreshAccount implements RefreshAccountDatasource {
  final FirebaseAuthServiceImpl auth;

  FirebaseRefreshAccount(this.auth);

  @override
  Future<bool> loggedUser() async {
    final result = await auth.userLogged();
    return result;
  }
}
