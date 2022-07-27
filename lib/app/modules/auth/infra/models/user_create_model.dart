import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/user_create.dart';

import '../../../../core/utils/constants/encrypt_data.dart';

class UserCreateModel extends UserCreate {
  final String email;
  final String password;
  final String name;
  final List<String> contacts;
  final String confirmePassword;
  final bool welcomePage;
  final String phone;
  UserCreateModel(this.email, this.password, this.name, this.contacts,
      this.phone, this.confirmePassword, this.welcomePage)
      : super(
            email: email,
            password: password,
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
      'phone':
          phone.isEmpty ? '' : EncryptData().encrypty(phone).base16.toString(),
    };
  }

  factory UserCreateModel.fromUserCreate(UserCreate userCreate) =>
      UserCreateModel(
          userCreate.email,
          userCreate.password,
          userCreate.name,
          userCreate.contacts!,
          userCreate.phone,
          userCreate.confirmePassword,
          userCreate.welcomePage!);
  factory UserCreateModel.fromUser(User user) =>
      UserCreateModel(user.email!, '', user.displayName!, [], '', '', false);

  String toJson() => json.encode(toMap());
}
