import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../viewmodels/note_viewmodel.dart';

class addnoteview extends StatelessWidget {
  final titlecontroller = TextEditingController();
  final contentcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final vm = context.read<noteviewmodel>();

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Text('Save'),
          onPressed: () {
            vm.addnote(
              titlecontroller.text,
              contentcontroller.text,
            );
            Navigator.pop(context);
          },
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              CupertinoTextField(
                controller: titlecontroller,
                placeholder: 'Title',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 12),
              Expanded(
                child: CupertinoTextField(
                  controller: contentcontroller,
                  placeholder: 'Note',
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
