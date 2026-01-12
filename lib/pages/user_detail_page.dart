import 'package:flutter/material.dart';
import '../models/user_model.dart';

class UserDetailPage extends StatelessWidget {
  final User user;

  const UserDetailPage({Key? key, required this.user}) : super(key: key);

  // Warna berdasarkan role
  Color getRoleColor(String role) {
    switch (role.toLowerCase()) {
      case 'admin':
        return Colors.redAccent;
      case 'seller':
        return Colors.orangeAccent;
      case 'customer':
      default:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Jika role kosong/null, default ke "customer"
    final displayRole = (user.role != null && user.role.isNotEmpty) ? user.role : 'customer';
    final displayName = (user.name != null && user.name.isNotEmpty) ? user.name : 'User';
    final displayEmail = (user.email != null && user.email.isNotEmpty) ? user.email : '-';

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail User"),
        backgroundColor: const Color(0xFFA47449),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Avatar
            CircleAvatar(
              radius: 60,
              backgroundColor: const Color(0xFFA47449),
              child: Text(
                displayName[0].toUpperCase(),
                style: const TextStyle(fontSize: 50, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),

            // Nama
            Text(
              displayName,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF4B322D)),
            ),
            const SizedBox(height: 8),

            // Role Chip
            Chip(
              label: Text(
                displayRole.toUpperCase(),
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              backgroundColor: getRoleColor(displayRole),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            const SizedBox(height: 24),

            // Informasi User
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.email, color: Color(0xFFA47449)),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(displayEmail, style: const TextStyle(fontSize: 16, color: Color(0xFF4B322D))),
                        ),
                      ],
                    ),
                    const Divider(height: 32, thickness: 1),
                    Row(
                      children: [
                        const Icon(Icons.person, color: Color(0xFFA47449)),
                        const SizedBox(width: 12),
                        Text(
                          displayRole[0].toUpperCase() + displayRole.substring(1),
                          style: const TextStyle(fontSize: 16, color: Color(0xFF4B322D)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Tombol Kembali
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
                label: const Text("Kembali"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFA47449),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
