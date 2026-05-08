part of 'notes_cubit.dart';

extension NotesCubitActions on NotesCubit {
  Future<void> loadNotes() async {
    _emit(NotesLoading());
    try {
      final allNotes = await getNotesUseCase();
      _emit(NotesLoaded(
        allNotes: allNotes,
        pinnedNotes: _pinned(allNotes),
        searchQuery: '',
        searchResults: allNotes,
        selectedNote: null,
        isEditing: false,
        currentContent: '',
      ));
    } catch (_) {
      _emit(NotesError(message: 'Failed to load notes'));
    }
  }

  void selectNote(Note note) {
    final current = state;
    if (current is! NotesLoaded) return;
    _autosaveTimer?.cancel();
    _emit(current.copyWith(
      selectedNote: note,
      isEditing: false,
      currentContent: note.markdownContent,
    ));
  }

  void createNewNote() {
    final current = state;
    if (current is! NotesLoaded) return;
    _autosaveTimer?.cancel();
    _emit(current.copyWith(
      selectedNote: Note(
        id: -1,
        title: 'Untitled',
        markdownContent: '',
        tags: [],
        pinned: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      isEditing: true,
      currentContent: '',
    ));
  }

  void clearSelectedNote() {
    final current = state;
    if (current is! NotesLoaded) return;
    _autosaveTimer?.cancel();
    _emit(current.copyWith(
      clearSelection: true,
      isEditing: false,
      currentContent: '',
    ));
  }

  void onContentChanged(String content) {
    final current = state;
    if (current is! NotesLoaded || current.selectedNote == null) return;
    _emit(current.copyWith(currentContent: content));
    _autosaveTimer?.cancel();
    _autosaveTimer = Timer(
      NotesCubit.autosaveDelay,
      () => _saveInBackground(content),
    );
  }

  void toggleEditMode() {
    final current = state;
    if (current is! NotesLoaded) return;
    final nextIsEditing = !current.isEditing;
    _emit(current.copyWith(isEditing: nextIsEditing));
    if (nextIsEditing) return;
    _autosaveTimer?.cancel();
    _saveInBackground(current.currentContent);
  }

  void searchNotes(String query) {
    final current = state;
    if (current is! NotesLoaded) return;
    _emit(current.copyWith(
      searchQuery: query,
      searchResults: _search(current.allNotes, query),
    ));
  }
}
