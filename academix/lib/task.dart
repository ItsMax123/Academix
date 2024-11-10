import 'package:flutter/material.dart';

class TaskPage extends StatefulWidget {
  final Task task;

  const TaskPage({super.key, required this.task});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  TextEditingController title;
  TextEditingController description;

  _TaskPageState(Task task)
      : title = TextEditingController(text: task.title),
        description = TextEditingController(text: task.description);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(
          children: [],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

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
      case "exam":
        return Colors.red;
      case "presentation":
        return Colors.yellow;
      case "project":
        return Colors.purple;
      case "assignment":
        return Colors.blue;
      case "homework":
        return Colors.green;
    }
    return Colors.grey;
  }

  BoxShape getShape() {
    if (type == "exam" || type == "presentation") {
      return BoxShape.rectangle;
    }
    return BoxShape.circle;
  }
}
