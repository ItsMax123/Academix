import 'package:academix/page_handler.dart';
import 'package:flutter/material.dart';

import 'db/user.dart';

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
    UserPageHandler pageHandler = UserPageHandler(context, widget.user);
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
            pageHandler.toHome();
            break;
          case 1:
            pageHandler.toCalendar();
            break;
          case 2:
            pageHandler.toView();
            break;
          case 3:
            pageHandler.toProfile();
            break;
        }
      },
    );
  }
}
