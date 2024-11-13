import 'package:academix/profile/edit_profile.dart';
import 'package:academix/profile/profile.dart';
import 'package:flutter/material.dart';

import 'authentication/forget_password.dart';
import 'authentication/login.dart';
import 'authentication/register.dart';
import 'authentication/reset_password.dart';
import 'calendar/add_task.dart';
import 'calendar/calendar.dart';
import 'calendar/task.dart';
import 'db/task.dart';
import 'db/user.dart';
import 'home/home.dart';

class PageHandler {
  BuildContext context;

  PageHandler(this.context);

  Future<void> toLogin() {
    return Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }

  Future<void> toRegister() {
    return Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const RegisterPage(),
      ),
    );
  }

  Future<void> toForgetPassword() {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ForgetPasswordPage(),
      ),
    );
  }

  Future<void> toResetPassword() {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ResetPasswordPage(),
      ),
    );
  }

  UserPageHandler getUserPageHandler(User user) {
    return UserPageHandler(context, user);
  }
}

class UserPageHandler extends PageHandler {
  User user;

  UserPageHandler(super.context, this.user);

  Future<void> toHome() {
    return Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(user: user),
      ),
    );
  }

  Future<void> toCalendar() {
    return Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => CalendarPage(user: user),
      ),
    );
  }

  Future<void> toView() {
    return Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => CalendarPage(user: user),  // TODO Change
      ),
    );
  }

  Future<void> toProfile() {
    return Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ProfilePage(user: user),
      ),
    );
  }

  Future<void> toEditProfile() {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfilePage(user: user),
      ),
    );
  }

  Future<void> toTask(Task task) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskPage(user: user, task: task),
      ),
    );
  }

  Future<void> toAddTask() {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddTaskPage(user: user),
      ),
    );
  }
}