import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/utils/constants/encrypt_data.dart';
import '../../domain/entities/user_create_google.dart';

class UserCreateGoogleModel extends UserCreateGoogle {
  final String email;
  final String password;
  final String name;
  final List<String> contacts;
  final String confirmePassword;
  final bool welcomePage;

  String? photo;
  final String phone;
  UserCreateGoogleModel(this.email, this.password, this.name, this.contacts,
      this.photo, this.phone, this.confirmePassword, this.welcomePage)
      : super(
            email: email,
            password: password,
            photo: photo,
            name: name,
            confirmePassword: confirmePassword,
            contacts: contacts,
            phone: phone);

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'contacts': contacts,
      'welcomePage': welcomePage,
      'photo': photo,
      'phone':
          phone.isEmpty ? '' : EncryptData().encrypty(phone).base16.toString(),
    };
  }

  factory UserCreateGoogleModel.fromUser(User user) => UserCreateGoogleModel(
      user.email!, '', user.displayName!, [], user.photoURL, '', '', false);

  String toJson() => json.encode(toMap());
}
