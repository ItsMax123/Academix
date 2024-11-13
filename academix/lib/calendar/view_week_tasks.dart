import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../bottom_nav.dart';
import '../db/task.dart';
import '../db/user.dart';

class ViewWeekTasks extends StatefulWidget {
  final User user;
  const ViewWeekTasks({super.key, required this.user});

  @override
  State<ViewWeekTasks> createState() => _ViewWeekTasksState();
}

class _ViewWeekTasksState extends State<ViewWeekTasks> {
  DateTime active = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 50.0, right: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.account_circle,
                        color: Colors.black, size: 100),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Good Evening",
                            style: TextStyle(color: Colors.grey, fontSize: 15)),
                        SizedBox(height: 5),
                        Text("User",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                const Text("Weekly Tasks",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
              ],
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25.0),
              child: tasks(),
            ),
          ),
        ],
      ),
    );
  }

  Expanded tasks() {
    return Expanded(
      child: ListView(
        children: [
          for (Task task in widget.user.getTasksForWeek(active)) taskListItem(task)
        ],
      ),
    );
  }

  Widget taskListItem(Task task) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: task.getColor().withOpacity(0.5),
        border: Border.symmetric(
          horizontal: BorderSide(color: task.getColor(), width: 2),
          vertical: BorderSide(color: task.getColor(), width: 4),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(task.title, style: const TextStyle(fontSize: 20)),
        subtitle: Text(task.description),
      ),
    );
  }
}
