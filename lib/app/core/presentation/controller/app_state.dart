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

class SuccessGetUserState extends AppState {}

class SuccessGetListDetailsContactFromPhoneChatState extends AppState {}

class SuccessGetCurrentLocationState extends AppState {}

class SuccessUpdateUserCreateState extends AppState {}

class SuccessLogoutUserState extends AppState {}

class SuccessHomeState extends AppState {}

class SuccessCreateAccountState extends AppState {}

class SuccessWelcomeState extends AppState {}

class ProcessingState extends AppState {}

class EmptyParamsErrorState extends ErrorState {
  EmptyParamsErrorState(String? message) : super(message);
}

class ListContactsErrorState extends ErrorState {
  ListContactsErrorState(String? message) : super(message);
}

class GetListContactsErrorState extends ErrorState {
  GetListContactsErrorState(String? message) : super(message);
}

class PhoneEmptyErrorState extends ErrorState {
  PhoneEmptyErrorState(String? message) : super(message);
}

class PhoneInvalidErrorState extends ErrorState {
  PhoneInvalidErrorState(String? message) : super(message);
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
