part of '../notes_view.dart';

class _NotesListView extends StatelessWidget {
  const _NotesListView({
    required this.notes,
    required this.selectedNote,
    required this.isDark,
    required this.onSelect,
    required this.onTogglePin,
  });

  final List<Note> notes;
  final Note? selectedNote;
  final bool isDark;
  final ValueChanged<Note> onSelect;
  final ValueChanged<int> onTogglePin;

  @override
  Widget build(BuildContext context) {
    if (notes.isEmpty) {
      return Center(
        child: Text(
          'No notes found',
          style: TextStyle(color: isDark ? Colors.grey.shade600 : Colors.grey),
        ),
      );
    }

    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (_, index) {
        final note = notes[index];
        return _NoteListTile(
          note: note,
          isSelected: selectedNote?.id == note.id,
          onTap: () => onSelect(note),
          onTogglePin: () => onTogglePin(note.id),
        );
      },
    );
  }
}

class _NoteListTile extends StatelessWidget {
  const _NoteListTile({
    required this.note,
    required this.isSelected,
    required this.onTap,
    required this.onTogglePin,
  });

  final Note note;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onTogglePin;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final pinColor =
        note.pinned ? const Color(0xFF4A90E2) : Colors.grey.shade600;

    return ListTile(
      selected: isSelected,
      selectedTileColor:
          isDark ? Colors.grey.shade900 : const Color(0xFFE3F2FD),
      title: Text(
        note.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        DateFormat('MMM d, yyyy').format(note.updatedAt),
        style: TextStyle(
          fontSize: 12,
          color: isDark ? Colors.grey.shade500 : Colors.grey.shade600,
        ),
      ),
      trailing: IconButton(
        icon: Icon(
          note.pinned ? Icons.push_pin : Icons.push_pin_outlined,
          size: 18,
          color: pinColor,
        ),
        onPressed: onTogglePin,
      ),
      onTap: onTap,
    );
  }
}
