import '../../../../core/utils/constants/encrypt_data.dart';
import '../../entities/user_create_account.dart';

class UserCreateAccountModel extends UserCreateAccount {
  UserCreateAccountModel(
      String name,
      String email,
      String password,
      String? photo,
      String confirmePassword,
      List<String>? contacts,
      String phone,
      bool? welcomePage)
      : super(name, email, password, photo, confirmePassword, contacts, phone,
            welcomePage);

  factory UserCreateAccountModel.fromUser(UserCreateAccount user) =>
      UserCreateAccountModel(user.name, user.email, user.password, user.photo,
          user.confirmePassword, user.contacts, user.phone, user.welcomePage);

  Map<String, dynamic> toMap() => {
        'email': email,
        'name': name,
        'contacts': contacts,
        'welcomePage': welcomePage,
        'photo': photo,
        'phone': phone.isEmpty
            ? ''
            : EncryptData().encrypty(phone).base16.toString(),
      };
}
