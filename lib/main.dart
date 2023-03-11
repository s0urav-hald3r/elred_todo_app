import 'package:elred_todo_app/controllers/todo_controller.dart';
import 'package:elred_todo_app/views/splash_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ToDoController>(
      create: (context) => ToDoController(),
      child: const GetMaterialApp(
        title: 'elRed ToDo',
        debugShowCheckedModeBanner: false,
        home: SplashPage(),
      ),
    );
  }
}
