import 'package:flutter/material.dart';

class ChatGuruScreen extends StatelessWidget {
  const ChatGuruScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final teachers = [
      {'name': 'Pak Budi', 'subject': 'BK'},
      {'name': 'Ibu Siti', 'subject': 'BK'},
      {'name': 'Pak Andi', 'subject': 'BK'},
    ];

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const Text('PILIH GURU BK', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: teachers.length,
                itemBuilder: (ctx, i) {
                  final t = teachers[i];
                  return Card(
                    color: Theme.of(context).canvasColor,
                    child: ListTile(
                      title: Text(t['name']!),
                      subtitle: Text(t['subject']!),
                      trailing: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (_) => ChatRoomScreen(teacherName: t['name']!)));
                        },
                        child: const Text('Chat'),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ChatRoomScreen extends StatefulWidget {
  final String teacherName;
  const ChatRoomScreen({super.key, required this.teacherName});

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _send({required bool anonymous}) {
    final txt = _controller.text.trim();
    if (txt.isEmpty) return;
    _messages.add({'from': anonymous ? 'Anonim' : 'Saya', 'text': txt});
    _controller.clear();
    setState(() {});
  }

  bool _anonymous = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat ${widget.teacherName}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _messages.length,
              itemBuilder: (ctx, i) {
                final m = _messages[i];
                final isMe = m['from'] == 'Saya';
                return Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isMe ? Colors.green.shade700 : Theme.of(context).canvasColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(m['from']!, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 6),
                        Text(m['text']!),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Row(
              children: [
                Switch(value: _anonymous, onChanged: (v) => setState(() => _anonymous = v)),
                const Text('Sebagai Anonim'),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(hintText: 'Ketik pesan...'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () => _send(anonymous: _anonymous),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
