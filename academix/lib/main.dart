import 'package:flutter/material.dart';
import 'package:academix/login.dart';
import 'package:academix/register.dart';

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
      home: LoginPage(),
    );
  }
}
