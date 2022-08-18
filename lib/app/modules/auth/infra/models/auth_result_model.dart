import 'dart:convert';

import '../../domain/entities/auth_result.dart';

class AuthResultModel extends AuthResult {
  AuthResultModel(
      {required String email,
      required bool welcomePage,
      required String phone,
      required String name,
      List<String>? contacts,
      String? photo,
      String? tokenId})
      : super(
            email: email,
            welcomePage: welcomePage,
            phone: phone,
            name: name,
            contacts: contacts,
            photo: photo,
            tokenId: tokenId);
  factory AuthResultModel.empty() => AuthResultModel(
        email: '',
        name: '',
        phone: '',
        welcomePage: false,
        contacts: [],
        photo: '',
        tokenId: '',
      );
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'contacts': contacts,
      'welcomePage': welcomePage,
      'photo': photo,
      'phone': phone,
    };
  }

  factory AuthResultModel.fromMap(Map<String, dynamic> data) => AuthResultModel(
        email: data['email'],
        name: data['name'],
        phone: data['phone'],
        welcomePage: data['welcomePage'],
        contacts: data['contacts'],
        photo: data['photo'],
        tokenId: '',
      );

  String toJson() => json.encode(toMap());
}
