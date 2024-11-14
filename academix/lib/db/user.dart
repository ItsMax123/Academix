import 'package:cloud_firestore/cloud_firestore.dart';
import 'task.dart';

class User {
  DocumentReference doc;
  String id;
  List<Task> tasks;

  String firstName;
  String lastName;
  String email;
  String password;

  User(this.tasks, this.id, this.firstName, this.lastName, this.email, this.password) : doc = FirebaseFirestore.instance.collection("users").doc(id);

  List<Task> getTasksOn(DateTime date) {
    List<Task> tasks = [];
    for (Task task in this.tasks) {
      if (task.year == date.year &&
          task.month == date.month &&
          task.day == date.day) {
        tasks.add(task);
      }
    }
    return tasks;
  }

  Future<void> save() async {
    try {
      await doc.update(toMap());
    } catch (_) {
      // TODO Handle this error
    }
  }

  Future<Task> addTask(String title, String description, String type, int year, int month, int day) async {
    String taskID = (await doc.collection("tasks").add({
      "title": title,
      "description": description,
      "type": type,
      "year": year,
      "month": month,
      "day": day,
      "completed": false,
    }))
        .id;
    Task task = Task(
      id,
      taskID,
      title,
      description,
      type,
      year,
      month,
      day,
      false,
    );
    tasks.add(task);
    return task;
  }

  Future<void> removeTask(Task task) async {
    await doc.collection("tasks").doc(task.id).delete();
    tasks.remove(task);
  }

  Map<String, dynamic> toMap() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "password": password,
    };
  }

  factory User.fromMap(List<Task> tasks, String id, Map<String, dynamic> map) {
    return User(
      tasks,
      id,
      map['firstName'],
      map['lastName'],
      map['email'],
      map['password'],
    );
  }

  static Future<User?> addUser(String firstName, String lastName, String email, String password) async {
    try {
      if ((await FirebaseFirestore.instance.collection("users").where("email", isEqualTo: email).get()).docs.isNotEmpty) {
        return null;
      }
      String userID = (await FirebaseFirestore.instance.collection("users").add({
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password,
      })).id;
      return User(
        [],
        userID,
        firstName,
        lastName,
        email,
        password,
      );
    } catch (_) {
      return null;
    }
  }

  static Future<User?> getUser(String email, String password) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("users")
          .where("email", isEqualTo: email)
          .where("password", isEqualTo: password)
          .get();
      if (querySnapshot.docs.isEmpty) {
        return null;
      }
      var user = querySnapshot.docs.first;
      List<Task> tasks = (await FirebaseFirestore.instance.collection('users')
          .doc(user.id)
          .collection('tasks')
          .get()).docs
          .map((task) => Task.fromMap(user.id, task.id, task.data()))
          .toList();
      return User.fromMap(tasks, user.id, user.data() as Map<String, dynamic>);
    } catch (e) {
      return null;
    }
  }
  static Future<bool> checkEmailExists(String email) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("users")
          .where("email", isEqualTo: email)
          .get();
      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      return false;
    }
  }
  static Future<bool> updatePassword(String email, String newPassword) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("users")
          .where("email", isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {

        String userId = querySnapshot.docs.first.id;

        await FirebaseFirestore.instance
            .collection("users")
            .doc(userId)
            .update({"password": newPassword});

        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }


  List<Task> getTasksForWeek(DateTime activeDate) {
    DateTime startOfWeek = activeDate.subtract(Duration(days: activeDate.weekday - 1));
    DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));
    return tasks.where((task) => task.date.isAfter(startOfWeek.subtract(Duration(days: 1))) && task.date.isBefore(endOfWeek.add(Duration(days: 1)))).toList();
  }
}
