import 'package:flutter/material.dart';
import "package:http/http.dart";

import "dart:convert";

import '../authentication/login.dart';
import '../db/holiday.dart';
import '../db/user.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0.0;

  Future<List<Holiday>> _getHolidays() async {
    List<Holiday> list = [];
    for (int i = -1; i < 3; i++) {
      try {
        Response res = await get(Uri.parse(
          "https://canada-holidays.ca/api/v1/provinces/QC"
          "?optional=true"
          "&year=${DateTime.now().year + i}",
        ));
        for (Map<String, dynamic> data in json.decode(res.body)["province"]
            ["holidays"]) {
          list.add(Holiday.fromMap(data));
        }
      } catch (error) {
        print(error);
      }
    }
    return list;
  }

  @override
  void initState() {
    super.initState();

    _getHolidays().then((data) {
      User.holidays = data;
    });

    Future.delayed(const Duration(seconds: 3), () {
      transitionToLogin();
    });
  }

  void transitionToLogin() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const LoginPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0;
      });
    });
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade800, Colors.purple.shade400],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          Center(
            child: AnimatedOpacity(
              opacity: _opacity,
              duration: const Duration(seconds: 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.calendar_month,
                    size: 120,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Academix',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white.withOpacity(0.9),
                      letterSpacing: 1.5,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Your Academic Calendar',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white.withOpacity(0.7),
                      fontFamily: 'Roboto',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
