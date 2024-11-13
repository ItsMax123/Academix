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
  List<Task> getTasksForWeek(DateTime activeDate) {
    DateTime startOfWeek = activeDate.subtract(Duration(days: activeDate.weekday - 1));
    DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));
    return tasks.where((task) => task.date.isAfter(startOfWeek.subtract(Duration(days: 1))) && task.date.isBefore(endOfWeek.add(Duration(days: 1)))).toList();
  }
}