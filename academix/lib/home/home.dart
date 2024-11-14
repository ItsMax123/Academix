import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../db/user.dart';
import '../page_handler.dart';
import '../bottom_nav.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  final User user;

  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime today = DateTime.now();
  String currentTime = '';

  @override
  void initState() {
    super.initState();
    currentTime = DateFormat('HH:mm').format(DateTime.now());
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        currentTime = DateFormat('HH:mm').format(DateTime.now());
      });
    });
  }

  String getDayName(DateTime date) {
    return DateFormat('EEE').format(date);
  }

  String getDayNumber(DateTime date) {
    return DateFormat('d').format(date);
  }

  @override
  Widget build(BuildContext context) {
    UserPageHandler pageHandler = UserPageHandler(context, widget.user);

    DateTime previousDay = today.subtract(const Duration(days: 1));
    DateTime currentDay = today;
    DateTime nextDay1 = today.add(const Duration(days: 1));
    DateTime nextDay2 = today.add(const Duration(days: 2));


    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNav(user: widget.user, index: 0),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat('EEEE').format(today),
                      style: const TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "${DateFormat('d').format(today)} ${DateFormat('MMMM').format(today)}",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 85),
                     Text(
                      "Hi ${widget.user.firstName}",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "Number of tasks pending",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                const Icon(
                  Icons.account_circle,
                  size: 80,
                  color: Colors.black,
                ),
              ],
            ),
            const SizedBox(height: 50),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildOvalDateWidget(previousDay, Colors.white),
                  const SizedBox(width: 20),
                  buildOvalDateWidget(currentDay, Colors.purple.shade400),
                  const SizedBox(width: 20),
                  buildOvalDateWidget(nextDay1, Colors.white),
                  const SizedBox(width: 20),
                  buildOvalDateWidget(nextDay2, Colors.white),
                ],
              ),
            ),
            const SizedBox(height: 50),
            const Text(
              "Monthly Preview",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 130,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                            colors: [Colors.pink, Colors.purple],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text(
                              "3\nCompleted",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.orangeAccent, Colors.red],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text(
                              "7\nIn Progress",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.green, Colors.tealAccent],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text(
                              "Quote",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          height: 145,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.blue, Colors.purple],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child:  Center(
                            child: Text(
                              "Clock\n$currentTime",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOvalDateWidget(DateTime date, Color color) {
    return Column(
      children: [
        Container(
          width: 70,
          height: 100,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(45),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 10,
                offset: Offset(3, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                getDayNumber(date),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                getDayName(date),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

}
