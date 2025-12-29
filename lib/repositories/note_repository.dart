import '../models/note_model.dart';
import '../services/note_service.dart';

class NoteRepository {
  final NoteService _service = NoteService();


  Future<List<Note>> fetchNotes() async {
    try {
      return _service.loadnotes();
    } catch (e) {
      throw Exception('Failed to load notes: $e');
    }
  }

  Future<void> saveNotes(List<Note> notes) async {
    await _service.savenotes(notes);
  }

  
}
