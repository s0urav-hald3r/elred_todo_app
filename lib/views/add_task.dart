import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:elred_todo_app/config/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../config/size_configs.dart';
import '../widgets/custom_textfield.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController taskController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime _currentDate = DateTime.now();
  bool isChooseDate = false;

  @override
  void initState() {
    super.initState();
    _currentDate = DateTime.now();
    taskController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    taskController.dispose();
    descriptionController.dispose();
    super.dispose();
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
                backgroundColor: AppConstants.primaryColor,
                appBar: AppBar(
                  backgroundColor: AppConstants.primaryColor,
                  centerTitle: true,
                  elevation: 0,
                  title: Text(
                    'Add new task',
                    style: GoogleFonts.quicksand(
                        color: Colors.white70,
                        fontSize: SizeConfig.screenWidth! * 0.05,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                body: Container(
                  height: SizeConfig.screenHeight,
                  width: SizeConfig.screenWidth,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Lottie.asset('assets/animations/task.json'),
                          ),
                          const Gap(30),
                          CustomTextField(
                            controller: taskController,
                            label: 'Task Title',
                            validator: 'text',
                            fillColor: AppConstants.primaryColor,
                            lebelColor: Colors.white,
                            textColor: Colors.white,
                            cursorColor: Colors.white,
                          ),
                          const Gap(20),
                          CustomTextField(
                            controller: descriptionController,
                            label: 'Task Description',
                            validator: 'text',
                            fillColor: AppConstants.primaryColor,
                            lebelColor: Colors.white,
                            textColor: Colors.white,
                            cursorColor: Colors.white,
                          ),
                          const Gap(20),
                          InkWell(
                            onTap: (() {
                              _currentDate = DateTime.now();
                              BottomPicker.date(
                                title: "Choose your date",
                                titleStyle: GoogleFonts.quicksand(
                                    fontWeight: FontWeight.bold,
                                    fontSize: SizeConfig.screenWidth! * 0.04,
                                    color: AppConstants.primaryColor),
                                closeIconColor: AppConstants.primaryColor,
                                dateOrder: DatePickerDateOrder.dmy,
                                initialDateTime: _currentDate,
                                minDateTime: _currentDate,
                                bottomPickerTheme: BottomPickerTheme.plumPlate,
                                onSubmit: (date) {
                                  setState(() {
                                    _currentDate = date;
                                    isChooseDate = true;
                                  });
                                },
                              ).show(context);
                            }),
                            child: Container(
                              width: SizeConfig.screenWidth,
                              height: SizeConfig.screenHeight! * 0.07,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.white)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    isChooseDate
                                        ? DateFormat('dd MMMM, yyyy')
                                            .format(_currentDate)
                                        : 'Choose your date',
                                    style: GoogleFonts.quicksand(
                                        color: Colors.white,
                                        fontSize:
                                            SizeConfig.screenWidth! * 0.035,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Gap(30),
                          MaterialButton(
                            color: Colors.white,
                            minWidth: SizeConfig.screenWidth,
                            height: SizeConfig.screenHeight! * 0.07,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            onPressed: () {},
                            child: Text(
                              "Add Task",
                              style: GoogleFonts.quicksand(
                                color: AppConstants.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: SizeConfig.screenWidth! * 0.045,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ))));
  }
}
