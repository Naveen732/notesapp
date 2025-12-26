import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../viewmodels/note_viewmodel.dart';
import 'add_note_view.dart';

class notelistview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<noteviewmodel>();

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('notes'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(CupertinoIcons.add),
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(builder: (_) => addnoteview()),
            );
          },
        ),
      ),
      child: SafeArea(
        child: GridView.builder(
          itemCount: vm.notes.length,
          itemBuilder: (context, index) {
            final note = vm.notes[index];
            return CupertinoListTile(
              title: Text(note.title),
              subtitle: Text(note.content),
              trailing: CupertinoButton(
                padding: EdgeInsets.zero,
                child: Icon(
                  CupertinoIcons.delete,
                  color: CupertinoColors.systemRed,
                ),
                onPressed: () => vm.deletenote(note.id),
              ),
            );
          }, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 2,
            crossAxisSpacing: 2,
            childAspectRatio: 2,
          ),
        ),
      ),
    );
  }
}
