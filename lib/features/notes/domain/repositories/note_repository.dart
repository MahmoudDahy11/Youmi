import '../entities/note.dart';

abstract class NoteRepository {
  Future<List<Note>> getAllNotes();
  Future<List<Note>> getPinnedNotes();
  Future<List<Note>> searchNotes(String query);
  Future<Note?> getNoteById(int id);
  Future<void> addNote(Note note);
  Future<void> updateNote(Note note);
  Future<void> deleteNote(int id);
  Future<void> togglePinNote(int id);
}
