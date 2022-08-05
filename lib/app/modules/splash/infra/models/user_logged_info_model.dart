import '../../domain/entities/user_logged_info.dart';

class UserLoggedInfoModel extends UserLoggedInfo {
  final bool logged;
  final bool welcomePage;
  final String phone;

  UserLoggedInfoModel(
      {required this.logged, required this.phone, required this.welcomePage})
      : super(logged: logged, welcomePage: welcomePage, phone: phone);

  factory UserLoggedInfoModel.toEmpty() =>
      UserLoggedInfoModel(logged: false, welcomePage: false, phone: '');
}
