import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:guinea_pig/config/app.dart';
import 'package:http/http.dart' as http;
import 'package:guinea_pig/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _prefs = SharedPreferences.getInstance();
  final email = TextEditingController();
  final password = TextEditingController();

  // Future<void> checkLogin() async {
  //   final prefs = await _prefs;
  //   final token = prefs.getString('token');
  //   if (token != null) {
  //     Navigator.pushReplacementNamed(context, '/home');
  //   }
  // }

  Future<void> checkLogin() async {
    bool loggedin = await AuthService().checkLogin();
    if (loggedin) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }
  // Future<void> login() async {
  //   final response = await http.post(
  //     Uri.parse('${API_URL}/api/auth/login'),
  //     headers: {'Content-Type': 'application/json'},
  //     body: jsonEncode({
  //       'email': email.text,
  //       'password': password.text,
  //     }),
  //   );
  //   if (response.statusCode == 200) {
  //     final prefs = await _prefs;
  //     prefs.setString('token', jsonDecode(response.body)['token']);
  //     Navigator.pushReplacementNamed(context, '/home');
  //   }
  // }

  Future<void> login() async {
    bool loggedin = await AuthService().login(email.text, password.text);
    if (loggedin) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Column(
          children: [
            TextField(
              controller: email,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextField(
              controller: password,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () {
                login();
              },
              child: const Text('Login'),
            ),
          ],
        ));
  }
}
