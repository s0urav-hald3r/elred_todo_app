import 'package:elred_todo_app/controllers/auth_controller.dart';
import 'package:elred_todo_app/controllers/todo_controller.dart';
import 'package:elred_todo_app/views/splash_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthController>(
            create: (context) => AuthController()),
        ChangeNotifierProxyProvider<AuthController, ToDoController>(
            create: (context) => ToDoController(),
            update: (context, authController, toDoController) =>
                toDoController!..user = authController.user),
      ],
      child: const GetMaterialApp(
        title: 'elRed ToDo',
        debugShowCheckedModeBanner: false,
        home: SplashPage(),
      ),
    );
  }
}
