import 'dart:convert';
import 'dart:io';

import '../../../../core/utils/constants/encrypt_data.dart';
import '../../domain/entities/user_create.dart';

class UserCreateModel extends UserCreate {
  final String email;
  final String password;
  final String name;
  final List<String> contacts;
  final String confirmePassword;
  final bool welcomePage;
  final String phone;
  final File? photo;
  UserCreateModel(this.email, this.password, this.name, this.contacts,
      this.phone, this.confirmePassword, this.welcomePage, this.photo)
      : super(
            email: email,
            password: password,
            name: name,
            photo: photo,
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

  factory UserCreateModel.fromUserCreate(UserCreate userCreate) =>
      UserCreateModel(
          userCreate.email,
          userCreate.password,
          userCreate.name,
          userCreate.contacts!,
          userCreate.phone,
          userCreate.confirmePassword,
          userCreate.welcomePage!,
          userCreate.photo);

  String toJson() => json.encode(toMap());
}
