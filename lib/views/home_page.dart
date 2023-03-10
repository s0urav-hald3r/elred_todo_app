import 'package:elred_todo_app/config/app_constants.dart';
import 'package:elred_todo_app/config/size_configs.dart';
import 'package:elred_todo_app/views/add_task.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/homepage_header.dart';
import '../widgets/task_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
            backgroundColor: Colors.white,
            floatingActionButton: FloatingActionButton.extended(
                backgroundColor: AppConstants.primaryColor,
                onPressed: () => Get.to(const AddTask()),
                label: Row(
                  children: [
                    const Icon(Icons.add),
                    const Gap(5),
                    Text(
                      'Create Task',
                      style: GoogleFonts.quicksand(
                          color: Colors.white,
                          fontSize: SizeConfig.screenWidth! * 0.04,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                )),
            body: SizedBox(
              height: SizeConfig.screenHeight,
              width: SizeConfig.screenWidth,
              child: Column(
                children: [
                  const HomePageHeader(),
                  Expanded(
                    child: Container(
                      width: SizeConfig.screenWidth,
                      color: Colors.transparent,
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Gap(20),
                          Text(
                            'TASK LIST',
                            style: GoogleFonts.quicksand(
                                color: Colors.black45,
                                fontSize: SizeConfig.screenWidth! * 0.04,
                                fontWeight: FontWeight.bold),
                          ),
                          const Gap(20),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                  children: List.generate(7, ((index) {
                                if (index == 6) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        bottom:
                                            SizeConfig.screenHeight! * 0.075),
                                    child: const TaskCard(),
                                  );
                                }
                                return Column(
                                  children: const [
                                    TaskCard(),
                                    Divider(
                                      endIndent: 5,
                                      indent: 5,
                                      height: 1,
                                      color: Colors.black54,
                                    ),
                                    Gap(20)
                                  ],
                                );
                              }))),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
