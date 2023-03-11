import 'package:elred_todo_app/config/app_constants.dart';
import 'package:elred_todo_app/config/size_configs.dart';
import 'package:elred_todo_app/views/home_page.dart';
import 'package:elred_todo_app/views/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../widgets/custom_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> logingUsingEmailPassword(String email, String password) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: ((context) => const Center(
              child:
                  CircularProgressIndicator(color: AppConstants.primaryColor),
            )));
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      Navigator.popUntil(context, (route) => route.isFirst);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        bottom: false,
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: Colors.transparent,
            systemNavigationBarIconBrightness: Brightness.dark,
          ),
          child: Scaffold(
            body: Container(
              height: SizeConfig.screenHeight,
              width: SizeConfig.screenWidth,
              padding: const EdgeInsets.only(left: 20, right: 20),
              color: Colors.white,
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 50),
                        child: Lottie.asset('assets/animations/login_logo.json',
                            width: SizeConfig.screenWidth! * 0.5),
                      ),
                      Text(
                        'Welcome to elRed.',
                        style: GoogleFonts.quicksand(
                            color: Colors.black87,
                            fontSize: SizeConfig.screenWidth! * 0.07,
                            fontWeight: FontWeight.bold),
                      ),
                      const Gap(10),
                      Text(
                        'Your personalize To Do App',
                        style: GoogleFonts.quicksand(
                            color: Colors.black45,
                            fontSize: SizeConfig.screenWidth! * 0.04,
                            fontWeight: FontWeight.w700),
                      ),
                      const Gap(30),
                      CustomTextField(
                        controller: emailController,
                        label: 'Email',
                        validator: 'email',
                      ),
                      const Gap(20),
                      CustomTextField(
                        controller: passwordController,
                        label: 'Password',
                        validator: 'password',
                        obsecuretext: true,
                        suffixIcon: const Icon(Icons.remove_red_eye),
                      ),
                      const Gap(30),
                      MaterialButton(
                        color: AppConstants.primaryColor,
                        minWidth: SizeConfig.screenWidth,
                        height: SizeConfig.screenHeight! * 0.07,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onPressed: () {
                          logingUsingEmailPassword(emailController.text.trim(),
                              passwordController.text.trim());
                        },
                        child: Text(
                          "Login",
                          style: GoogleFonts.quicksand(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: SizeConfig.screenWidth! * 0.045,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: SizeConfig.screenHeight! * 0.175),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: GoogleFonts.quicksand(
                                  color: Colors.black54,
                                  fontSize: SizeConfig.screenWidth! * 0.035,
                                  fontWeight: FontWeight.w600),
                            ),
                            const Gap(5),
                            InkWell(
                              onTap: () => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RegisterPage())),
                              child: Text(
                                "Signup",
                                style: GoogleFonts.quicksand(
                                    color: AppConstants.primaryColor,
                                    fontSize: SizeConfig.screenWidth! * 0.035,
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
