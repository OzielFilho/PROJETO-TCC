import 'package:app/app/modules/splash/domain/entities/user_logged_info.dart';

class UserLoggedInfoModel extends UserLoggedInfo {
  final bool logged;
  final bool welcomePage;
  UserLoggedInfoModel({required this.logged, required this.welcomePage})
      : super(logged: logged, welcomePage: welcomePage);
}
