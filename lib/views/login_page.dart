import 'package:elred_todo_app/config/app_constants.dart';
import 'package:elred_todo_app/config/size_configs.dart';
import 'package:elred_todo_app/controllers/todo_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../controllers/auth_controller.dart';
import '../widgets/custom_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Consumer<AuthController>(builder: (context, value, child) {
              return Stack(
                children: [
                  Container(
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
                              child: Lottie.asset(
                                  'assets/animations/login_logo.json',
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
                                  Provider.of<ToDoController>(context,
                                          listen: false)
                                      .setGoogleLogIn(false);
                                  Provider.of<AuthController>(context,
                                          listen: false)
                                      .logingUsingEmailPassword(
                                          emailController.text.trim(),
                                          passwordController.text.trim());
                                }
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
                            const Gap(20),
                            MaterialButton(
                              color: AppConstants.primaryColor,
                              minWidth: SizeConfig.screenWidth,
                              height: SizeConfig.screenHeight! * 0.07,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              onPressed: () {
                                Provider.of<ToDoController>(context,
                                        listen: false)
                                    .setGoogleLogIn(true);
                                Provider.of<AuthController>(context,
                                        listen: false)
                                    .handleGoogleLogIn();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/images/google_logo.png'),
                                  const Gap(20),
                                  Text(
                                    'Sign in with Google',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.roboto(
                                        color: Colors.white,
                                        fontSize:
                                            SizeConfig.screenWidth! * 0.045,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  value.isLoading
                      ? Container(
                          height: SizeConfig.screenHeight,
                          width: SizeConfig.screenWidth,
                          color: Colors.black12,
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: AppConstants.primaryColor,
                            ),
                          ),
                        )
                      : const SizedBox()
                ],
              );
            })));
  }
}
