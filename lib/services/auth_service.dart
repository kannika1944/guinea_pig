import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:guinea_pig/config/app.dart';

class AuthService {
  final _prefs = SharedPreferences.getInstance();

  Future<bool> checkLogin() async {
    final prefs = await _prefs;
    final token = prefs.getString('token');
    if (token != null) {
      return true;
    }
    return false;
  }

  Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('${API_URL}/api/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );
    if (response.statusCode == 200) {
      final prefs = await _prefs;
      prefs.setString('token', jsonDecode(response.body)['token']);
      return true;
    }
    return false;
  }
}
