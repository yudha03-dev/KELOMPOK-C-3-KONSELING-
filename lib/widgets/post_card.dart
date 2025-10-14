import 'package:flutter/material.dart';
import '../models/post.dart';
import 'package:provider/provider.dart';
import '../provider/forum_provider.dart';

class PostCard extends StatelessWidget {
  final Post post;
  final bool isAcademic;
  const PostCard({super.key, required this.post, required this.isAcademic});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ForumProvider>(context, listen: false);
    return Card(
      color: Theme.of(context).canvasColor,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        title: Text(post.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 6),
            Text(post.content),
            const SizedBox(height: 8),
            Row(
              children: [
                CircleAvatar(child: Text(post.author[0]), radius: 12),
                const SizedBox(width: 8),
                Text(post.author, style: const TextStyle(fontSize: 12)),
                const SizedBox(width: 12),
                Text('${post.replies} Balasan', style: const TextStyle(fontSize: 12)),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.reply),
                  onPressed: () => provider.addReplyCount(post.id),
                )
              ],
            )
          ],
        ),
        onTap: () {
          // untuk demo: buka dialog detail
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text(post.title),
              content: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Oleh: ${post.author}'),
                const SizedBox(height: 8),
                Text(post.content),
                const SizedBox(height: 8),
                Text('Balasan: ${post.replies}'),
              ]),
              actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Tutup'))],
            ),
          );
        },
      ),
    );
  }
}
