import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elred_todo_app/models/todo_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ToDoController with ChangeNotifier {
  List<ToDoModel> todos = [];
  bool isLoding = false;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  ToDoController() {
    readToDo();
  }

  createToDo(ToDoModel todo) async {
    isLoding = true;
    User? user = _firebaseAuth.currentUser;

    await _firebaseFirestore
        .collection(user!.uid)
        .doc(todo.tid)
        .set(todo.toMap())
        .then((value) {
      todos.add(todo);
    });

    isLoding = false;
    notifyListeners();
  }

  readToDo() async {
    isLoding = true;
    User? user = _firebaseAuth.currentUser;

    await _firebaseFirestore.collection(user!.uid).get().then((value) async {
      for (var element in value.docs) {
        await _firebaseFirestore
            .collection(user.uid)
            .doc(element.reference.id)
            .get()
            .then((value) {
          todos.add(ToDoModel.fromMap(value.data()));
        });
      }
    });

    isLoding = false;
    notifyListeners();
  }

  updateToDo(ToDoModel todo) async {
    isLoding = true;
    User? user = _firebaseAuth.currentUser;

    var tIndex = todos.indexWhere((element) => element.tid == todo.tid);
    if (tIndex != -1) {
      // Update todo in FireBase
      await _firebaseFirestore
          .collection(user!.uid)
          .doc(todo.tid)
          .update(todo.toMap());
      todos[tIndex] = todo;
    }

    isLoding = false;
    notifyListeners();
  }

  deleteToDo(String tId) async {
    isLoding = true;
    User? user = _firebaseAuth.currentUser;

    // After getting the task Id remove that task from tasklist.
    var tIndex = todos.indexWhere((element) => element.tid == tId);
    if (tIndex != -1) {
      // Delete todo from FireBase
      await _firebaseFirestore.collection(user!.uid).doc(tId).delete();
      todos.removeAt(tIndex);
    }

    isLoding = false;
    notifyListeners();
  }
}
