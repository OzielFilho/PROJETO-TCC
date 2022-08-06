import 'package:app/app/core/services/firebase_auth_service.dart';
import 'package:app/app/core/services/firestore_service.dart';
import 'package:app/app/modules/auth/infra/models/auth_result_model.dart';
import 'package:app/app/modules/home/infra/datasources/informations_user_datasource.dart';

class InformationsUserFromFirebase implements InformationUserDatasource {
  final FirebaseAuthService authService;
  final FirestoreService firestoreService;
  InformationsUserFromFirebase({
    required this.authService,
    required this.firestoreService,
  });

  @override
  Future<AuthResultModel> getUserHome() async {
    final tokenId = await authService.getToken();
    final data = await firestoreService.getDocument('users', tokenId);
    return AuthResultModel.fromDocument(data);
  }
}
