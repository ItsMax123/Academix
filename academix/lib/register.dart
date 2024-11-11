import 'package:flutter/material.dart';
import 'package:academix/login.dart';

import 'db/task.dart';
import 'db/user.dart';
import 'home.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 60.0, top: 30, right: 60.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    'Welcome To Academix',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.only(left: 45),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.blue[800],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: 40,
                        height: 1.5,
                        color: Colors.blue[800],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextField(
                        controller: firstNameController,
                        decoration: const InputDecoration(
                          labelText: 'First Name',
                          labelStyle: TextStyle(color: Colors.grey),
                          prefixIcon: Icon(Icons.person, color: Colors.grey),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: lastNameController,
                        decoration: const InputDecoration(
                          labelText: 'Last Name',
                          labelStyle: TextStyle(color: Colors.grey),
                          prefixIcon: Icon(Icons.person, color: Colors.grey),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email Address',
                          labelStyle: TextStyle(color: Colors.grey),
                          prefixIcon:
                              Icon(Icons.email_outlined, color: Colors.grey),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.grey),
                          prefixIcon:
                              Icon(Icons.lock_outline, color: Colors.grey),
                          suffixIcon: Icon(Icons.visibility_outlined,
                              color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 70),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      User user = User([
                        Task("Example Exam Completed Title", "Example Exam Completed Description",
                            "Exam", DateTime.now(), true),
                        Task(
                            "Example Presentation Completed Title",
                            "Example Presentation Completed Description",
                            "Presentation",
                            DateTime.now(),
                            true),
                        Task(
                            "Example Project Completed Title",
                            "Example Project Completed Description",
                            "Project",
                            DateTime.now(),
                            true),
                        Task(
                            "Example Assignment Completed Title",
                            "Example Assignment Completed Description",
                            "Assignment",
                            DateTime.now(),
                            true),
                        Task(
                            "Example Homework Completed Title",
                            "Example Homework Completed Description",
                            "Homework",
                            DateTime.now(),
                            true),
                        Task("Example Other Completed Title", "Example Other Completed Description",
                            "Other", DateTime.now(), true),
                        Task("Example Exam Title", "Example Exam Description", "exam",
                            DateTime.now()),
                        Task("Example Presentation Title", "Example Presentation Description",
                            "Presentation", DateTime.now()),
                        Task("Example Project Title", "Example Project Description", "Project",
                            DateTime.now()),
                        Task("Example Assignment Title", "Example Assignment Description",
                            "Assignment", DateTime.now()),
                        Task("Example Homework Title", "Example Homework Description", "Homework",
                            DateTime.now()),
                        Task("Example Other Title", "Example Other Description", "Other",
                            DateTime.now()),
                        Task(
                            "Example Exam Title with a very long title that will take more than one line.",
                            "Example Other Description with a very long description that will take more than one line.",
                            "Exam",
                            DateTime.now()),
                      ]);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePage(user: user)));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don’t have an account? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                        );
                      },
                      child: Text(
                        'Sign In',
                        style: TextStyle(color: Colors.purple[900]),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          Image.asset(
            "assets/img.jpg",
            height: 120,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
