class note {
  final String id;
  final String title;
  final String content;

  note({required this.id, required this.title, required this.content});

  Map<String, dynamic> tojson() => {
    'id': id,
    'title': title,
    'content': content,
  };

  factory note.fromjson(Map<String, dynamic> json) {
    return note(id: json['id'], title: json['title'], content: json['content']);
  }
}
