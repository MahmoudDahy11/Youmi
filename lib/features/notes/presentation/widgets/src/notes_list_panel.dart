part of '../notes_view.dart';

class NotesListPanel extends StatefulWidget {
  const NotesListPanel({super.key, required this.state});

  final NotesLoaded state;

  @override
  State<NotesListPanel> createState() => _NotesListPanelState();
}

class _NotesListPanelState extends State<NotesListPanel> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.text = widget.state.searchQuery;
  }

  @override
  void didUpdateWidget(NotesListPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.state.searchQuery != _searchController.text) {
      _searchController.text = widget.state.searchQuery;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.state;
    final cubit = context.read<NotesCubit>();
    final isSearching = state.searchQuery.trim().isNotEmpty;
    final notes = isSearching
        ? state.searchResults
        : state.allNotes.where((note) => !note.pinned).toList();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        _NotesSearchHeader(
          controller: _searchController,
          count: isSearching ? notes.length : state.allNotes.length,
          isDark: isDark,
          searchQuery: state.searchQuery,
          onChanged: cubit.searchNotes,
          onClear: () {
            _searchController.clear();
            cubit.searchNotes('');
          },
        ),
        const Divider(height: 1),
        if (!isSearching && state.pinnedNotes.isNotEmpty) ...[
          const _NotesSectionLabel('Pinned'),
          ...state.pinnedNotes.map(
            (note) => _NoteListTile(
              note: note,
              isSelected: state.selectedNote?.id == note.id,
              onTap: () => cubit.selectNote(note),
              onTogglePin: () => cubit.togglePin(note.id),
            ),
          ),
          const Divider(height: 1),
        ],
        _NotesSectionLabel(isSearching ? 'Search Results' : 'All Notes'),
        Expanded(
          child: _NotesListView(
            notes: notes,
            selectedNote: state.selectedNote,
            isDark: isDark,
            onSelect: cubit.selectNote,
            onTogglePin: cubit.togglePin,
          ),
        ),
      ],
    );
  }
}
