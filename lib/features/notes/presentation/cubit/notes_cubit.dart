import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/note.dart';
import '../../domain/usecases/add_note.dart';
import '../../domain/usecases/delete_note.dart';
import '../../domain/usecases/get_notes.dart';
import '../../domain/usecases/search_notes.dart';
import '../../domain/usecases/toggle_pin_note.dart';
import '../../domain/usecases/update_note.dart';

part 'notes_cubit_actions.dart';
part 'notes_cubit_save.dart';
part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit({
    required this.getNotesUseCase,
    required this.addNoteUseCase,
    required this.updateNoteUseCase,
    required this.deleteNoteUseCase,
    required this.searchNotesUseCase,
    required this.togglePinNoteUseCase,
  }) : super(NotesInitial());

  final GetNotesUseCase getNotesUseCase;
  final AddNoteUseCase addNoteUseCase;
  final UpdateNoteUseCase updateNoteUseCase;
  final DeleteNoteUseCase deleteNoteUseCase;
  final SearchNotesUseCase searchNotesUseCase;
  final TogglePinNoteUseCase togglePinNoteUseCase;

  Timer? _autosaveTimer;
  static const autosaveDelay = Duration(seconds: 2);

  void _emit(NotesState state) => emit(state);

  @override
  Future<void> close() {
    _autosaveTimer?.cancel();
    return super.close();
  }
}
