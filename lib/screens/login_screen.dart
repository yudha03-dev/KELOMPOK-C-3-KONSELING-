import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/auth_provider.dart';
import 'register_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameCtl = TextEditingController();
  final _passwordCtl = TextEditingController();

  void _login() {
    if (!_formKey.currentState!.validate()) return;
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final success = auth.login(_usernameCtl.text.trim(), _passwordCtl.text.trim());
    if (success) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Username atau password salah")));
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
                const Text("LOGIN", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
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
                ElevatedButton(onPressed: _login, child: const Text("Masuk")),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterScreen()));
                  },
                  child: const Text("Belum punya akun? Daftar di sini"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
