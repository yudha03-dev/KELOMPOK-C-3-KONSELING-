import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/forum_provider.dart';
import 'provider/auth_provider.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ForumProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Aplikasi Konseling Sekolah',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: const Color(0xFF1E1E1E),
          canvasColor: const Color(0xFF2A2A2A),
          textTheme: ThemeData.dark().textTheme.apply(fontFamily: 'Roboto'),
        ),
        home: Consumer<AuthProvider>(
          builder: (context, auth, _) {
            return auth.isLoggedIn ? const HomeScreen() : const LoginScreen();
          },
        ),
      ),
    );
  }
}
