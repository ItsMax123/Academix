import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User and Product"),
      ),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // TODO Teacher will send the code I think
          // ElevatedButton(
          //   onPressed: () => Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) => UsersPage()),
          //   ),
          //   child: const Text("Manage Users"),
          // ),
          // ElevatedButton(
          //   onPressed: () => Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) => ProductPage()),
          //   ),
          //   child: const Text("Manage Products"),
          // ),
        ],
      ),
    );
  }
}
