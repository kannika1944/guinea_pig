import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:guinea_pig/config/app.dart';

class PostService {
  Future<dynamic> fetchPosts() async {
    final respond = await http.get(
      Uri.parse('$API_URL/api/posts'),
      headers: {'Content-Type': 'application/json'},
    );
    return jsonDecode(respond.body);
  }

  static Future<dynamic> fetchPost(String id) async {
    final respond = await http.get(
      Uri.parse('$API_URL/api/posts/$id'),
      headers: {'Content-Type': 'application/json'},
    );
    return jsonDecode(respond.body);
  }
}
