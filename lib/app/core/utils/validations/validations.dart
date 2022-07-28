class Validations {
  static bool emailValidation({required String email}) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  static bool passwordValidation({required String password}) {
    return password.length >= 6;
  }

  static bool phoneValidation({required String phone}) {
    return phone.length == 14 && phone[4] == '9';
  }
}
