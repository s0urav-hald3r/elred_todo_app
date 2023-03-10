import 'package:elred_todo_app/views/splash_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'elRed ToDo App',
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
    );
  }
}
