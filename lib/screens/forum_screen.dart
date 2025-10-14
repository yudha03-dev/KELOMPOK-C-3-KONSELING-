import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/forum_provider.dart';
import '../widgets/post_card.dart';
import '../widgets/new_post_input.dart';

class ForumScreen extends StatelessWidget {
  final bool isAcademic;
  const ForumScreen({super.key, required this.isAcademic});

  @override
  Widget build(BuildContext context) {
    final forum = Provider.of<ForumProvider>(context);
    final posts = isAcademic ? forum.getAcademic() : forum.getNonAcademic();

    return SafeArea(
      child: Column(
        children: [
          // Search / input area
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: NewPostInput(isAcademic: isAcademic),
          ),
          const SizedBox(height: 6),
          Expanded(
            child: posts.isEmpty
                ? const Center(child: Text('Belum ada postingan', style: TextStyle(fontSize: 16)))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    itemCount: posts.length,
                    itemBuilder: (ctx, i) => PostCard(post: posts[i], isAcademic: isAcademic),
                  ),
          )
        ],
      ),
    );
  }
}
