import '../models/note_model.dart';
import 'note_service.dart';

class NoteRepository {
  final NoteService _service;

  NoteRepository(this._service);

  Future<List<Note>> fetchNotes() async {
    try {
      return await _service.loadnotes();
    } catch (e) {
      throw Exception('Failed to load notes: $e');
    }
  }

  Future<void> saveNotes(List<Note> notes) async {
    try {
      await _service.savenotes(notes);
    } catch (e) {
      throw Exception('failed to save notes');
    }
  }

  Future<List<Note>> addNote(List<Note> notes, Note newNote) async {
    final updated = [...notes, newNote];
    await _service.savenotes(updated);
    return updated;
  }

  Future<List<Note>> deleteNote(List<Note> notes, int id) async {
    final updated = notes.where((n) => n.id != id).toList();
    await _service.savenotes(updated);
    return updated;
  }

  Future<List<Note>> updateNote(List<Note> notes, Note updatedNote) async {
    final updated =
        notes.map((n) {
          return n.id == updatedNote.id ? updatedNote : n;
        }).toList();

    await _service.savenotes(updated);
    return updated;
  }
}
