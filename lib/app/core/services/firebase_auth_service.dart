import 'dart:io';
import 'firestorage_service.dart';
import 'firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../modules/auth/domain/entities/auth_result.dart';
import '../../modules/authentication/authentication_google/models/auth_result_model.dart';
import '../../modules/auth/infra/models/user_create_account_model.dart';
import '../error/exceptions.dart';
import '../utils/constants/encrypt_data.dart';

abstract class FirebaseAuthService {
  Future<String> signInWithEmailAndPassword(String email, String password);
  Future<User> signInWithCredential(dynamic credential);
  Future<void> recoveryPassword(String email);
  Future<void> signOut();
  Future<String> getToken();
  Future<User> createUser(String email, String password);
  Future<String> createAccount(UserCreateAccountModel userModel, File? image);

  Future<bool> userLogged();
}

class FirebaseAuthServiceImpl implements FirebaseAuthService {
  final FirebaseAuth auth;
  final FirestorageService _firestorageService;
  final FirestoreService _firestoreService;
  FirebaseAuthServiceImpl(
      this.auth, this._firestorageService, this._firestoreService);

  @override
  Future<User> createUser(String email, String password) async {
    final result = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return result.user!;
  }

  @override
  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final userLogin = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      final user =
          await _firestoreService.getDocument('users', userLogin.user!.uid);

      AuthResult userResult = AuthResultModel.fromMap(user);
      final emailVerified = userLogin.user!.emailVerified;
      final isGoogleTest = userLogin.user!.email == 'google_test@gmail.com';
      if (!userResult.welcomePage && emailVerified) {
        return 'Welcome Page True';
      }

      if (!emailVerified && !isGoogleTest) {
        await auth.signOut();
        return 'Email não verificado! Verifique o email utilizar o app';
      }
      return '';
    } on Exception catch (e) {
      throw e;
    }
  }

  @override
  Future<void> signOut() async => await auth.signOut();

  @override
  Future<bool> userLogged() async => auth.currentUser != null;

  @override
  Future<void> recoveryPassword(String email) async =>
      await auth.sendPasswordResetEmail(email: email);

  @override
  Future<User> signInWithCredential(dynamic credential) async {
    try {
      final result = await auth.signInWithCredential(credential);
      return result.user!;
    } on Exception catch (e) {
      throw e;
    }
  }

  @override
  Future<String> getToken() async {
    String result = '';
    final currentUser = auth.currentUser != null;
    if (currentUser) {
      result = auth.currentUser!.uid;
    }
    return result;
  }

  @override
  Future<String> createAccount(
      UserCreateAccountModel userModel, File? image) async {
    try {
      final phoneCrypt = EncryptData().encrypty(userModel.phone).base16;
      final existInContact =
          await _firestoreService.existDocument('contacts', phoneCrypt);
      if (existInContact) {
        throw PhoneExistException();
      }
      if (!(existInContact)) {
        final user = await auth.createUserWithEmailAndPassword(
            email: userModel.email, password: userModel.password);
        await auth.currentUser!.sendEmailVerification();
        if (image != null) {
          await _firestorageService.saveArchive(
              path: 'image_user/${user.user!.uid}.jpg', data: image);
          userModel.photo = await _firestorageService.getArchive(
              path: 'image_user/${user.user!.uid}.jpg');
        }

        await _firestoreService.createDocument(
            'contacts', phoneCrypt, {'tokenId': user.user!.uid});
        await _firestoreService
            .createDocument('chat', user.user!.uid, {'contacts': []});
      }
      await _firestoreService.createDocument(
          'users', auth.currentUser!.uid, userModel.toMap());
      await auth.signOut();
      return '';
    } catch (e) {
      return 'Usuário não pode ser criado';
    }
  }
}
