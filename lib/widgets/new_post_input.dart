import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/forum_provider.dart';

class NewPostInput extends StatefulWidget {
  final bool isAcademic;
  const NewPostInput({super.key, required this.isAcademic});

  @override
  State<NewPostInput> createState() => _NewPostInputState();
}

class _NewPostInputState extends State<NewPostInput> {
  final _formKey = GlobalKey<FormState>();
  final _titleCtl = TextEditingController();
  final _contentCtl = TextEditingController();
  bool _anonymous = true;

  @override
  void dispose() {
    _titleCtl.dispose();
    _contentCtl.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() != true) return;
    final forum = Provider.of<ForumProvider>(context, listen: false);
    forum.addPost(
      isAcademic: widget.isAcademic,
      title: _titleCtl.text.trim(),
      content: _contentCtl.text.trim(),
      anonymous: _anonymous,
    );
    _titleCtl.clear();
    _contentCtl.clear();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Posting berhasil ditambahkan')));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).canvasColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  Text(widget.isAcademic ? 'FORUM DISKUSI (AKADEMIK)' : 'FORUM DISKUSI (NON AKADEMIK)', style: const TextStyle(fontWeight: FontWeight.bold)),
                  const Spacer(),
                  Row(
                    children: [
                      const Text('Sebagai Anonim'),
                      Switch(value: _anonymous, onChanged: (v) => setState(() => _anonymous = v)),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _titleCtl,
                decoration: const InputDecoration(hintText: 'Judul singkat...', border: OutlineInputBorder()),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Masukkan judul' : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _contentCtl,
                minLines: 2,
                maxLines: 4,
                decoration: const InputDecoration(hintText: 'Ketik disini........', border: OutlineInputBorder()),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Masukkan isi posting' : null,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(child: ElevatedButton(onPressed: _submit, child: const Text('Post'))),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
