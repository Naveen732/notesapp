import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'view/note_list_view.dart';
import 'viewmodels/note_viewmodel.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NoteViewModel()..init(),
      child: CupertinoApp(
        debugShowCheckedModeBanner: false,
          home: NoteListView(),
      ),
    );
  }
}
