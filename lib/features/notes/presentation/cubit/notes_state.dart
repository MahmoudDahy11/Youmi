part of 'notes_cubit.dart';

abstract class NotesState {}

class NotesInitial extends NotesState {}

class NotesLoading extends NotesState {}

class NotesLoaded extends NotesState {
  final List<Note> allNotes;
  final List<Note> pinnedNotes;
  final String searchQuery;
  final List<Note> searchResults;
  final Note? selectedNote;
  final bool isEditing;
  final String currentContent;

  NotesLoaded({
    required this.allNotes,
    required this.pinnedNotes,
    required this.searchQuery,
    required this.selectedNote,
    required this.isEditing,
    required this.currentContent,
    required this.searchResults,
  });

  NotesLoaded copyWith({
    List<Note>? allNotes,
    List<Note>? pinnedNotes,
    String? searchQuery,
    Note? selectedNote,
    bool? isEditing,
    String? currentContent,
    List<Note>? searchResults,
    bool clearSelection = false,
  }) {
    return NotesLoaded(
      allNotes: allNotes ?? this.allNotes,
      pinnedNotes: pinnedNotes ?? this.pinnedNotes,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedNote: clearSelection ? null : (selectedNote ?? this.selectedNote),
      isEditing: isEditing ?? this.isEditing,
      currentContent: currentContent ?? this.currentContent,
      searchResults: searchResults ?? this.searchResults,
    );
  }
}

class NotesError extends NotesState {
  final String message;
  NotesError({required this.message});
}
