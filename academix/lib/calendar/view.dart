import 'package:flutter/material.dart';

import '../bottom_nav.dart';
import '../db/task.dart';
import '../db/user.dart';
import '../page_handler.dart';

class ViewPage extends StatefulWidget {
  final User user;

  const ViewPage({super.key, required this.user});

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  @override
  Widget build(BuildContext context) {
    UserPageHandler pageHandler = UserPageHandler(context, widget.user);
    return Scaffold(
      bottomNavigationBar: BottomNav(user: widget.user, index: 2),
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
                      children: [
                        const Text("Good Evening",
                            style: TextStyle(color: Colors.grey, fontSize: 15)),
                        const SizedBox(height: 5),
                        Text(widget.user.firstName,
                            style: const TextStyle(
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
              child: ListView(
                children: [
                  for (Task task in widget.user.getWeeklyTasks())
                    taskListItem(pageHandler, task)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget taskListItem(UserPageHandler pageHandler, Task task) {
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
      child: ElevatedButton(
        onPressed: () {
          pageHandler.toTask(task).then((_) {
            setState(() {});
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: const RoundedRectangleBorder(),
        ),
        child: Column(
          children: [
            Text(
              task.title,
              style: const TextStyle(fontSize: 20),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Text(task.description),
          ],
        ),
      ),
    );
  }
}
