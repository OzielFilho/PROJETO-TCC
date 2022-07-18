import 'package:equatable/equatable.dart';

class AuthCredential extends Equatable {
  final String idToken;
  final String accessToken;

  AuthCredential({required this.idToken, required this.accessToken});

  @override
  List<Object?> get props => [idToken, accessToken];
}
