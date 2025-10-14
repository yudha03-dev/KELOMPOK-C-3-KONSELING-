import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/auth_provider.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameCtl = TextEditingController();
  final _passwordCtl = TextEditingController();

  void _register() {
    if (!_formKey.currentState!.validate()) return;
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final success = auth.register(_usernameCtl.text.trim(), _passwordCtl.text.trim());
    if (success) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Registrasi berhasil! Silakan login.")));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Gagal mendaftar. Coba lagi.")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("REGISTER", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _usernameCtl,
                  decoration: const InputDecoration(labelText: "Username", border: OutlineInputBorder()),
                  validator: (v) => v!.isEmpty ? 'Masukkan username' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordCtl,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: "Password", border: OutlineInputBorder()),
                  validator: (v) => v!.isEmpty ? 'Masukkan password' : null,
                ),
                const SizedBox(height: 24),
                ElevatedButton(onPressed: _register, child: const Text("Daftar")),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
                  },
                  child: const Text("Sudah punya akun? Login di sini"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
