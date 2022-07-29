import '../../../core/services/firebase_auth_service.dart';
import '../../../core/utils/constants/encrypt_data.dart';
import '../infra/models/user_create_model.dart';
import '../../../core/services/firestore_service.dart';
import '../infra/datasources/create_account_datasource.dart';
import '../infra/datasources/login_datasource.dart';
import '../infra/datasources/recovery_datasource.dart';
import '../infra/models/auth_result_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../domain/entities/auth_result.dart';

class FirebaseAuthDatasourceImpl
    implements LoginDatasource, CreateAccountDatasource, RecoveryDatasource {
  final FirebaseAuthServiceImpl authService;
  final GoogleSignIn googleSignIn;
  final FirestoreServiceImpl firestore;
  FirebaseAuthDatasourceImpl({
    required this.authService,
    required this.googleSignIn,
    required this.firestore,
  });

  @override
  Future<AuthResult> loginWithEmailAndPassword(
      String email, String password) async {
    late AuthResult userResult;
    final userLogin =
        await authService.signInWithEmailAndPassword(email, password);
    final user = await firestore.getDocument('users', userLogin.uid);

    userResult = AuthResultModel.fromDocument(user);
    return userResult;
  }

  @override
  Future<AuthResult> loginWithGoogle() async {
    late AuthResult userResult = AuthResultModel.empty();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final userCredential = await authService.signInWithCredential(credential);
      final existUser =
          await firestore.existDocument('users', userCredential.uid);

      if (!existUser) {
        await firestore.createDocument('users', userCredential.uid,
            UserCreateModel.fromUser(userCredential).toMap());
      }

      final user = await firestore.getDocument('users', userCredential.uid);

      userResult = AuthResultModel.fromDocument(user);
      return userResult;
    }
    return userResult;
  }

  @override
  Future<AuthResult> createAccountWithEmailAndPassword(
      UserCreateModel userCreate) async {
    late AuthResult userResult;
    final user =
        await authService.createUser(userCreate.email, userCreate.password);
    final phoneCrypt = EncryptData().encrypty(userCreate.phone).base16;
    userResult = AuthResultModel(
        user.email!, user.uid, false, phoneCrypt, userCreate.name);
    final existInContact =
        await firestore.existDocument('contacts', phoneCrypt);

    if (!(existInContact)) {
      await firestore.createDocument(
          'contacts', phoneCrypt, {'tokenId': userResult.tokenId});
    }
    await firestore.createDocument(
        'users', userResult.tokenId!, userCreate.toMap());

    return userResult;
  }

  @override
  Future<bool> recoveryWithEmail(String email) async {
    try {
      await authService.recoveryPassword(
        email,
      );
      return true;
    } on FirebaseAuthException {
      return false;
    } catch (e) {
      return false;
    }
  }
}
