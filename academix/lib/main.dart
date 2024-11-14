import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:academix/home/splash_screen.dart';

import 'page_handler.dart';
import 'authentication/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCXQWSezZa4Bs0ZQUnv0CrnC09MsrkOx0s",
      appId: "938356508831",
      messagingSenderId: "1:938356508831:android:8eba02ce3446e3a15ffaaa",
      projectId: "academix-bc5e6",
    ),
  );
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
