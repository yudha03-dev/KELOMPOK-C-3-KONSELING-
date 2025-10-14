import 'package:flutter/material.dart';
import '../models/post.dart';
import 'dart:math';

class ForumProvider extends ChangeNotifier {
  // two categories: academic & nonAcademic
  final List<Post> _academicPosts = [
    Post(
      id: 'a1',
      title: 'Kesulitan Belajar Matematika',
      content: 'Saya sering bingung kalau soal cerita, mohon tipsnya 🙏',
      author: 'Anonim',
      replies: 5,
    ),
    Post(
      id: 'a2',
      title: 'Cara Belajar Efektif',
      content: 'Ada cara biar konsentrasi saat belajar malam?',
      author: 'Anonim',
      replies: 5,
    ),
  ];

  final List<Post> _nonAcademicPosts = [
    Post(
      id: 'n1',
      title: 'Susah tidur karena begadang',
      content: 'Aku sering begadang, gimana atur tidur biar sehat?',
      author: 'Anonim',
      replies: 6,
    ),
    Post(
      id: 'n2',
      title: 'Susah fokus karena masalah keluarga',
      content: 'Orang tua sering bertengkar di rumah, aku jadi susah fokus belajar.',
      author: 'Anonim',
      replies: 12,
    ),
  ];

  List<Post> getAcademic() => List.unmodifiable(_academicPosts.reversed);
  List<Post> getNonAcademic() => List.unmodifiable(_nonAcademicPosts.reversed);

  void addPost({required bool isAcademic, required String title, required String content, required bool anonymous, String? authorName}) {
    final id = 'p${Random().nextInt(100000)}';
    final post = Post(
      id: id,
      title: title,
      content: content,
      author: anonymous ? 'Anonim' : (authorName ?? 'User'),
    );
    if (isAcademic) {
      _academicPosts.add(post);
    } else {
      _nonAcademicPosts.add(post);
    }
    notifyListeners();
  }

  void addReplyCount(String id) {
    for (var p in _academicPosts) {
      if (p.id == id) { p.replies++; notifyListeners(); return; }
    }
    for (var p in _nonAcademicPosts) {
      if (p.id == id) { p.replies++; notifyListeners(); return; }
    }
  }
}
