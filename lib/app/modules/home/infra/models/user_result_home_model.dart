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

  factory UserResultHomeModel.fromUserResultHome(UserResultHome user) {
    return UserResultHomeModel(user.email, user.phone, user.name, user.contacts,
        user.tokenId, user.photo);
  }

  Map<String, dynamic> toMap() => {
        'email': email,
        'phone': phone,
        'name': name,
        'contacts': contacts,
        'tokenId': tokenId,
        'photo': photo,
      };
}
