import 'package:flutter/cupertino.dart';
import 'package:note_taking/view/card.dart';
import 'package:provider/provider.dart';
import '../viewmodels/note_viewmodel.dart';
import 'add_note_view.dart';

class notelistview extends StatelessWidget {
  Widget build(BuildContext context) {
    final vm = context.watch<noteviewmodel>();

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(
          ' notes',
          style: TextStyle(color: CupertinoColors.systemGrey),
        ),
      ),
      child: SafeArea(
        child: Stack(
          children: [
            
            Padding(
              padding: const EdgeInsets.all(12),
              child: GridView.builder(
                itemCount: vm.notes.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.9,
                ),
                itemBuilder: (context, index) {
                  final note = vm.notes[index];
                  return NoteCard(
                    title: note.title,
                    content: note.content,
                    onDelete: () => vm.deletenote(note.id),
                  );
                },
              ),
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: CupertinoButton(
                padding: const EdgeInsets.all(16),
                color: CupertinoColors.activeBlue,
                borderRadius: BorderRadius.circular(30),
                child: const Icon(
                  CupertinoIcons.add,
                  size: 28,
                  color: CupertinoColors.white,
                ),
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (_) => AddNoteView()),
                  );
                  if (result != null) {
                    vm.addnote(result['title'], result['content']);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
