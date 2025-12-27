import 'dart:math';
import 'package:flutter/cupertino.dart';
import '../models/note_model.dart';
import '../services/note_service.dart';

class noteviewmodel extends ChangeNotifier {
  final noteservice _service = noteservice();
  List<note> notes = [];
  String _search = '';

  List<note> get notesfiltered {
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
    notes = await _service.loadnotes();
    notifyListeners();
  }

  void setsearch(String value) {
    _search = value.toLowerCase();
    notifyListeners();
  }

  String get searchText => _search;

  void addnote(String title, String content) {
    if (title.isEmpty && content.isEmpty) {
      return;
    }
    notes.add(
      note(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        content: content,
      ),
    );
    _service.savenotes(notes);
    notifyListeners();
  }

  void deletenote(String id) {
    notes.removeWhere((n) => n.id == id);
    _service.savenotes(notes);
    notifyListeners();
  }

  void updatenote(String id, String title, String content) {
    final index = notes.indexWhere((n) => n.id == id);
    if (index != -1) {
      notes[index] = note(id: id, title: title, content: content);
      _service.savenotes(notes);
      notifyListeners();
    }
  }
}
