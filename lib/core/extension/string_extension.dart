extension StringExtension on String {
  bool isNotEmptyOrNull() {
    return isNotEmpty && this != 'null';
  }

  bool isNotEmptyOrZero() {
    return isNotEmpty && this != '0';
  }

  bool isNotEmptyOrZeroOrNull() {
    return isNotEmpty && this != '0' && this != 'null';
  }

  bool isEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }

  bool isPhoneNumber() {
    return RegExp(r'^[0-9]+$').hasMatch(this);
  }

  bool isNumeric() {
    return RegExp(r'^[0-9]+$').hasMatch(this);
  }

  bool isAlphabet() {
    return RegExp(r'^[a-zA-Z]+$').hasMatch(this);
  }

  bool isAlphanumeric() {
    return RegExp(r'^[a-zA-Z0-9]+$').hasMatch(this);
  }

  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
