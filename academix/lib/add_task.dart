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
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String type = "Other";
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 60.0, top: 30, right: 60.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 45),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Add Task',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.blue[800],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: 40,
                        height: 1.5,
                        color: Colors.blue[800],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 75),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Enter Title",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextField(
                          controller: titleController,
                          decoration: const InputDecoration(
                            labelText: 'Enter Title',
                            labelStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Enter Description",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextField(
                          controller: descriptionController,
                          decoration: const InputDecoration(
                            labelText: 'Enter Description',
                            labelStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Select Type",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 8),
                      DropdownButton(
                        isExpanded: true,
                        hint: Text(type),
                        items: const [
                          DropdownMenuItem(value: "Exam", child: Text("Exam")),
                          DropdownMenuItem(
                              value: "Presentation",
                              child: Text("Presentation")),
                          DropdownMenuItem(
                              value: "Project", child: Text("Project")),
                          DropdownMenuItem(
                              value: "Assignment", child: Text("Assignment")),
                          DropdownMenuItem(
                              value: "Homework", child: Text("Homework")),
                          DropdownMenuItem(
                              value: "Other", child: Text("Other")),
                        ],
                        onChanged: (value) {
                          setState(() {
                            if (value != null) type = value;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Choose Date",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shadowColor: Colors.transparent, // Remove shadow from the button itself
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.calendar_today, color: Colors.grey), // Calendar icon
                                SizedBox(width: 8), // Spacing between icon and text
                                Text(
                                  DateFormat('MMMM d, yyyy').format(date),
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 100),
                Align(
                  alignment: Alignment.bottomRight,
                  child: SizedBox(
                    width: 180,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        widget.user.tasks.add(Task(titleController.text,
                            descriptionController.text, type, date, false));
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[100],
                        foregroundColor: Colors.indigo[500],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Create Task',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
