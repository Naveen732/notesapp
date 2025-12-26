import 'package:flutter/cupertino.dart';
import 'package:note_taking/viewmodels/note_viewmodel.dart';
import 'package:provider/provider.dart';

class AddNoteView extends StatelessWidget {
  AddNoteView({super.key});

  final titlecontroller = TextEditingController();
  final contentcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final vm = context.read<noteviewmodel>();

    return CupertinoPageScaffold(
      child: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: const Icon(
                          CupertinoIcons.back,
                          color: CupertinoColors.white,
                        ),
                        onPressed: () {
                          vm.addnote(
                            titlecontroller.text,
                            contentcontroller.text,
                          );
                          Navigator.pop(context);
                        },
                      ),

                      const Spacer(),

                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: const Icon(
                          CupertinoIcons.check_mark,
                          color: CupertinoColors.white,
                        ),
                        onPressed: () {
                          vm.addnote(
                            titlecontroller.text,
                            contentcontroller.text,
                          );
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: CupertinoTextField(
                    controller: titlecontroller,
                    placeholder: "Title",
                    placeholderStyle: const TextStyle(
                      color: CupertinoColors.systemGrey,
                      fontSize: 22,
                    ),
                    style: const TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: const BoxDecoration(color: Color(0xff121212)),
                  ),
                ),

                const SizedBox(height: 12),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: CupertinoTextField(
                      controller: contentcontroller,
                      placeholder: "Note",
                      placeholderStyle: const TextStyle(
                        color: CupertinoColors.systemGrey,
                        fontSize: 16,
                      ),
                      style: const TextStyle(
                        color: CupertinoColors.white,
                        fontSize: 16,
                        height: 1.5,
                      ),
                      maxLines: null,
                      expands: true,
                      textAlignVertical: TextAlignVertical.top,
                      decoration: const BoxDecoration(color: Color(0xff121212)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
