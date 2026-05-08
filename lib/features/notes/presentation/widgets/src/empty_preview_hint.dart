part of '../notes_view.dart';

class _EmptyPreviewHint extends StatelessWidget {
  const _EmptyPreviewHint({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.edit_note,
            size: 48,
            color: isDark ? Colors.grey.shade700 : Colors.grey.shade400,
          ),
          const SizedBox(height: 12),
          Text(
            'Nothing to preview yet',
            style: TextStyle(
              fontSize: 16,
              color: isDark ? Colors.grey.shade600 : Colors.grey.shade500,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Switch to Edit and start writing',
            style: TextStyle(
              fontSize: 13,
              color: isDark ? Colors.grey.shade700 : Colors.grey.shade400,
            ),
          ),
        ],
      ),
    );
  }
}
