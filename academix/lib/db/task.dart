import 'package:flutter/material.dart';

class Task {
  String title;
  String description;
  String type;
  DateTime date;
  bool completed;

  Task(this.title, this.description, this.type, this.date,
      [this.completed = false]);

  Color getColor() {
    if (completed) {
      return Colors.black54;
    }
    switch (type) {
      case "Exam":
        return Colors.red;
      case "Presentation":
        return Colors.yellow;
      case "Project":
        return Colors.purple;
      case "Assignment":
        return Colors.blue;
      case "Homework":
        return Colors.green;
    }
    return Colors.grey;
  }

  BoxShape getShape() {
    if (type == "Exam" || type == "Presentation") {
      return BoxShape.rectangle;
    }
    return BoxShape.circle;
  }
}
