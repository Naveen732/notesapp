class Note {
  final int id;
  final String title;
  final String content;

  Note({required this.id, required this.title, required this.content});

  Map<String, dynamic> tojson() => {
    'id': id,
    'title': title,
    'content': content,
  };

  factory Note.fromjson(Map<String, dynamic> json) {
    return Note(id: json['id'] as int, title: json['title'], content: json['content']);
  }
}
