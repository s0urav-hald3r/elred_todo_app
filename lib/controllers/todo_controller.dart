import 'package:elred_todo_app/models/todo_model.dart';
import 'package:flutter/foundation.dart';

class ToDoController with ChangeNotifier {
  List<ToDoModel> todos = [];
  addToDo(ToDoModel todo) {
    todos.add(todo);
    notifyListeners();
  }

  updateToDo(ToDoModel todo) {
    var tIndex = todos.indexWhere((element) => element.tid == todo.tid);
    if (tIndex != -1) todos[tIndex] = todo;
    notifyListeners();
  }

  deleteToDo(String tId) {
    // After getting the task Id remove that task from tasklist.
    var tIndex = todos.indexWhere((element) => element.tid == tId);
    if (tIndex != -1) todos.removeAt(tIndex);
    notifyListeners();
  }
}
