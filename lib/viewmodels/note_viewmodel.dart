import 'package:flutter/cupertino.dart';
import 'package:note_taking/repositories/note_service.dart';
import '../models/note_model.dart';
import '../repositories/note_repository.dart';

class NoteViewModel extends ChangeNotifier {

  final NoteRepository _repo = NoteRepository(NoteService());


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
    notes = await _repo.fetchNotes();
    notifyListeners();
  }

  void setsearch(String value) {
    _search = value.toLowerCase();
    notifyListeners();
  }

Future<void> addNote(String title, String content) async {
  if (title.isEmpty && content.isEmpty) return;

  try {
    final note = Note(
      id: DateTime.now().millisecondsSinceEpoch,
      title: title,
      content: content,
    );
    notes = await _repo.addNote(notes, note);
    notifyListeners();
  } catch (e) {
    throw Exception('Failed to add note: $e');
  }
}

  Future<void> deleteNote(int id) async {
    try {
      notes = await _repo.deleteNote(notes, id);
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to delete note: $e');
    }
   
  }

  Future<void> updateNote(int id, String title, String content) async {
    try{
    final updated = Note(id: id, title: title, content: content);
    notes = await _repo.updateNote(notes, updated);
    notifyListeners();
    } catch (e) {
      throw Exception('Failed to update note: $e');
    }
  }



}
