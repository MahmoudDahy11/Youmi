import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../cubit/notes_cubit.dart';
import '../widgets/notes_view.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NotesCubit>(
      create: (_) => getIt<NotesCubit>()..loadNotes(),
      child: const NotesView(),
    );
  }
}
