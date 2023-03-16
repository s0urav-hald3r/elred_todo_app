import 'package:elred_todo_app/config/app_constants.dart';
import 'package:elred_todo_app/controllers/todo_controller.dart';
import 'package:elred_todo_app/widgets/drawer_logo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../config/size_configs.dart';

class HomePageHeader extends StatelessWidget {
  HomePageHeader({
    Key? key,
  }) : super(key: key);

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight! * 0.35,
      padding: EdgeInsets.only(
          left: 20, top: SizeConfig.safeAreaTop! + 20, bottom: 20, right: 20),
      decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/homepage_logo.jpeg'))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const DrawerLogo(),
              Consumer<ToDoController>(builder: (context, value, child) {
                return InkWell(
                  onTap: () async {
                    try {
                      if (value.isGoogleLogIn) {
                        await _googleSignIn.signOut();
                      } else {
                        await _firebaseAuth.signOut();
                      }
                      await storage.erase();
                      Provider.of<ToDoController>(context, listen: false)
                          .logout();
                    } on FirebaseAuthException catch (e) {
                      Get.snackbar("Error", e.toString(),
                          snackPosition: SnackPosition.BOTTOM,
                          colorText: AppConstants.primaryColor);
                    }
                  },
                  child: Icon(
                    Icons.logout,
                    size: SizeConfig.screenWidth! * 0.06,
                    color: Colors.white70,
                  ),
                );
              }),
            ],
          ),
          const Gap(20),
          Text(
            'Your\nTasks',
            style: GoogleFonts.quicksand(
                color: Colors.white70,
                fontSize: SizeConfig.screenWidth! * 0.1,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
