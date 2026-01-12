import 'package:flutter/material.dart';
import '../services/user_service.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({Key? key}) : super(key: key);

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  String _role = 'customer';
  bool loading = false;

  bool isValidEmail(String email) {
    return RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah User"),
        backgroundColor: const Color(0xFFA47449),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // ======================
              // NAMA
              // ======================
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Nama",
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                value!.trim().isEmpty ? "Nama wajib diisi" : null,
              ),
              const SizedBox(height: 16),

              // ======================
              // EMAIL
              // ======================
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "Email",
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Email wajib diisi";
                  }
                  if (!isValidEmail(value.trim())) {
                    return "Format email tidak valid";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // ======================
              // ROLE
              // ======================
              DropdownButtonFormField<String>(
                value: _role,
                decoration: const InputDecoration(
                  labelText: "Role",
                  prefixIcon: Icon(Icons.admin_panel_settings),
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'customer', child: Text('Customer')),
                  DropdownMenuItem(value: 'seller', child: Text('Seller')),
                  DropdownMenuItem(value: 'admin', child: Text('Admin')),
                ],
                onChanged: (value) {
                  setState(() => _role = value!);
                },
              ),
              const SizedBox(height: 24),

              // ======================
              // BUTTON
              // ======================
              loading
                  ? const CircularProgressIndicator()
                  : SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  label: const Text("Simpan"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFA47449),
                  ),
                  onPressed: () async {
                    if (!_formKey.currentState!.validate()) return;

                    setState(() => loading = true);

                    final ok = await UserService().addUser(
                      _nameController.text.trim(),
                      _emailController.text.trim(),
                      _role, // ✅ lowercase
                    );

                    setState(() => loading = false);

                    if (ok) {
                      Navigator.pop(context, true);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Gagal menambahkan user"),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
