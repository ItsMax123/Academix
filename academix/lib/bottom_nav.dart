import 'package:academix/calendar/calendar.dart';
import 'package:flutter/material.dart';
import 'db/user.dart';
import 'home/home.dart';
import 'profile/profile.dart';

class BottomNav extends StatefulWidget {
  final User user;
  final int index;

  const BottomNav({super.key, required this.user, required this.index});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month),
          label: 'Calendar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'View',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: widget.index,
      backgroundColor: Colors.black,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.greenAccent,
      unselectedItemColor: Colors.grey,
      onTap: (int index) {
        switch (index) {
          case 0:
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => HomePage(user: widget.user)),
              (_) {
                return false;
              },
            );
            break;
          case 1:
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => CalendarPage(user: widget.user)),
              (_) {
                return false;
              },
            );
            break;
          case 2:
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => CalendarPage(user: widget.user)),
              (_) {
                return false;
              },
            );
            break;
          case 3:
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => ProfilePage(user: widget.user)),
              (_) {
                return false;
              },
            );
            break;
        }
      },
    );
  }
}
