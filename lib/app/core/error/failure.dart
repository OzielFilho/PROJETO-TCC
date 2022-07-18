import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure([List props = const <dynamic>[]]);
}

class LoginFailure extends Failure {
  @override
  List<Object?> get props => const <dynamic>[];
}

class CreateUserFailure extends Failure {
  @override
  List<Object?> get props => const <dynamic>[];
}

class ParamsLoginUserFailure extends Failure {
  @override
  List<Object?> get props => const <dynamic>[];
}

class ParamsCreateUserFailure extends Failure {
  @override
  List<Object?> get props => const <dynamic>[];
}
