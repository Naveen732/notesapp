import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_taking/view/card.dart';
import 'package:note_taking/view/edit_note_view.dart';
import 'package:provider/provider.dart';
import '../viewmodels/note_viewmodel.dart';
import 'add_note_view.dart';

class NoteListView extends StatefulWidget {
  const NoteListView({super.key});

  @override
  State<NoteListView> createState() => _NoteListViewState();
}

class _NoteListViewState extends State<NoteListView> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(
          'notes app',
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
                  child: Consumer<NoteViewModel>(
                    builder:
                        (_, vm, __) => CupertinoSearchTextField(
                          placeholder: 'search notes',
                          onChanged: vm.setsearch,
                        ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Consumer<NoteViewModel>(
                      builder: (_, vm, __) {
                        final notes = vm.notesfiltered;

                        if (notes.isEmpty && vm.searchText.isNotEmpty) {
                          return const Center(
                            child: Text(
                              'notes not found',
                              style: TextStyle(
                                color: CupertinoColors.systemGrey,
                                fontSize: 16,
                              ),
                            ),
                          );
                        }
                        return AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          child: GridView.builder(
                            itemCount: notes.length,
                            key: ValueKey(vm.searchText),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12,
                                  childAspectRatio: 0.9,
                                ),
                            itemBuilder: (_, index) {
                              final note = notes[index];

                              return TweenAnimationBuilder<double>(
                                duration: const Duration(milliseconds: 350),
                                tween: Tween(begin: 0.8, end: 1.0),
                                builder: (context, value, child) {
                                  return Opacity(
                                    opacity: value,
                                    child: Transform.scale(
                                      scale: value,
                                      child: child,
                                    ),
                                  );
                                },
                                child: NoteCard(
                                  key: ValueKey(note.id),
                                  title: note.title,
                                  content: note.content,
                                  onDelete: () => vm.deleteNote(note.id),
                                  onTap: () async {
                                    final result = await Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder:
                                            (_) => EditNoteView(noteData: note),
                                      ),
                                    );

                                    if (result != null) {
                                      vm.updateNote(
                                        note.id,
                                        result['title'],
                                        result['content'],
                                      );
                                    }
                                  },
                                ),
                              );
                            },
                          ),
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
              child: GestureDetector(
                onTapDown: (_) {
                  setState(() => isPressed = true);
                },
                onTapUp: (_) async {
                  setState(() => isPressed = false);

                  final result = await Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (_) => AddNoteView()),
                  );

                  if (result != null) {
                    context.read<NoteViewModel>().addNote(
                      result['title'],
                      result['content'],
                    );
                  }
                },
                onTapCancel: () {
                  setState(() => isPressed = false);
                },
                child: AnimatedScale(
                  duration: const Duration(milliseconds: 120),
                  curve: Curves.easeOut,
                  scale: isPressed ? 0.7 : 1.0,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: CupertinoColors.activeBlue,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color:Colors.lightBlue,
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      CupertinoIcons.add,
                      size: 28,
                      color: CupertinoColors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
