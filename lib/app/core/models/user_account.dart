import '../utils/constants/encrypt_data.dart';

class UserAccount {
  final String name;
  final bool welcomePage;
  final String photo;
  final String email;
  String phone;
  final String? token;
  bool logged;
  List<String> contacts;
  static late UserAccount _instance;

  UserAccount(
      {required this.photo,
      required this.email,
      required this.phone,
      required this.name,
      required this.token,
      required this.contacts,
      required this.logged,
      required this.welcomePage});

  factory UserAccount.fromJson(Map<String, dynamic> json) {
    final contactsConvert = json['contacts']
            ?.map<String>((contact) => contact.toString())
            ?.toList() ??
        [];
    _instance = UserAccount(
        name: json['name'],
        welcomePage: json['welcomePage'] ?? false,
        email: json['email'],
        phone: json['phone'] ?? null,
        photo: json['photo'] ?? null,
        contacts: contactsConvert,
        token: json['token'] ?? null,
        logged: json['logged'] ?? false);
    return _instance;
  }

  Map<String, dynamic> get toJson {
    final cryptPhone = EncryptData().encrypty(_instance.phone).base16;

    return {
      'name': _instance.name,
      'welcomePage': _instance.welcomePage,
      'email': _instance.email,
      'phone': cryptPhone,
      'photo': _instance.photo,
      'logged': _instance.logged,
      'token': _instance.token,
      'contacts': _instance.contacts,
    };
  }

  void clearLoginResponse() {
    _instance = UserAccount(
        name: '',
        welcomePage: false,
        email: '',
        phone: '',
        photo: '',
        contacts: [],
        logged: false,
        token: '');
  }

  static UserAccount get instance => _instance;
}
