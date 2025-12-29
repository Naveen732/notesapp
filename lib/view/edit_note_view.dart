import 'package:flutter/cupertino.dart';
import 'package:note_taking/models/note_model.dart';

class EditNoteView extends StatefulWidget {
  final Note noteData;

  const EditNoteView({super.key, required this.noteData});

  @override
  State<EditNoteView> createState() => _EditNoteViewState();
}

class _EditNoteViewState extends State<EditNoteView> {
  late TextEditingController titleController;
  late TextEditingController contentController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.noteData.title);
    contentController = TextEditingController(text: widget.noteData.content);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('edit note'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(
            CupertinoIcons.check_mark,
            color: CupertinoColors.white,
          ),
          onPressed: () {
            Navigator.pop(context, {
              'id': widget.noteData.id,
              'title': titleController.text,
              'content': contentController.text,
            });
          },
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              CupertinoTextField(
                controller: titleController,
                placeholder: 'title',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: CupertinoTextField(
                  controller: contentController,
                  placeholder: 'content',
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
