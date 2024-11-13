import 'package:academix/calendar/task.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'add_task.dart';
import '../bottom_nav.dart';
import '../db/task.dart';
import '../db/user.dart';

class CalendarPage extends StatefulWidget {
  final User user;

  const CalendarPage({super.key, required this.user});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  int offset = 0;
  DateTime active = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNav(user: widget.user, index: 1),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(
          children: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        offset -= 7;
                      });
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  Text(
                    DateFormat('MMMM d, yyyy').format(active),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        offset += 7;
                      });
                    },
                    icon: const Icon(Icons.arrow_forward),
                  ),
                ],
              ),
            ),
            const Divider(),
            calendar(),
            tasks(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple[300],
        foregroundColor: Colors.white,
        shape: CircleBorder(),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTaskPage(user: widget.user),
            ),
          ).then((_) {
            setState(() {});
          });
        },
        child: const Icon(Icons.add, size: 35),
      ),
    );
  }

  GridView calendar() {
    DateTime now = DateTime.now();
    List<Widget> days = [
      weekDay("S"),
      weekDay("M"),
      weekDay("T"),
      weekDay("W"),
      weekDay("T"),
      weekDay("F"),
      weekDay("S"),
    ];
    for (int i = -7; i < 28; i++) {
      days.add(dayGridItem(now.add(Duration(days: i - now.weekday + offset))));
    }
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 7,
      children: days,
    );
  }

  Center weekDay(String day) {
    return Center(
      child: Text(
        day,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ),
      ),
    );
  }

  Widget dayGridItem(DateTime date) {
    List<Widget> circles = [];
    for (Task task in widget.user.getTasksAt(date)) {
      if (task.completed) continue;
      circles.add(Container(
        margin: const EdgeInsets.symmetric(horizontal: 1),
        width: 8.0,
        height: 8.0,
        decoration: BoxDecoration(
          color: task.getColor(),
          shape: task.getShape(),
        ),
      ));
      if (circles.length >= 4) break;
    }
    return ElevatedButton(
      onPressed: () {
        setState(() {
          active = date;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: DateUtils.isSameDay(date, active)
            ? Colors.lightBlueAccent
            : Colors.transparent,
        shadowColor: Colors.transparent,
        padding: const EdgeInsets.only(top: 12),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      child: Column(
        children: [
          Text(
            date.day.toString(),
            style: const TextStyle(fontSize: 18),
          ),
          Wrap(children: circles),
        ],
      ),
    );
  }

  Expanded tasks() {
    return Expanded(
      child: ListView(
        children: [
          for (Task task in widget.user.getTasksAt(active)) taskListItem(task)
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
          horizontal: BorderSide(
            color: task.getColor(),
            width: 2,
          ),
          vertical: BorderSide(
            color: task.getColor(),
            width: 4,
          ),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskPage(user: widget.user, task: task),
            ),
          ).then((_) {
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
              style: const TextStyle(
                fontSize: 20,
              ),
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
