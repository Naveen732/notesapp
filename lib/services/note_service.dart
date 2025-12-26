import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/note_model.dart';

class noteservice {
  static const _key = 'notes';

  Future<List<note>> loadnotes() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_key);
    if (data == null) return [];

    final list = json.decode(data) as List;
    return list.map((e) => note.fromjson(e)).toList();
  }

  Future<void> savenotes(List<note> notes) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded =
        json.encode(notes.map((e) => e.tojson()).toList());
    await prefs.setString(_key, encoded);
  }
}
