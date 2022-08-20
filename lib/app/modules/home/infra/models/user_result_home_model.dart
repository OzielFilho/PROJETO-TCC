import '../../domain/entities/user_result_home.dart';

class UserResultHomeModel extends UserResultHome {
  UserResultHomeModel(String email, String phone, String name,
      List<String> contacts, String tokenId, String photo)
      : super(email, phone, name, contacts, tokenId, photo);
  UserResultHomeModel.empty(
      {String email = '', String? tokenId = '', bool welcomePage = false})
      : super('', '', '', [], '', '');

  factory UserResultHomeModel.fromDocument(Map<String, dynamic> data) {
    final formatterListContacts =
        (data['contacts'] as List).map<String>((e) => e).toList();
    return UserResultHomeModel(data['email'], data['phone'], data['name'],
        formatterListContacts, data['tokenId'], data['photo']);
  }
}
