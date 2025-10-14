class Post {
  final String id;
  final String title;
  final String content;
  final String author; // could be "Anonim" or name
  final DateTime createdAt;
  int replies;

  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    DateTime? createdAt,
    this.replies = 0,
  }) : createdAt = createdAt ?? DateTime.now();
}
