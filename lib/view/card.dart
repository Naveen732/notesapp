import 'package:flutter/cupertino.dart';

class NoteCard extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const NoteCard({
    super.key,
    required this.title,
    required this.content,
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xff1f1f1f),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: CupertinoColors.systemGrey, width: 0.3),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title.isNotEmpty)
              Text(
                title,
                style: const TextStyle(
                  color: CupertinoColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            if (title.isNotEmpty) const SizedBox(height: 8),
            Expanded(
              child: Text(
                content,
                style: const TextStyle(
                  color: CupertinoColors.systemGrey2,
                  fontSize: 14,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Icon(
                  CupertinoIcons.delete,
                  size: 18,
                  color: CupertinoColors.systemRed,
                ),
                onPressed: onDelete,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
