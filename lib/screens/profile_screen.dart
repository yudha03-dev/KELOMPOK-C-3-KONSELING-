import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/auth_provider.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ambil data user dari AuthProvider
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final name = auth.username ?? 'Pengguna';
    const kelas = 'XI IPA';
    const bio = 'Siswa aktif. Senang Matematika.';

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 44,
              child: Text(
                name.isNotEmpty ? name[0].toUpperCase() : '?',
                style: const TextStyle(fontSize: 28),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(kelas),
            const SizedBox(height: 12),
            Card(
              color: Theme.of(context).canvasColor,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('PROFIL',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text(bio),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Fitur edit profil belum tersedia')));
              },
              child: const Text('Edit Profil'),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
              ),
              onPressed: () {
                // logout user dan kembali ke login screen
                Provider.of<AuthProvider>(context, listen: false).logout();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              },
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
