class Validations {
  static bool emailAndPasswordValidation(
      {required String email, required String password}) {
    if (password.length >= 6 ||
        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(email)) {
      return true;
    }
    return false;
  }
}
