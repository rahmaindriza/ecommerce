import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class UserService {
  final String baseUrl = 'http://10.11.12.234:4000';

  // =========================
  // GET USERS
  // =========================
  Future<List<User>> getUsers() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users'),
        headers: {'Accept': 'application/json'},
      );

      print('GET STATUS: ${response.statusCode}');
      print('GET BODY: ${response.body}');

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        return data.map((e) => User.fromJson(e)).toList();
      }

      return [];
    } catch (e) {
      print('Error getUsers: $e');
      return [];
    }
  }

  // =========================
  // ADD USER
  // =========================
  Future<bool> addUser(String name, String email, String role) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          "name": name,
          "email": email,
          "role": role,

          // ⚠️ BACKEND WAJIB → walau Flutter tidak pakai
          "password": "123456",
        }),
      );

      print('ADD STATUS: ${response.statusCode}');
      print('ADD BODY: ${response.body}');

      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      print('Error addUser: $e');
      return false;
    }
  }

  // UPDATE USER
  Future<bool> updateUser(int id, String name, String email, String role) async {
    final response = await http.put(
      Uri.parse('$baseUrl/users/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'role': role,
      }),
    );

    return response.statusCode == 200;
  }

// DELETE USER
  Future<bool> deleteUser(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/users/$id'),
    );

    return response.statusCode == 200 || response.statusCode == 204;
  }

}
