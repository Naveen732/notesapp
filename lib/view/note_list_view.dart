import 'package:flutter/cupertino.dart';
import 'package:note_taking/view/card.dart';
import 'package:note_taking/view/edit_note_view.dart';
import 'package:provider/provider.dart';
import '../viewmodels/note_viewmodel.dart';
import 'add_note_view.dart';

class NoteListView extends StatelessWidget {
  Widget build(BuildContext context) {
    final vm = context.watch<NoteViewModel>();

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(
          ' notes app',
          style: TextStyle(color: CupertinoColors.systemGrey),
        ),
      ),
      child: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: CupertinoSearchTextField(
                    placeholder: 'search notes',
                    onChanged: (value) => vm.setsearch(value),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child:
                        vm.notesfiltered.isEmpty && vm.searchText.isNotEmpty
                            ? Center(
                              child: Text(
                                'notes not found',
                                style: TextStyle(
                                  color: CupertinoColors.systemGrey,
                                  fontSize: 16,
                                ),
                              ),
                            )
                            : GridView.builder(
                              itemCount: vm.notesfiltered.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 12,
                                    mainAxisSpacing: 12,
                                    childAspectRatio: 0.9,
                                  ),
                              itemBuilder: (context, index) {
                                final note = vm.notesfiltered[index];
                                return NoteCard(
                                  title: note.title,
                                  content: note.content,
                                  onDelete: () => vm.deletenote(note.id),
                                  onTap: () async {
                                    final result = await Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder:
                                            (_) => EditNoteView(noteData: note),
                                      ),
                                    );
                                    if (result != null) {
                                      vm.updatenote(
                                        note.id,
                                        result['title'],
                                        result['content'],
                                      );
                                    }
                                  },
                                );
                              },
                            ),
                  ),
                ),
              ],
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
