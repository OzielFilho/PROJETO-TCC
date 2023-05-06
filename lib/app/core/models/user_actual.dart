import '../utils/constants/encrypt_data.dart';

class UserActual {
  final String name;
  final bool welcomePage;
  final String photo;
  final String email;
  final String phone;
  final String token;
  final bool logged;
  final List<String> contacts;
  static late UserActual _instance;

  UserActual(
      {required this.photo,
      required this.email,
      required this.phone,
      required this.name,
      required this.token,
      required this.contacts,
      required this.logged,
      required this.welcomePage});

  factory UserActual.fromJson(Map<String, dynamic> json) {
    final contactsConvert = json['contacts']
            ?.map<String>((contact) => contact.toString())
            ?.toList() ??
        [];
    _instance = UserActual(
        name: json['name'],
        welcomePage: json['welcomePage'] ?? false,
        email: json['email'],
        phone: json['phone'] ?? null,
        photo: json['photo'] ?? null,
        contacts: contactsConvert,
        token: json['token'] ?? '',
        logged: json['logged'] ?? null);
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
      'contacts': _instance.contacts,
    };
  }

  void clearLoginResponse() {
    _instance = UserActual(
        name: '',
        welcomePage: false,
        email: '',
        phone: '',
        photo: '',
        contacts: [],
        logged: false,
        token: '');
  }

  static UserActual get instance => _instance;
}
