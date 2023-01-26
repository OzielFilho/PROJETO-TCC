import 'dart:convert';

import '../../entities/auth_result.dart';

class AuthResultModel extends AuthResult {
  AuthResultModel(
      {required String email,
      required bool welcomePage,
      required String phone,
      required String name,
      required List<String> contacts,
      required String photo,
      required String tokenId})
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

  factory AuthResultModel.fromMap(Map<String, dynamic> data) {
    final contactsConvert =
        data['contacts'].map<String>((contact) => contact.toString()).toList();
    return AuthResultModel(
      email: data['email'] ?? '',
      name: data['name'] ?? '',
      phone: data['phone'] ?? '',
      welcomePage: data['welcomePage'] ?? false,
      contacts: contactsConvert ?? [],
      photo: data['photo'] ?? '',
      tokenId: '',
    );
  }

  String toJson() => json.encode(toMap());
}
