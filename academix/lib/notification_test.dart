// import "package:flutter/material.dart";
// import "package:flutter_local_notifications/flutter_local_notifications.dart";
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: "Flutter Local Notification Example",
//       home: MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   FlutterLocalNotificationsPlugin plugin = FlutterLocalNotificationsPlugin();
//
//   @override
//   void initState() {
//     super.initState();
//     plugin.initialize(const InitializationSettings(
//       android: AndroidInitializationSettings("@mipmap/ic_launcher"),
//     ));
//   }
//
//   Future<void> _showNotification() async {
//     await plugin.show(
//       0,
//       "Hello!",
//       "This is a simple notification",
//       const NotificationDetails(
//         android: AndroidNotificationDetails(
//           "channel_id",
//           "channel_name",
//           importance: Importance.high,
//           priority: Priority.high,
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: ElevatedButton(
//           onPressed: _showNotification,
//           child: const Text("Show Notification"),
//         ),
//       ),
//     );
//   }
// }
