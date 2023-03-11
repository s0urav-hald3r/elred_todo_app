import 'package:flutter/foundation.dart';

class AuthController with ChangeNotifier {
  bool showPassword = false;

  toggleEye() {
    showPassword = !showPassword;
    notifyListeners();
  }
}
