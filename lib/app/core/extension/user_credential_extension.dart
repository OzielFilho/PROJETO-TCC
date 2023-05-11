import 'package:firebase_auth/firebase_auth.dart';

extension UserCredentialExtension on UserCredential {
  Map<String, dynamic> get toMap => {
        'email': user!.email,
        'name': user!.displayName,
        'photo': user!.photoURL,
        'token': user!.uid,
      };
}
