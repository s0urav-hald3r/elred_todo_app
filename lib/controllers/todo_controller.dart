import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elred_todo_app/models/todo_model.dart';
import 'package:flutter/material.dart';

class ToDoController with ChangeNotifier {
  List<ToDoModel> todos = [];
  bool isGoogleLogIn = false;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  String userId = '';

  setUser(String id) {
    userId = id;
  }

  setGoogleLogIn(bool _isGoogleLogIn) {
    isGoogleLogIn = _isGoogleLogIn;
    notifyListeners();
  }

  createToDo(ToDoModel todo) async {
    await _firebaseFirestore
        .collection(userId)
        .doc(todo.tid)
        .set(todo.toMap())
        .then((value) {
      todos.add(todo);
    });
    notifyListeners();
  }

  readToDo() async {
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
    notifyListeners();
  }

  updateToDo(ToDoModel todo) async {
    var tIndex = todos.indexWhere((element) => element.tid == todo.tid);
    if (tIndex != -1) {
      // Update todo in FireBase
      await _firebaseFirestore
          .collection(userId)
          .doc(todo.tid)
          .update(todo.toMap());
      todos[tIndex] = todo;
    }
    notifyListeners();
  }

  deleteToDo(String tId) async {
    // After getting the task Id remove that task from tasklist.
    var tIndex = todos.indexWhere((element) => element.tid == tId);
    if (tIndex != -1) {
      // Delete todo from FireBase
      await _firebaseFirestore.collection(userId).doc(tId).delete();
      todos.removeAt(tIndex);
    }
    notifyListeners();
  }

  logout() {
    todos = [];
    userId = '';
    isGoogleLogIn = false;
  }
}
