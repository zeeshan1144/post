class FormValidator {
  static String? checkEmpty(String value, String message) {
    if (value.isEmpty) {
      return "Please Enter $message";
    } else {
      return null;
    }
  }

  static String? checkLength(String value, String message, int length) {
    if (value.isEmpty) {
      return "Please Enter $message";
    } else if (value.length < length) {
      return "$message length Must be greater than $length";
    } else {
      return null;
    }
  }

  static String? confirmPassword(
      String value, String value2, String message, int length) {
    if (value.isEmpty) {
      return "Please Enter $message";
    } else if (value.length < length) {
      return "$message length Must be greater than $length";
    } else if (value != value2) {
      return "Password Mismatch!";
    } else {
      return null;
    }
  }

  static String? checkEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern.toString());

    if (value.isEmpty) {
      return "Please Enter Email";
    } else if (!regex.hasMatch(value)) {
      return "Please Enter a valid Email";
    } else {
      return null;
    }
  }
}
