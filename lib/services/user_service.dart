import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  final String baseUrl = 'http://192.168.18.238:4000'; // ganti sesuai emulator/device

  // Ambil list user dari API
  Future<List<dynamic>> getUsers() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/users'));
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        if (body is List) {
          return body; // langsung array JSON
        }
        return [];
      } else {
        print('Status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error getUsers: $e');
      return [];
    }
  }

  // Tambah user lewat API (jika endpoint POST ada)
  Future<bool> addUser(String name, String email, String role) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'name': name, 'email': email, 'role': role}),
      );
      return response.statusCode == 201;
    } catch (e) {
      print('Error addUser: $e');
      return false;
    }
  }
}
