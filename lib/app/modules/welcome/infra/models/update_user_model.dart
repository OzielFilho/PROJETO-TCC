import '../../../../core/utils/constants/encrypt_data.dart';
import '../../domain/entities/update_user.dart';

class UpdateUserWelcomeModel extends UpdateUserWelcome {
  List<String> contacts;
  final bool welcomePage;
  final String phone;
  String email;
  String name;
  String photo;
  UpdateUserWelcomeModel(
      {required this.name,
      required this.contacts,
      required this.welcomePage,
      required this.phone,
      required this.photo,
      required this.email})
      : super(
            name: name,
            photo: photo,
            contacts: contacts,
            phone: phone,
            welcomePage: welcomePage,
            email: email);

  factory UpdateUserWelcomeModel.fromFinalizationUser(UpdateUserWelcome user) =>
      UpdateUserWelcomeModel(
          contacts: user.contacts,
          name: user.name,
          phone: user.phone,
          photo: user.photo,
          email: user.email,
          welcomePage: user.welcomePage);

  Map<String, dynamic> toMap() {
    final cryptPhone = EncryptData().encrypty(phone).base16;
    return {
      'contacts': contacts,
      'welcomePage': welcomePage,
      'phone': cryptPhone,
      'email': email,
      'name': name,
      'photo': photo,
    };
  }
}
