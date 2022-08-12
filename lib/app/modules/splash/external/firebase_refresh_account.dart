import '../../../core/services/firebase_auth_service.dart';
import '../../../core/services/firestore_service.dart';
import '../infra/datasources/refresh_account_datasource.dart';
import '../infra/models/user_logged_info_model.dart';

class FirebaseRefreshAccount implements RefreshAccountDatasource {
  final FirebaseAuthService auth;
  final FirestoreService firestore;
  FirebaseRefreshAccount(this.auth, this.firestore);

  @override
  Future<UserLoggedInfoModel> loggedUser() async {
    UserLoggedInfoModel result = UserLoggedInfoModel.toEmpty();
    final token = await auth.getToken();
    if (token.isNotEmpty) {
      final user = await firestore.getDocument('users', token);
      final logged = await auth.userLogged();

      result = UserLoggedInfoModel(
          logged: logged,
          welcomePage: user['welcomePage'],
          phone: user['phone']);
    }

    return result;
  }
}
