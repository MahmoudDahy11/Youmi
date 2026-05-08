part of '../notes_view.dart';

class _EditorToolbar extends StatelessWidget {
  const _EditorToolbar({
    required this.state,
    required this.showBackButton,
    required this.isMobile,
    required this.isDark,
    required this.onBack,
    required this.onToggleMode,
    required this.onDelete,
  });

  final NotesLoaded state;
  final bool showBackButton;
  final bool isMobile;
  final bool isDark;
  final VoidCallback onBack;
  final VoidCallback onToggleMode;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 8 : 12, vertical: 8),
      color: isDark ? Colors.grey.shade900 : Colors.grey.shade100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (showBackButton) ...[
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    tooltip: 'Back to notes',
                    onPressed: onBack,
                  ),
                  const SizedBox(width: 4),
                ],
                Flexible(child: _EditPreviewToggle(state, isMobile)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          if (!state.isEditing) ...[
            Tooltip(
              message: 'Copy note content',
              child: IconButton(
                icon: const Icon(Icons.copy_all_rounded, size: 20),
                onPressed: () =>
                    _copyToClipboard(context, state.currentContent),
              ),
            ),
            const SizedBox(width: 4),
          ],
          Tooltip(
            message: 'Delete note',
            child: IconButton(
              icon: Icon(
                Icons.delete_outline,
                color: isDark ? Colors.red.shade400 : Colors.red.shade600,
              ),
              onPressed: onDelete,
            ),
          ),
        ],
      ),
    );
  }

  void _copyToClipboard(BuildContext context, String content) {
    Clipboard.setData(ClipboardData(text: content)).then((_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Note copied to clipboard'),
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            width: 250,
          ),
        );
      }
    });
  }
}

class _EditPreviewToggle extends StatelessWidget {
  const _EditPreviewToggle(this.state, this.isMobile);

  final NotesLoaded state;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      isSelected: [state.isEditing, !state.isEditing],
      borderRadius: BorderRadius.circular(4),
      constraints: BoxConstraints(minWidth: isMobile ? 58 : 70, minHeight: 30),
      onPressed: (index) {
        final shouldToggle =
            (index == 0 && !state.isEditing) || (index == 1 && state.isEditing);
        if (shouldToggle) context.read<NotesCubit>().toggleEditMode();
      },
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 8 : 12),
          child: const Text('Edit'),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 8 : 12),
          child: const Text('Preview'),
        ),
      ],
    );
  }
}
