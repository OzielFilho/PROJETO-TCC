import 'dart:io';

import 'package:google_sign_in/google_sign_in.dart';

import '../../../core/services/firebase_auth_service.dart';
import '../../../core/services/firestorage_service.dart';
import '../../../core/services/firestore_service.dart';
import '../infra/datasources/create_account_datasource.dart';
import '../infra/models/user_create_account_model.dart';

class FirebaseAuthDatasourceImpl implements CreateAccountDatasource {
  final FirebaseAuthService authService;
  final GoogleSignIn googleSignIn;
  final FirestorageService firestorageService;
  final FirestoreService firestore;
  FirebaseAuthDatasourceImpl({
    required this.firestorageService,
    required this.authService,
    required this.googleSignIn,
    required this.firestore,
  });
  @override
  Future<String> createWithEmailAndPassword(
      UserCreateAccountModel user, File? image) async {
    return await authService.createAccount(user, image);
  }
}
