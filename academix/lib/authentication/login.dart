import 'package:flutter/material.dart';
import 'package:academix/authentication/register.dart';
import 'package:academix/authentication/forget_password.dart';
import 'package:academix/home/home.dart';

import '../db/task.dart';
import '../db/user.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool rememberPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 60.0, top: 45, right: 60.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    'Academix',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 60),
                Padding(
                  padding: const EdgeInsets.only(left: 45),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Login',
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
                const SizedBox(height: 30),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email Address',
                          labelStyle: TextStyle(color: Colors.grey),
                          prefixIcon:
                              Icon(Icons.email_outlined, color: Colors.grey),
                        ),
                      ),
                      const SizedBox(height: 30),
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
                const SizedBox(height: 45),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: rememberPassword,
                          onChanged: (value) {
                            setState(() {
                              rememberPassword = value ?? false;
                            });
                          },
                        ),
                        const Text('Remember password',
                            style: TextStyle(fontSize: 18)),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ForgetPasswordPage()));
                      },
                      child: Text(
                        'Forget password',
                        style: TextStyle(color: Colors.blue[600], fontSize: 18),
                      ),
                    ),
                  ],
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
                      'Login',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don’t have an account?"),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const RegisterPage()));
                      },
                      child: Text(
                        'Sign Up',
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
