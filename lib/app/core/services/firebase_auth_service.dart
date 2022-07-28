import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseAuthService {
  Future<User> signInWithEmailAndPassword(String email, String password);
  Future<User> signInWithCredential(dynamic credential);
  Future<void> recoveryPassword(String email);
  Future<void> signOut();
  Future<String> getToken();
  Future<User> createUser(String email, String password);
  Future<bool> userLogged();
}

class FirebaseAuthServiceImpl implements FirebaseAuthService {
  final FirebaseAuth auth;

  FirebaseAuthServiceImpl(this.auth);

  @override
  Future<User> createUser(String email, String password) async {
    final result = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return result.user!;
  }

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    final result =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    return result.user!;
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
    final result = await auth.signInWithCredential(credential);
    return result.user!;
  }

  @override
  Future<String> getToken() async {
    final result = auth.currentUser!.uid;
    return result;
  }
}
