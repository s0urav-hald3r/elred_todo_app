import 'package:flutter/foundation.dart';

class ToDoModel {
  String? tid;
  String? title;
  String? description;
  String? date;

  ToDoModel(
      {@required this.tid,
      @required this.title,
      @required this.description,
      @required this.date});

  // receiving data from server
  factory ToDoModel.fromMap(map) {
    return ToDoModel(
        tid: map['tid'],
        title: map['title'],
        description: map['description'],
        date: map['date']);
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'tid': tid,
      'title': title,
      'description': description,
      'date': date
    };
  }
}
