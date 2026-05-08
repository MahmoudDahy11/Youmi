part of '../notes_view.dart';

class NoteEditorPanel extends StatefulWidget {
  const NoteEditorPanel({
    super.key,
    required this.state,
    this.showBackButton = false,
  });

  final NotesLoaded state;
  final bool showBackButton;

  @override
  State<NoteEditorPanel> createState() => _NoteEditorPanelState();
}

class _NoteEditorPanelState extends State<NoteEditorPanel> {
  late final TextEditingController _contentController;
  var _internalUpdate = false;

  @override
  void initState() {
    super.initState();
    _contentController = TextEditingController(
      text: widget.state.currentContent,
    );
  }

  @override
  void didUpdateWidget(NoteEditorPanel oldWidget) {
    super.didUpdateWidget(oldWidget);

    final changedNote =
        widget.state.selectedNote?.id != oldWidget.state.selectedNote?.id;
    final leftEditMode = !widget.state.isEditing && oldWidget.state.isEditing;
    final hasServerContent =
        _contentController.text != widget.state.currentContent;

    if (changedNote || (leftEditMode && hasServerContent)) {
      _syncController(widget.state.currentContent);
    }
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.state;
    final cubit = context.read<NotesCubit>();
    final isMobile = MediaQuery.sizeOf(context).width < 600;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        _EditorToolbar(
          state: state,
          showBackButton: widget.showBackButton,
          isMobile: isMobile,
          isDark: isDark,
          onBack: cubit.clearSelectedNote,
          onToggleMode: cubit.toggleEditMode,
          onDelete: () => _confirmDelete(context, cubit),
        ),
        Expanded(
          child: state.isEditing
              ? _EditorBody(
                  controller: _contentController,
                  isMobile: isMobile,
                  isDark: isDark,
                  onChanged: (value) {
                    if (!_internalUpdate) cubit.onContentChanged(value);
                  },
                )
              : _MarkdownPreview(content: state.currentContent),
        ),
      ],
    );
  }

  void _syncController(String content) {
    _internalUpdate = true;
    _contentController.text = content;
    _internalUpdate = false;
  }

  void _confirmDelete(BuildContext context, NotesCubit cubit) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Note'),
        content: const Text('Are you sure you want to delete this note?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(ctx);
              cubit.deleteCurrentNote();
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
