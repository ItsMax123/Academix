import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'db/task.dart';
import 'db/user.dart';

class AddTaskPage extends StatefulWidget {
  final User user;

  const AddTaskPage({super.key, required this.user});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  String title = "";
  String description = "";
  String type = "Other";
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Task"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                title = value;
              },
            ),
            TextField(
              onChanged: (value) {
                description = value;
              },
            ),
            DropdownButton(
              hint: Text(type),
              items: const [
                DropdownMenuItem(value: "Exam", child: Text("Exam")),
                DropdownMenuItem(
                    value: "Presentation", child: Text("Presentation")),
                DropdownMenuItem(value: "Project", child: Text("Project")),
                DropdownMenuItem(
                    value: "Assignment", child: Text("Assignment")),
                DropdownMenuItem(value: "Homework", child: Text("Homework")),
                DropdownMenuItem(value: "Other", child: Text("Other")),
              ],
              onChanged: (value) {
                setState(() {
                  if (value != null) type = value;
                });
              },
            ),
            ElevatedButton(
              onPressed: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: date,
                  firstDate: DateTime.now().subtract(const Duration(days: 999)),
                  lastDate: DateTime.now().add(const Duration(days: 999)),
                );
                if (picked != null && picked != date) {
                  setState(() {
                    date = picked;
                  });
                }
              },
              child: Text(DateFormat('MMMM d, yyyy').format(date)),
            ),
            ElevatedButton(
              onPressed: () {
                widget.user.tasks.add(Task(title, description, type, date, false));
                Navigator.pop(context);
              },
              child: const Text("Create Task"),
            ),
          ],
        ),
      ),
    );
  }
}