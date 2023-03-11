import 'package:elred_todo_app/config/app_constants.dart';
import 'package:elred_todo_app/config/size_configs.dart';
import 'package:elred_todo_app/controllers/auth_controller.dart';
import 'package:elred_todo_app/views/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../widgets/custom_textfield.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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

  Future<void> signupUsingEmailPassword(String email, String password) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: ((context) => const Center(
              child:
                  CircularProgressIndicator(color: AppConstants.primaryColor),
            )));
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (route) => false);
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          colorText: AppConstants.primaryColor);
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
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
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
                      Consumer<AuthController>(
                          builder: (context, value, child) {
                        return CustomTextField(
                          controller: passwordController,
                          label: 'Password',
                          validator: 'password',
                          obsecuretext: value.showPassword ? false : true,
                          suffixIcon: value.showPassword
                              ? const Icon(Icons.visibility_off)
                              : const Icon(Icons.visibility),
                        );
                      }),
                      const Gap(30),
                      MaterialButton(
                        color: AppConstants.primaryColor,
                        minWidth: SizeConfig.screenWidth,
                        height: SizeConfig.screenHeight! * 0.07,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            signupUsingEmailPassword(
                                emailController.text.trim(),
                                passwordController.text.trim());
                          }
                        },
                        child: Text(
                          "Signup",
                          style: GoogleFonts.quicksand(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: SizeConfig.screenWidth! * 0.045,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: SizeConfig.screenHeight! * 0.125),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account?",
                              style: GoogleFonts.quicksand(
                                  color: Colors.black54,
                                  fontSize: SizeConfig.screenWidth! * 0.035,
                                  fontWeight: FontWeight.w600),
                            ),
                            const Gap(5),
                            InkWell(
                              onTap: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginPage()),
                                    (route) => false);
                              },
                              child: Text(
                                "Login",
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
