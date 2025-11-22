import 'package:flutter/material.dart';
import '../services/user_service.dart';
import 'add_user_page.dart';
import 'user_detail_page.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({Key? key}) : super(key: key);

  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  List<dynamic> users = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadUsers();
  }

  Future<void> loadUsers() async {
    setState(() {
      loading = true;
    });
    final data = await UserService().getUsers();
    setState(() {
      users = data;
      loading = false;
    });
  }

  // Fungsi untuk menentukan warna Chip berdasarkan role
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar User'),
        backgroundColor: const Color(0xFFA47449),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.person_add),
              label: const Text("Tambah User"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFA47449),
              ),
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AddUserPage(),
                  ),
                );
                if (result == true) {
                  loadUsers(); // refresh setelah tambah
                }
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: loading
                  ? const Center(child: CircularProgressIndicator())
                  : users.isEmpty
                  ? const Center(child: Text("Belum ada user"))
                  : ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      title: Text(user['name']),
                      subtitle: Text(user['email']),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Chip untuk role
                          Chip(
                            label: Text(
                              user['role'].toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            backgroundColor:
                            getRoleColor(user['role']),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_forward_ios, size: 16),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => UserDetailPage(user: user),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
