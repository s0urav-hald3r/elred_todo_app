import 'package:elred_todo_app/widgets/drawer_logo.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/size_configs.dart';

class HomePageHeader extends StatelessWidget {
  const HomePageHeader({
    Key? key,
  }) : super(key: key);

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
              Icon(
                Icons.logout,
                size: SizeConfig.screenWidth! * 0.06,
                color: Colors.white70,
              )
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
