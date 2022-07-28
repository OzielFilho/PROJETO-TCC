import 'package:app/app/core/services/firestore_service.dart';
import 'package:app/app/modules/splash/infra/models/user_logged_info_model.dart';

import '../../../core/services/firebase_auth_service.dart';
import '../infra/datasources/refresh_account_datasource.dart';

class FirebaseRefreshAccount implements RefreshAccountDatasource {
  final FirebaseAuthService auth;
  final FirestoreService firestore;
  FirebaseRefreshAccount(this.auth, this.firestore);

  @override
  Future<UserLoggedInfoModel> loggedUser() async {
    final token = await auth.getToken();
    final user = await firestore.getDocument('users', token);
    final logged = await auth.userLogged();

    final result = UserLoggedInfoModel(
        logged: logged, welcomePage: user['welcomePage'], phone: user['phone']);
    return result;
  }
}
