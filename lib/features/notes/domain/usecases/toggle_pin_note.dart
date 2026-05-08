import '../repositories/note_repository.dart';

class TogglePinNoteUseCase {
  final NoteRepository repository;

  TogglePinNoteUseCase(this.repository);

  Future<void> call(int id) {
    return repository.togglePinNote(id);
  }
}
