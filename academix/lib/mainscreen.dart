import 'package:flutter/material.dart';
import 'package:academix/main.dart';


void main() {
  runApp(const AcademixApp());
}

class AcademixApp extends StatelessWidget {
  const AcademixApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: mainScreen(),
    );
  }
}
class mainScreen extends StatefulWidget {
  const mainScreen({super.key});

  @override
  State<mainScreen> createState() => _mainScreenState();
}

class _mainScreenState extends State<mainScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
