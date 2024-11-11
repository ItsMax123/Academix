import 'package:flutter/material.dart';
import 'task.dart';

class User {
  List<Task> tasks = [];

  User(this.tasks);

  List<Task> getTasksAt(DateTime date) {
    List<Task> tasks = [];
    for (Task task in this.tasks) {
      if (DateUtils.isSameDay(task.date, date)) {
        tasks.add(task);
      }
    }
    return tasks;
  }
}