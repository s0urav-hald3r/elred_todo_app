import 'package:elred_todo_app/config/app_constants.dart';
import 'package:elred_todo_app/views/home_page.dart';
import 'package:elred_todo_app/views/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DivertionPage extends StatelessWidget {
  const DivertionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                      color: AppConstants.primaryColor));
            }
            if (snapshot.connectionState == ConnectionState.done ||
                snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const HomePage();
              }
              return const LoginPage();
            }
            return const LoginPage();
          })),
    );
  }
}
