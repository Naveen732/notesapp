import 'package:flutter/cupertino.dart';
import '../models/note_model.dart';
import '../repositories/note_repository.dart';

class NoteViewModel extends ChangeNotifier {
  final NoteRepository _s = NoteRepository();

    List<Note> notes = [];
  
  String _search = '';

   String get searchText => _search;

  List<Note> get notesfiltered {
    if (_search.isEmpty) return notes;

    return notes
        .where(
          (n) =>
              n.title.toLowerCase().contains(_search) ||
              n.content.toLowerCase().contains(_search),
        )
        .toList();
  }

  Future<void> init() async {
    notes = await _s.fetchNotes();
    notifyListeners();
  }

  void setsearch(String value) {
    _search = value.toLowerCase();
    notifyListeners();
  }

 void addnote(String title, String content) {
    if (title.isEmpty && content.isEmpty) {
      return;
    }
    try {
      notes.add(
        Note(
          id: DateTime.now().millisecondsSinceEpoch,
          title: title,
          content: content,
        ),
      );
      _s.saveNotes(notes);
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to add note: $e');
    }
  }

  void deletenote(int id) {
    try {
      notes.removeWhere((n) => n.id == id);
      _s.saveNotes(notes);
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to delete note: $e');
    }
  }

  void updatenote(int id, String title, String content) {
    try {
      final index = notes.indexWhere((n) => n.id == id);
      if (index != -1) {
        notes[index] = Note(id: id, title: title, content: content);
        _s.saveNotes(notes);
        notifyListeners();
      }
    } catch (e) {
      throw Exception('Failed to update note: $e');
    }
  }
}
