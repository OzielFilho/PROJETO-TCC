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

class RecoveryPasswordFailure extends Failure {
  @override
  List<Object?> get props => const <dynamic>[];
}

class ParamsEmptyUserFailure extends Failure {
  @override
  List<Object?> get props => const <dynamic>[];
}

class ParamsEmptyFailure extends Failure {
  @override
  List<Object?> get props => const <dynamic>[];
}

class PasswordAndConfirmePasswordDifferenceFailure extends Failure {
  @override
  List<Object?> get props => const <dynamic>[];
}

class UserNotFoundFailure extends Failure {
  @override
  List<Object?> get props => const <dynamic>[];
}

class ParamsInvalidUserFailure extends Failure {
  @override
  List<Object?> get props => const <dynamic>[];
}

class PhoneInvalidFailure extends Failure {
  @override
  List<Object?> get props => const <dynamic>[];
}

class PhoneExistFailure extends Failure {
  @override
  List<Object?> get props => const <dynamic>[];
}

class PhoneEmptyFailure extends Failure {
  @override
  List<Object?> get props => const <dynamic>[];
}

class ListPhoneEmptyFailure extends Failure {
  @override
  List<Object?> get props => const <dynamic>[];
}

class ParamsCreateUserFailure extends Failure {
  @override
  List<Object?> get props => const <dynamic>[];
}

class ParamsRecoveryPasswordFailure extends Failure {
  @override
  List<Object?> get props => const <dynamic>[];
}

class RefreshAccountFailure extends Failure {
  @override
  List<Object?> get props => const <dynamic>[];
}

class LoggedUserFailure extends Failure {
  @override
  List<Object?> get props => const <dynamic>[];
}

class ListContactsEmptyFailure extends Failure {
  @override
  List<Object?> get props => const <dynamic>[];
}

class UpdateUserFailure extends Failure {
  @override
  List<Object?> get props => const <dynamic>[];
}

class GetUserFailure extends Failure {
  @override
  List<Object?> get props => const <dynamic>[];
}

class GetCurrentLocationFailure extends Failure {
  @override
  List<Object?> get props => const <dynamic>[];
}

class GetDetailsContactFromPhoneFailure extends Failure {
  @override
  List<Object?> get props => const <dynamic>[];
}

class SendMessageUserFailure extends Failure {
  @override
  List<Object?> get props => const <dynamic>[];
}

class GetListDetailsContactFailure extends Failure {
  @override
  List<Object?> get props => const <dynamic>[];
}

class GetListContactsChatFailure extends Failure {
  @override
  List<Object?> get props => const <dynamic>[];
}

class LogoutUserFailure extends Failure {
  @override
  List<Object?> get props => const <dynamic>[];
}

class IdTokenFailure extends Failure {
  @override
  List<Object?> get props => const <dynamic>[];
}
