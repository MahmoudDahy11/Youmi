import 'package:isar/isar.dart';

import '../../domain/entities/note.dart';
import '../../domain/repositories/note_repository.dart';
import '../models/note_model.dart';

class NoteRepositoryImpl implements NoteRepository {
  final Isar isar;

  NoteRepositoryImpl({required this.isar});

  @override
  Future<List<Note>> getAllNotes() async {
    final models =
        await isar.noteModels.where().sortByCreatedAtDesc().findAll();

    return models.map(_toEntity).toList();
  }

  @override
  Future<List<Note>> getPinnedNotes() async {
    final models = await isar.noteModels
        .where()
        .pinnedEqualTo(true)
        .sortByCreatedAtDesc()
        .findAll();

    return models.map(_toEntity).toList();
  }

  @override
  Future<List<Note>> searchNotes(String query) async {
    final models = await isar.noteModels
        .filter()
        .titleContains(query, caseSensitive: false)
        .or()
        .markdownContentContains(query, caseSensitive: false)
        .sortByCreatedAtDesc()
        .findAll();

    return models.map(_toEntity).toList();
  }

  @override
  Future<Note?> getNoteById(int id) async {
    final model = await isar.noteModels.get(id);
    if (model == null) return null;
    return _toEntity(model);
  }

  @override
  Future<void> addNote(Note note) async {
    final model = NoteModel()
      ..title = note.title
      ..markdownContent = note.markdownContent
      ..tags = note.tags.toList()
      ..pinned = note.pinned
      ..createdAt = note.createdAt
      ..updatedAt = note.updatedAt;

    await isar.writeTxn(() async {
      await isar.noteModels.put(model);
    });
  }

  @override
  Future<void> updateNote(Note note) async {
    final model = await isar.noteModels.get(note.id);
    if (model != null) {
      model
        ..title = note.title
        ..markdownContent = note.markdownContent
        ..tags = note.tags.toList()
        ..pinned = note.pinned
        ..updatedAt = note.updatedAt;

      await isar.writeTxn(() async {
        await isar.noteModels.put(model);
      });
    }
  }

  @override
  Future<void> deleteNote(int id) async {
    await isar.writeTxn(() async {
      await isar.noteModels.delete(id);
    });
  }

  @override
  Future<void> togglePinNote(int id) async {
    final model = await isar.noteModels.get(id);
    if (model != null) {
      model.pinned = !model.pinned;
      await isar.writeTxn(() async {
        await isar.noteModels.put(model);
      });
    }
  }

  Note _toEntity(NoteModel model) {
    return Note(
      id: model.id,
      title: model.title,
      markdownContent: model.markdownContent,
      tags: model.tags.toList(),
      pinned: model.pinned,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
    );
  }
}
