import 'dart:math';
import 'package:flutter/cupertino.dart';
import '../models/note_model.dart';
import '../services/note_service.dart';

class noteviewmodel extends ChangeNotifier {
  final noteservice _service = noteservice();
  List<note> notes = [];

  Future<void> init() async {
    notes = await _service.loadnotes();
    notifyListeners();
  }

  void addnote(String title, String content) {

     if(title.trim().isEmpty && content.isEmpty){
        return;
      }
    notes.add(
      note(
        id: Random().nextInt(99999).toString(),
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
}
