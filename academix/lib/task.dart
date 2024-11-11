import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'db/task.dart';
import 'db/user.dart';

class TaskPage extends StatefulWidget {
  final User user;
  final Task task;

  const TaskPage({super.key, required this.user, required this.task});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(
          children: [
            TextFormField(
              initialValue: widget.task.title,
              onChanged: (value) {
                widget.task.title = value;
              },
            ),
            TextFormField(
              initialValue: widget.task.description,
              onChanged: (value) {
                widget.task.description = value;
              },
            ),
            DropdownButton(
              hint: Text(widget.task.type),
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
                  if (value != null) widget.task.type = value;
                });
              },
            ),
            ElevatedButton(
              onPressed: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: widget.task.date,
                  firstDate: DateTime.now().subtract(const Duration(days: 999)),
                  lastDate: DateTime.now().add(const Duration(days: 999)),
                );
                if (picked != null && picked != widget.task.date) {
                  setState(() {
                    widget.task.date = picked;
                  });
                }
              },
              child: Text(DateFormat('MMMM d, yyyy').format(widget.task.date)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Completed", style: TextStyle(fontSize: 20)),
                Switch(
                  value: widget.task.completed,
                  activeColor: Colors.blue,
                  onChanged: (bool value) {
                    setState(() {
                      widget.task.completed = value;
                    });
                  },
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                widget.user.tasks.remove(widget.task);
                Navigator.pop(context);
              },
              child: const Text("Delete Task"),
            ),
          ],
        ),
      ),
    );
  }
}