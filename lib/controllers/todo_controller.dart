import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elred_todo_app/models/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/app_constants.dart';

class ToDoController with ChangeNotifier {
  bool isLoading = false;
  bool isGoogleLogIn = false;
  List<ToDoModel> todos = [];
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  String userId = '';

  setUser(String id) {
    userId = id;
  }

  setGoogleLogIn(bool _isGoogleLogIn) {
    isGoogleLogIn = _isGoogleLogIn;
    notifyListeners();
  }

  addLoader() {
    isLoading = true;
    notifyListeners();
  }

  removeLoader() {
    isLoading = false;
    notifyListeners();
  }

  createToDo(ToDoModel todo) async {
    addLoader();
    await _firebaseFirestore
        .collection(userId)
        .doc(todo.tid)
        .set(todo.toMap())
        .then((value) {
      todos.add(todo);
    });
    removeLoader();
    notifyListeners();
  }

  readToDo() async {
    addLoader();
    todos = [];
    try {
      await _firebaseFirestore.collection(userId).get().then((value) async {
        for (var element in value.docs) {
          await _firebaseFirestore
              .collection(userId)
              .doc(element.reference.id)
              .get()
              .then((value) {
            todos.add(ToDoModel.fromMap(value.data()));
          });
        }
      });
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          colorText: AppConstants.primaryColor);
    } finally {
      removeLoader();
      notifyListeners();
    }
  }

  updateToDo(ToDoModel todo) async {
    addLoader();
    var tIndex = todos.indexWhere((element) => element.tid == todo.tid);
    if (tIndex != -1) {
      // Update todo in FireBase
      await _firebaseFirestore
          .collection(userId)
          .doc(todo.tid)
          .update(todo.toMap());
      todos[tIndex] = todo;
    }
    removeLoader();
    notifyListeners();
  }

  deleteToDo(String tId) async {
    addLoader();
    // After getting the task Id remove that task from tasklist.
    var tIndex = todos.indexWhere((element) => element.tid == tId);
    if (tIndex != -1) {
      // Delete todo from FireBase
      await _firebaseFirestore.collection(userId).doc(tId).delete();
      todos.removeAt(tIndex);
    }
    removeLoader();
    notifyListeners();
  }

  logout() {
    todos = [];
    userId = '';
    isGoogleLogIn = false;
  }
}
