class AppState {
  final String? message;

  AppState([this.message]);
}

class InitialState extends AppState {}

class ErrorState extends AppState {
  ErrorState(String? message) : super(message);
}

class NetworkErrorState extends AppState {
  NetworkErrorState(String? message) : super(message);
}

class SuccessState extends AppState {}

class SuccessHomeState extends AppState {}

class SuccessCreateAccountState extends AppState {}

class SuccessWelcomeState extends AppState {}

class ProcessingState extends AppState {}

class EmptyParamsErrorState extends ErrorState {
  EmptyParamsErrorState(String? message) : super(message);
}

class PhoneErrorState extends ErrorState {
  PhoneErrorState(String? message) : super(message);
}

class EmailInvalidErrorState extends ErrorState {
  EmailInvalidErrorState(String? message) : super(message);
}

class PasswordInvalidErrorState extends ErrorState {
  PasswordInvalidErrorState(String? message) : super(message);
}

class EmailOrPasswordEmptyErrorState extends ErrorState {
  EmailOrPasswordEmptyErrorState(String? message) : super(message);
}

class EmailOrPasswordInvalidErrorState extends ErrorState {
  EmailOrPasswordInvalidErrorState(String? message) : super(message);
}

class PasswordDifferenceInvalidErrorState extends ErrorState {
  PasswordDifferenceInvalidErrorState(String? message) : super(message);
}

class UserNotFoundErrorState extends ErrorState {
  UserNotFoundErrorState(String? message) : super(message);
}

class UserNotLoggedState extends AppState {}
