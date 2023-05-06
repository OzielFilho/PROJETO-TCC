class UserLoggedResponse {
  final String name;
  final bool welcomePage;
  final String photo;
  final String email;
  final String phone;
  final String token;
  final bool logged;
  static late UserLoggedResponse _instance;

  UserLoggedResponse(
      {required this.photo,
      required this.email,
      required this.phone,
      required this.name,
      required this.token,
      required this.logged,
      required this.welcomePage});

  factory UserLoggedResponse.fromJson(Map<String, dynamic> json) {
    _instance = UserLoggedResponse(
        name: json['name'],
        welcomePage: json['welcomePage'],
        email: json['email'],
        phone: json['phone'],
        photo: json['photo'],
        token: json['token'],
        logged: json['logged']);
    return _instance;
  }

  void clearLoginResponse() {
    _instance = UserLoggedResponse(
        name: '',
        welcomePage: false,
        email: '',
        phone: '',
        photo: '',
        logged: false,
        token: '');
  }

  static UserLoggedResponse get instance => _instance;
}
