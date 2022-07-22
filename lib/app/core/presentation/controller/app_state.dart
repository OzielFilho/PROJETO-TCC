class AppState {
  final String? message;

  AppState([this.message]);
}

class InitialState extends AppState {}

class ErrorState extends AppState {
  ErrorState(String? message) : super(message);
}

class SuccessState extends AppState {}

class ProcessingState extends AppState {}

class EmailOrPasswordEmptyErrorState extends ErrorState {
  EmailOrPasswordEmptyErrorState(String? message) : super(message);
}

class EmailOrPasswordInvalidErrorState extends ErrorState {
  EmailOrPasswordInvalidErrorState(String? message) : super(message);
}

class UserNotFoundErrorState extends ErrorState {
  UserNotFoundErrorState(String? message) : super(message);
}
