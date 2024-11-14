import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../db/user.dart';
import '../bottom_nav.dart';
import '../page_handler.dart';

class AddTaskPage extends StatefulWidget {
  final User user;

  const AddTaskPage({super.key, required this.user});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String type = "Other";
  int year = DateTime.now().year;
  int month = DateTime.now().month;
  int day = DateTime.now().day;

  @override
  Widget build(BuildContext context) {
    UserPageHandler pageHandler = UserPageHandler(context, widget.user);
    return Scaffold(
      bottomNavigationBar: BottomNav(user: widget.user, index: 1),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 30, right: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.grey),
                    onPressed: () {
                      pageHandler.back();
                    },
                  ),
                ),
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
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Enter Title",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 8),
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
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Enter Description",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 8),
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
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Select Type",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 8),
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
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Choose Date",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 8),
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
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            onPressed: () async {
                              final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime(year, month, day),
                                firstDate: DateTime.now()
                                    .subtract(const Duration(days: 999)),
                                lastDate: DateTime.now()
                                    .add(const Duration(days: 999)),
                              );
                              if (picked != null) {
                                setState(() {
                                  year = picked.year;
                                  month = picked.month;
                                  day = picked.day;
                                });
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.calendar_today,
                                    color: Colors.grey),
                                // Calendar icon
                                const SizedBox(width: 8),
                                // Spacing between icon and text
                                Text(
                                  DateFormat('MMMM d, yyyy')
                                      .format(DateTime(year, month, day)),
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 100),
                Align(
                  alignment: Alignment.bottomRight,
                  child: SizedBox(
                    width: 180,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (titleController.text.isEmpty) {
                          notify("Please give your Task a title");
                          return;
                        }
                        await widget.user.addTask(titleController.text, descriptionController.text, type, year, month, day);
                        pageHandler.back();
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

  void notify(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
}
