import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../features/notes/data/models/note_model.dart';
import '../../features/notes/data/repositories/note_repository_impl.dart';
import '../../features/notes/domain/repositories/note_repository.dart';
import '../../features/notes/domain/usecases/add_note.dart';
import '../../features/notes/domain/usecases/delete_note.dart';
import '../../features/notes/domain/usecases/get_notes.dart';
import '../../features/notes/domain/usecases/search_notes.dart';
import '../../features/notes/domain/usecases/toggle_pin_note.dart';
import '../../features/notes/domain/usecases/update_note.dart';
import '../../features/notes/presentation/cubit/notes_cubit.dart';
import '../../features/settings/data/models/settings_model.dart';
import '../../features/settings/data/repositories/settings_repository_impl.dart';
import '../../features/settings/domain/repositories/settings_repository.dart';
import '../../features/settings/domain/usecases/get_app_settings.dart';
import '../../features/settings/domain/usecases/update_app_settings.dart';
import '../../features/tasks/data/models/task_model.dart';
import '../../features/tasks/data/repositories/task_repository_impl.dart';
import '../../features/tasks/domain/repositories/task_repository.dart';
import '../../features/tasks/domain/usecases/add_task.dart';
import '../../features/tasks/domain/usecases/delete_task.dart';
import '../../features/tasks/domain/usecases/get_overdue_tasks.dart';
import '../../features/tasks/domain/usecases/get_today_tasks.dart';
import '../../features/tasks/domain/usecases/get_weekly_tasks.dart';
import '../../features/tasks/domain/usecases/handle_overdue_tasks.dart';
import '../../features/tasks/domain/usecases/update_task.dart';
import '../../features/tasks/domain/usecases/update_task_status.dart';
import '../../features/tasks/presentation/cubit/task_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  final dir = await getApplicationDocumentsDirectory();

  final isar = await Isar.open(
    [TaskModelSchema, NoteModelSchema, SettingsModelSchema],
    directory: dir.path,
  );

  getIt.registerSingleton<Isar>(isar);

  // Task Repositories
  getIt.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImpl(isar: getIt<Isar>()),
  );

  // Note Repositories
  getIt.registerLazySingleton<NoteRepository>(
    () => NoteRepositoryImpl(isar: getIt<Isar>()),
  );

  // Settings Repositories
  getIt.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(isar: getIt<Isar>()),
  );

  // Task Use Cases
  getIt.registerLazySingleton(
      () => GetTodayTasksUseCase(getIt<TaskRepository>()));
  getIt.registerLazySingleton(() => AddTaskUseCase(getIt<TaskRepository>()));
  getIt.registerLazySingleton(
      () => UpdateTaskStatusUseCase(getIt<TaskRepository>()));
  getIt.registerLazySingleton(
      () => GetOverdueTasksUseCase(getIt<TaskRepository>()));
  getIt.registerLazySingleton(
      () => HandleOverdueTasksUseCase(getIt<TaskRepository>()));
  getIt.registerLazySingleton(
      () => GetWeeklyTasksUseCase(getIt<TaskRepository>()));
  getIt.registerLazySingleton(() => DeleteTaskUseCase(getIt<TaskRepository>()));
  getIt.registerLazySingleton(() => UpdateTaskUseCase(getIt<TaskRepository>()));

  // Note Use Cases
  getIt.registerLazySingleton(() => GetNotesUseCase(getIt<NoteRepository>()));
  getIt.registerLazySingleton(() => AddNoteUseCase(getIt<NoteRepository>()));
  getIt.registerLazySingleton(() => UpdateNoteUseCase(getIt<NoteRepository>()));
  getIt.registerLazySingleton(() => DeleteNoteUseCase(getIt<NoteRepository>()));
  getIt
      .registerLazySingleton(() => SearchNotesUseCase(getIt<NoteRepository>()));
  getIt.registerLazySingleton(
      () => TogglePinNoteUseCase(getIt<NoteRepository>()));

  // Settings Use Cases
  getIt.registerLazySingleton(
      () => GetAppSettingsUseCase(getIt<SettingsRepository>()));
  getIt.registerLazySingleton(
      () => UpdateAppSettingsUseCase(getIt<SettingsRepository>()));

  // Cubits
  getIt.registerFactory(
    () => TaskCubit(
      getTodayTasksUseCase: getIt<GetTodayTasksUseCase>(),
      addTaskUseCase: getIt<AddTaskUseCase>(),
      updateTaskStatusUseCase: getIt<UpdateTaskStatusUseCase>(),
      getOverdueTasksUseCase: getIt<GetOverdueTasksUseCase>(),
      handleOverdueTasksUseCase: getIt<HandleOverdueTasksUseCase>(),
      getWeeklyTasksUseCase: getIt<GetWeeklyTasksUseCase>(),
      deleteTaskUseCase: getIt<DeleteTaskUseCase>(),
      updateTaskUseCase: getIt<UpdateTaskUseCase>(),
    ),
  );

  getIt.registerFactory(
    () => NotesCubit(
      getNotesUseCase: getIt<GetNotesUseCase>(),
      addNoteUseCase: getIt<AddNoteUseCase>(),
      updateNoteUseCase: getIt<UpdateNoteUseCase>(),
      deleteNoteUseCase: getIt<DeleteNoteUseCase>(),
      searchNotesUseCase: getIt<SearchNotesUseCase>(),
      togglePinNoteUseCase: getIt<TogglePinNoteUseCase>(),
    ),
  );
}
