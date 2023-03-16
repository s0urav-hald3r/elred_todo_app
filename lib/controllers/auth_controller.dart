import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../config/app_constants.dart';

class AuthController with ChangeNotifier {
  bool showPassword = false;
  bool isLoading = false;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final storage = GetStorage();

  toggleEye() {
    showPassword = !showPassword;
    notifyListeners();
  }

  logingUsingEmailPassword(
      BuildContext context, String email, String password) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: ((context) => const Center(
              child:
                  CircularProgressIndicator(color: AppConstants.primaryColor),
            )));

    try {
      final UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      await storage.write('userId', userCredential.user!.uid);
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          colorText: AppConstants.primaryColor);
      Navigator.pop(context);
    }
  }

  handleGoogleLogIn() async {
    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await _firebaseAuth.signInWithCredential(credential);
        await storage.write('userId', userCredential.user!.uid);
      } on FirebaseAuthException catch (e) {
        Get.snackbar("Error", e.toString(),
            snackPosition: SnackPosition.BOTTOM,
            colorText: AppConstants.primaryColor);
      }
    }
  }
}
