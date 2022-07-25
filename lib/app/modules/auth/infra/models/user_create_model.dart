import 'dart:convert';
import 'dart:developer';

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
    log(EncryptData().encrypty(phone).base16.toString());
    return {
      'email': email,
      'name': name,
      'contacts': contacts,
      'phone': EncryptData().encrypty(phone).base16.toString(),
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

  String toJson() => json.encode(toMap());
}
