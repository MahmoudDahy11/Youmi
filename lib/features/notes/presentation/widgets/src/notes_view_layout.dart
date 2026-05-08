part of '../notes_view.dart';

class NotesView extends StatelessWidget {
  const NotesView({super.key});

  static const double _mobileBreakpoint = 600;
  static const double _desktopBreakpoint = 1200;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<NotesCubit, NotesState>(
        listener: _showErrors,
        builder: (context, state) {
          if (state is NotesLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is! NotesLoaded) return const SizedBox.shrink();

          final width = MediaQuery.sizeOf(context).width;
          final isMobile = width < _mobileBreakpoint;
          final listWidth = width < _desktopBreakpoint ? 300.0 : 360.0;

          if (isMobile) {
            return state.selectedNote == null
                ? NotesListPanel(state: state)
                : NoteEditorPanel(state: state, showBackButton: true);
          }

          return Row(
            children: [
              SizedBox(width: listWidth, child: NotesListPanel(state: state)),
              const VerticalDivider(width: 1),
              Expanded(
                child: state.selectedNote == null
                    ? const _EmptySelectionPlaceholder()
                    : NoteEditorPanel(state: state),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<NotesCubit>().createNewNote(),
        tooltip: 'New Note',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showErrors(BuildContext context, NotesState state) {
    if (state is NotesError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.message)),
      );
    }
  }
}

class _EmptySelectionPlaceholder extends StatelessWidget {
  const _EmptySelectionPlaceholder();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Select a note or create a new one',
        style: TextStyle(fontSize: 16, color: Colors.grey),
      ),
    );
  }
}
