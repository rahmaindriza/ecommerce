import 'package:flutter/material.dart';

class UserDetailPage extends StatelessWidget {
  final dynamic user; // data user dari list

  const UserDetailPage({Key? key, required this.user}) : super(key: key);

  // Fungsi untuk warna role
  Color getRoleColor(String role) {
    switch (role) {
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
    String name = user['name'] ?? '-';
    String email = user['email'] ?? '-';
    String role = user['role'] ?? '-';

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail User"),
        backgroundColor: const Color(0xFFA47449),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Avatar
            CircleAvatar(
              radius: 50,
              backgroundColor: const Color(0xFFA47449),
              child: Text(
                name.isNotEmpty ? name[0].toUpperCase() : '?',
                style: const TextStyle(fontSize: 40, color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),

            // Nama
            Text(
              name,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4B322D),
              ),
            ),
            const SizedBox(height: 8),

            // Role sebagai Chip
            Chip(
              label: Text(
                role.toUpperCase(),
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              backgroundColor: getRoleColor(role),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            ),
            const SizedBox(height: 16),

            // Card info
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.email, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          email,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const Divider(height: 20),
                    Row(
                      children: [
                        const Icon(Icons.person, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          role,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Kembali
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
              label: const Text("Kembali"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFA47449),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
