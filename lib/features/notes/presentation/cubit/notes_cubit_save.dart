part of 'notes_cubit.dart';

extension NotesCubitPersistence on NotesCubit {
  Future<void> deleteCurrentNote() async {
    final current = state;
    if (current is! NotesLoaded || current.selectedNote == null) return;

    final note = current.selectedNote!;
    if (note.id != -1) await deleteNoteUseCase(note.id);

    final allNotes = await getNotesUseCase();
    _emit(NotesLoaded(
      allNotes: allNotes,
      pinnedNotes: _pinned(allNotes),
      searchQuery: current.searchQuery,
      searchResults: allNotes,
      selectedNote: null,
      isEditing: false,
      currentContent: '',
    ));
  }

  Future<void> togglePin(int noteId) async {
    final current = state;
    if (current is! NotesLoaded) return;

    final selectedId = current.selectedNote?.id;
    await togglePinNoteUseCase(noteId);
    final allNotes = await getNotesUseCase();

    _emit(NotesLoaded(
      allNotes: allNotes,
      pinnedNotes: _pinned(allNotes),
      searchQuery: current.searchQuery,
      searchResults: _search(allNotes, current.searchQuery),
      selectedNote: _findSelected(allNotes, current.selectedNote, selectedId),
      isEditing: current.isEditing,
      currentContent: current.currentContent,
    ));
  }

  Future<void> _saveInBackground(String content) async {
    final current = state;
    if (current is! NotesLoaded || current.selectedNote == null) return;

    final note = current.selectedNote!;
    final title = _titleFor(note, content);
    final updated = note.copyWith(
      title: title,
      markdownContent: content,
      updatedAt: DateTime.now(),
    );

    note.id == -1
        ? await addNoteUseCase(updated)
        : await updateNoteUseCase(updated);
    final allNotes = await getNotesUseCase();
    final latest = state;
    if (latest is! NotesLoaded) return;

    _emit(NotesLoaded(
      allNotes: allNotes,
      pinnedNotes: _pinned(allNotes),
      searchQuery: latest.searchQuery,
      searchResults: _search(allNotes, latest.searchQuery),
      selectedNote: _findSaved(allNotes, note, title, updated),
      isEditing: latest.isEditing,
      currentContent: latest.currentContent,
    ));
  }
}

List<Note> _pinned(List<Note> notes) => notes.where((n) => n.pinned).toList();

List<Note> _search(List<Note> notes, String query) {
  final q = query.toLowerCase();
  return q.isEmpty
      ? notes
      : notes
          .where((n) =>
              n.title.toLowerCase().contains(q) ||
              n.markdownContent.toLowerCase().contains(q))
          .toList();
}

Note? _findSelected(List<Note> notes, Note? fallback, int? selectedId) {
  if (selectedId == null) return null;
  return notes.firstWhere((n) => n.id == selectedId, orElse: () => fallback!);
}

Note _findSaved(List<Note> notes, Note note, String title, Note fallback) {
  return notes.firstWhere(
    (n) => n.id == note.id || n.title == title,
    orElse: () => fallback,
  );
}

String _titleFor(Note note, String content) {
  if (note.title != 'Untitled' && note.title.isNotEmpty) return note.title;
  final firstLine = content.trim().split('\n').first;
  if (firstLine.isEmpty) return note.title;
  return firstLine.length > 50 ? firstLine.substring(0, 50) : firstLine;
}
