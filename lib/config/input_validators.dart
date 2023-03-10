class Validators {
  static choose(String validatorText, String? text) {
    switch (validatorText) {
      case 'email':
        if (text == null || text.isEmpty) {
          return "Email address is required";
        }
        // This is just a regular expression for email addresses
        // ignore: unnecessary_string_escapes
        String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
            "\\@" +
            "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
            "(" +
            "\\." +
            "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
            ")+";
        RegExp regExp = RegExp(p);
        if (regExp.hasMatch(text)) {
          // So, the email is valid
          return null;
        }
        // The pattern of the email didn't match the regex above.
        return 'Email is not valid';

      case 'password':
        if (text == null || text.isEmpty) {
          return '*Required field';
        }
        return null;
      
      case 'name':
        if (text == null || text.isEmpty) {
          return '*Required field';
        }
        return null;

      default:
    }
  }
}
