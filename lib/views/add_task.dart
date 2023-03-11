import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:elred_todo_app/config/app_constants.dart';
import 'package:elred_todo_app/controllers/todo_controller.dart';
import 'package:elred_todo_app/models/todo_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../config/size_configs.dart';
import '../widgets/custom_textfield.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key, this.toDoModel, required this.taskType})
      : super(key: key);
  final ToDoModel? toDoModel;
  final String taskType;

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController taskController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime _currentDate = DateTime.now();
  String date = '';
  bool isChooseDate = false;
  var uuid = const Uuid();

  @override
  void initState() {
    super.initState();
    _currentDate = DateTime.now();
    if (widget.taskType == 'UPDATE') {
      isChooseDate = true;
      taskController = TextEditingController(text: widget.toDoModel!.title);
      descriptionController =
          TextEditingController(text: widget.toDoModel!.description);
      date = widget.toDoModel!.date!;
    } else {
      taskController = TextEditingController();
      descriptionController = TextEditingController();
    }
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
                                onSubmit: (dateTime) {
                                  setState(() {
                                    _currentDate = dateTime;
                                    isChooseDate = true;
                                    date = DateFormat('dd MMMM, yyyy')
                                        .format(dateTime);
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
                                    isChooseDate ? date : 'Choose your date',
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
                          Consumer<ToDoController>(
                              builder: (context, value, child) {
                            return MaterialButton(
                              color: Colors.white,
                              minWidth: SizeConfig.screenWidth,
                              height: SizeConfig.screenHeight! * 0.07,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              onPressed: () {
                                if (widget.taskType == 'UPDATE') {
                                  context.read<ToDoController>().updateToDo(
                                      ToDoModel(
                                          tid: widget.toDoModel!.tid,
                                          title: taskController.text.trim(),
                                          description:
                                              descriptionController.text.trim(),
                                          date: date));
                                } else {
                                  context.read<ToDoController>().addToDo(
                                      ToDoModel(
                                          tid: uuid.v4(),
                                          title: taskController.text.trim(),
                                          description:
                                              descriptionController.text.trim(),
                                          date: date));
                                }
                                Get.back();
                              },
                              child: Text(
                                widget.taskType == 'UPDATE'
                                    ? 'UPDATE TASK'
                                    : "Add Task",
                                style: GoogleFonts.quicksand(
                                  color: AppConstants.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: SizeConfig.screenWidth! * 0.045,
                                ),
                              ),
                            );
                          })
                        ],
                      ),
                    ),
                  ),
                ))));
  }
}
