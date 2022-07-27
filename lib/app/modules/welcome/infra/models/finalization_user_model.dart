import 'package:app/app/modules/welcome/domain/entities/final_user.dart';

class FinalizationUserModel extends FinalizationUser {
  final List<String> contacts;
  FinalizationUserModel({required this.contacts}) : super(contacts: contacts);

  factory FinalizationUserModel.fromFinalizationUser(FinalizationUser user) =>
      FinalizationUserModel(contacts: user.contacts);
}
