import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  DocumentReference doc;
  String id;

  String title;
  String description;
  String type;
  int year;
  int month;
  int day;
  bool completed;

  Task(
    String userID,
    this.id,
    this.title,
    this.description,
    this.type,
    this.year,
    this.month,
    this.day,
    this.completed,
  ) : doc = FirebaseFirestore.instance
            .collection("users")
            .doc(userID)
            .collection("tasks")
            .doc(id);

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

  Future<void> save() async {
    try {
      await doc.update(toMap());
    } catch (_) {
      // TODO Handle this error
    }
  }

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "description": description,
      "type": type,
      "year": year,
      "month": month,
      "day": day,
      "completed": completed,
    };
  }

  factory Task.fromMap(String userID, String id, Map<String, dynamic> map) {
    return Task(
      userID,
      id,
      map['title'],
      map['description'],
      map['type'],
      map['year'],
      map['month'],
      map['day'],
      map['completed'],
    );
  }
}
