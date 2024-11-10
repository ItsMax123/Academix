import 'package:academix/task.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// TODO Remove all until line 27

void main() {
  runApp(const AcademixApp());
}

class AcademixApp extends StatefulWidget {
  const AcademixApp({super.key});

  @override
  State<AcademixApp> createState() => _AcademixAppState();
}

class _AcademixAppState extends State<AcademixApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalendarPage(),
    );
  }
}

// TODO Remove all until line 4

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState(User([
        Day(DateTime.now(), [
          Task(
              "Example Exam Completed Title",
              "Example Exam Completed Description",
              "exam",
              DateTime.now(),
              true),
          Task(
              "Example Presentation Completed Title",
              "Example Presentation Completed Description",
              "presentation",
              DateTime.now(),
              true),
          Task(
              "Example Project Completed Title",
              "Example Project Completed Description",
              "project",
              DateTime.now(),
              true),
          Task(
              "Example Assignment Completed Title",
              "Example Assignment Completed Description",
              "assignment",
              DateTime.now(),
              true),
          Task(
              "Example Homework Completed Title",
              "Example Homework Completed Description",
              "homework",
              DateTime.now(),
              true),
          Task(
              "Example Other Completed Title",
              "Example Other Completed Description",
              "other",
              DateTime.now(),
              true),
          Task("Example Exam Title", "Example Exam Description", "exam",
              DateTime.now()),
          Task("Example Presentation Title", "Example Presentation Description",
              "presentation", DateTime.now()),
          Task("Example Project Title", "Example Project Description",
              "project", DateTime.now()),
          Task("Example Assignment Title", "Example Assignment Description",
              "assignment", DateTime.now()),
          Task("Example Homework Title", "Example Homework Description",
              "homework", DateTime.now()),
          Task("Example Other Title", "Example Other Description", "other",
              DateTime.now()),
          Task(
              "Example Exam Title with a very long title that will take more than one line.",
              "Example Other Description with a very long description that will take more than one line.",
              "exam",
              DateTime.now()),
        ])
      ]));
}

class _CalendarPageState extends State<CalendarPage> {
  User user = User([]);
  int offset = 0;
  DateTime active = DateTime.now();

  // DateTime start = now.subtract(Duration(days: now.weekday + 7));
  // DateTime end = now.add(Duration(days: now.weekday + 21));
  _CalendarPageState(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        onPressed: () {},
        child: const Icon(Icons.add),
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
      days.add(
          dayGridItem(user.getDayAt(now.add(Duration(days: i - now.weekday + offset)))));
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

  Widget dayGridItem(Day day) {
    List<Widget> circles = [];
    for (Task task in day.tasks) {
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
          active = day.date;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: day.isSameDayAs(active)
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
            day.date.day.toString(),
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
          for (Task task in user.getDayAt(active).tasks) taskListItem(task)
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
            MaterialPageRoute(builder: (context) => TaskPage(task: task)),
          );
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

class User {
  List<Day> days;

  User(this.days);

  Day getDayAt(DateTime date) {
    for (Day day in days) {
      if (DateUtils.isSameDay(day.date, date)) {
        return day;
      }
    }
    return Day(date, []);
  }
}

class Day {
  DateTime date;
  List<Task> tasks = [];

  Day(this.date, this.tasks);

  bool isSameDayAs(DateTime dateTime) {
    return DateUtils.isSameDay(date, dateTime);
  }
}