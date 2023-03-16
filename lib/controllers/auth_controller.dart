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

  addLoader() {
    isLoading = true;
    notifyListeners();
  }

  removeLoader() {
    isLoading = false;
    notifyListeners();
  }

  logingUsingEmailPassword(String email, String password) async {
    addLoader();
    try {
      final UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      await storage.write('userId', userCredential.user!.uid);
      removeLoader();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        try {
          final UserCredential userCredential = await _firebaseAuth
              .createUserWithEmailAndPassword(email: email, password: password);
          await storage.write('userId', userCredential.user!.uid);
          removeLoader();
        } catch (e) {
          removeLoader();
          Get.snackbar("Error", e.toString(),
              snackPosition: SnackPosition.BOTTOM,
              colorText: AppConstants.primaryColor);
        }
      } else {
        removeLoader();
        Get.snackbar("Error", e.toString(),
            snackPosition: SnackPosition.BOTTOM,
            colorText: AppConstants.primaryColor);
      }
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
