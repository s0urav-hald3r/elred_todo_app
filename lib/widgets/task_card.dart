import 'package:elred_todo_app/controllers/todo_controller.dart';
import 'package:elred_todo_app/models/todo_model.dart';
import 'package:elred_todo_app/views/add_task.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../config/size_configs.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    Key? key,
    required this.toDoModel,
  }) : super(key: key);
  final ToDoModel toDoModel;

  @override
  Widget build(BuildContext context) {
    return Consumer<ToDoController>(builder: (context, value, child) {
      return Container(
        width: SizeConfig.screenWidth,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
                colors: [Colors.indigo.shade50, Colors.pink.shade50])),
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              width: SizeConfig.screenWidth! * 0.65,
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    toDoModel.title!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: GoogleFonts.quicksand(
                        color: Colors.black54,
                        fontSize: SizeConfig.screenWidth! * 0.04,
                        fontWeight: FontWeight.bold),
                  ),
                  const Gap(5),
                  Text(
                    toDoModel.date!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: GoogleFonts.quicksand(
                        color: Colors.black54,
                        fontSize: SizeConfig.screenWidth! * 0.035,
                        fontWeight: FontWeight.normal),
                  ),
                  const Gap(5),
                  Text(
                    toDoModel.description!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                    style: GoogleFonts.quicksand(
                        color: Colors.black54,
                        fontSize: SizeConfig.screenWidth! * 0.035,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.transparent,
              width: SizeConfig.screenWidth! * 0.19,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: (() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddTask(
                                    taskType: 'UPDATE',
                                    toDoModel: toDoModel,
                                  )));
                    }),
                    child: const Icon(
                      Icons.edit,
                      color: Colors.black,
                    ),
                  ),
                  InkWell(
                    onTap: (() {
                      context.read<ToDoController>().deleteToDo(toDoModel.tid!);
                    }),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.redAccent,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
