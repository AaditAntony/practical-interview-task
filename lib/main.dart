import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:task/success.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    Future<bool> getResponse(String email, String password) async {
      final reponse = await http.post(
        Uri.parse("https://reqres.in/api/login"),
        headers: {
          'Content-Type': 'application/json',
          'x-api-key': 'reqres-free-v1',
        },
        body: jsonEncode({'email': email, 'password': password}),
      );
      if (reponse.statusCode == 200) {
        print(jsonDecode(reponse.body));
        print("success");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Success()),
        );
        return true;
      } else {
        return false;
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text("Trial Login Screen")),
      body: Column(
        children: [
          // email controller
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          // password controller
          TextFormField(
            controller: passwordController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),

          TextButton(
            onPressed: () {
              getResponse(
                emailController.text.trim(),
                passwordController.text.trim(),
              );
            },
            child: Text("login"),
          ),
        ],
      ),
    );
  }
}
