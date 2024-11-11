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
      home: MyPage(),
    );
  }
}

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  CollectionReference users = FirebaseFirestore.instance.collection("Users");
  String name = "";
  String password = "";

  Future<void> addUser() async {
    if (name.isNotEmpty && password.isNotEmpty) {
      await users.add({"name": name, "password": password});
      setState(() {
        name = "";
        password = "";
      });
    }
  }

  Future<void> updateUser(String id, String newName) async {
    if (newName.isNotEmpty) {
      try {
        await users.doc(id).update({"name": newName});
      } catch (error) {
        print("Failed to update");
      }
    } else {
      print("Enter a valid name");
    }
  }

  Future<void> deleteUser(String id) async {
    await users.doc(id).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("User FireStore CRUD")),
      body: Column(
        children: [
          TextField(
            onChanged: (value) => name = value,
            decoration: const InputDecoration(hintText: "Type your Name"),
          ),
          TextField(
            onChanged: (value) => password = value,
            decoration: const InputDecoration(hintText: "Type your Password"),
            obscureText: true,
          ),
          ElevatedButton(onPressed: addUser, child: const Text("Add User")),
          const SizedBox(height: 15.0),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: users.snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Text("Loading");
                return ListView(
                  children: snapshot.data!.docs.map((doc) {
                    return ListTile(
                      title: Text(doc["name"]),
                      subtitle: Text("Password: ${doc['password']}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // IconButton(
                          //   onPressed: () => updateUser(doc.id),
                          //   icon: const Icon(Icons.edit),
                          // ),
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  String newName = "";
                                  return AlertDialog(
                                    title: const Text("Edit User"),
                                    content: TextField(
                                      onChanged: (value) {
                                        newName = value;
                                      },
                                      decoration: const InputDecoration(
                                        hintText: "Enter new Name",
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          updateUser(doc.id, newName);
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("Update"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                          IconButton(
                            onPressed: () => deleteUser(doc.id),
                            icon: const Icon(Icons.delete),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
