import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/user_service.dart';
import 'add_user_page.dart';
import 'user_detail_page.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({Key? key}) : super(key: key);

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  List<User> users = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadUsers();
  }

  Future<void> loadUsers() async {
    setState(() => loading = true);
    final data = await UserService().getUsers();
    setState(() {
      users = data;
      loading = false;
    });
  }

  // ======================
  // EDIT USER DIALOG
  // ======================
  void showEditDialog(User user) {
    final nameCtrl = TextEditingController(text: user.name);
    final emailCtrl = TextEditingController(text: user.email);
    String role = user.role;

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text("Edit User"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: "Nama"),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: emailCtrl,
                decoration: const InputDecoration(labelText: "Email"),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: ['admin', 'seller', 'customer'].contains(role) ? role : 'customer',
                items: const [
                  DropdownMenuItem(value: 'admin', child: Text('Admin')),
                  DropdownMenuItem(value: 'seller', child: Text('Seller')),
                  DropdownMenuItem(value: 'customer', child: Text('Customer')),
                ],
                onChanged: (val) => setState(() => role = val!),
                decoration: const InputDecoration(labelText: "Role"),
              )
              ,
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () async {
                final success = await UserService().updateUser(
                  user.id,
                  nameCtrl.text,
                  emailCtrl.text,
                  role,
                );

                if (success) {
                  Navigator.pop(context);
                  loadUsers();
                }
              },
              child: const Text("Simpan"),
            ),
          ],
        ),
      ),
    );
  }

  // ======================
  // UI
  // ======================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar User'),
        backgroundColor: const Color(0xFFA47449),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ADD USER BUTTON
            ElevatedButton.icon(
              icon: const Icon(Icons.person_add),
              label: const Text("Tambah User"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFA47449),
              ),
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddUserPage()),
                );
                if (result == true) loadUsers();
              },
            ),
            const SizedBox(height: 16),

            // LIST USER
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
                      title: Text(user.name),
                      subtitle: Text('${user.email} | ${user.role}'),
                      trailing: PopupMenuButton<String>(
                        onSelected: (value) async {
                          if (value == 'detail') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    UserDetailPage(user: user),
                              ),
                            );
                          } else if (value == 'edit') {
                            showEditDialog(user);
                          } else if (value == 'delete') {
                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text("Hapus User"),
                                content: const Text(
                                    "Yakin ingin menghapus user ini?"),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, false),
                                    child: const Text("Batal"),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red),
                                    onPressed: () =>
                                        Navigator.pop(context, true),
                                    child: const Text("Hapus"),
                                  ),
                                ],
                              ),
                            );

                            if (confirm == true) {
                              final success = await UserService()
                                  .deleteUser(user.id);
                              if (success) loadUsers();
                            }
                          }
                        },
                        itemBuilder: (_) => const [
                          PopupMenuItem(
                            value: 'detail',
                            child: Text('Detail'),
                          ),
                          PopupMenuItem(
                            value: 'edit',
                            child: Text('Edit'),
                          ),
                          PopupMenuItem(
                            value: 'delete',
                            child: Text(
                              'Hapus',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
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
