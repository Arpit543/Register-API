bool isValidPhone(String phone) {
  final phoneRegExp = RegExp(r'^[0-9]{10}$');
  return phoneRegExp.hasMatch(phone);
}

bool isValidUsername(String userName) {
  RegExp userRegExp =
  RegExp(r'^(?=[a-zA-Z0-9._]{8,20}$)(?!.*[_.]{2})[^_.].*[^_.]$');
  return userRegExp.hasMatch(userName);
}

bool isValidName(String name) {
  RegExp nameRegExp = RegExp(r"^\s*([A-Za-z])+[A-Za-z]+\.?\s*$");
  return nameRegExp.hasMatch(name);
}

bool isValidEmail(String email) {
  String pattern =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  RegExp regex = RegExp(pattern);
  return regex.hasMatch(email);
}
