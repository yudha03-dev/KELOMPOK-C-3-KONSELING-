import 'package:flutter/material.dart';
import 'forum_screen.dart';
import 'chat_guru_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;

  final List<Widget> _pages = const [
    ForumScreen(isAcademic: true),
    ForumScreen(isAcademic: false),
    ChatGuruScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SELAMAT DATANG\nNAMA', style: TextStyle(fontWeight: FontWeight.bold)),
        toolbarHeight: 90,
        automaticallyImplyLeading: false,
        centerTitle: false,
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: IconButton(
              icon: const Icon(Icons.person),
              onPressed: () => setState(() => _index = 3),
            ),
          )
        ],
      ),
      body: _pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'AKADEMIK'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'NON AKADEMIK'),
          BottomNavigationBarItem(icon: Icon(Icons.forum), label: 'CHAT GURU'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'PROFIL'),
        ],
      ),
    );
  }
}
