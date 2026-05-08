import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/task.dart';
import '../../domain/usecases/add_task.dart';
import '../../domain/usecases/delete_task.dart';
import '../../domain/usecases/get_overdue_tasks.dart';
import '../../domain/usecases/get_today_tasks.dart';
import '../../domain/usecases/get_weekly_tasks.dart';
import '../../domain/usecases/handle_overdue_tasks.dart';
import '../../domain/usecases/update_task.dart';
import '../../domain/usecases/update_task_status.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final GetTodayTasksUseCase getTodayTasksUseCase;
  final AddTaskUseCase addTaskUseCase;
  final UpdateTaskStatusUseCase updateTaskStatusUseCase;
  final GetOverdueTasksUseCase getOverdueTasksUseCase;
  final HandleOverdueTasksUseCase handleOverdueTasksUseCase;
  final GetWeeklyTasksUseCase getWeeklyTasksUseCase;
  final DeleteTaskUseCase deleteTaskUseCase;
  final UpdateTaskUseCase updateTaskUseCase;

  TaskCubit({
    required this.getTodayTasksUseCase,
    required this.addTaskUseCase,
    required this.updateTaskStatusUseCase,
    required this.getOverdueTasksUseCase,
    required this.handleOverdueTasksUseCase,
    required this.getWeeklyTasksUseCase,
    required this.deleteTaskUseCase,
    required this.updateTaskUseCase,
  }) : super(TaskInitial());

  Future<void> loadTodayTasks() async {
    emit(TaskLoading());
    try {
      await handleOverdueTasksUseCase();
      final today = DateTime.now();
      final overdueTasks = await getOverdueTasksUseCase();
      final todayTasks = await getTodayTasksUseCase(today);

      todayTasks.sort((a, b) => a.isFlexible ? 1 : -1);
      overdueTasks.sort((a, b) => a.isFlexible ? 1 : -1);

      emit(TodayTasksLoaded(
        todayTasks: todayTasks,
        overdueTasks: overdueTasks,
      ));
    } catch (e) {
      emit(TaskError(message: 'Failed to load today tasks'));
    }
  }

  Future<void> loadWeeklyTasks(DateTime startOfWeek) async {
    emit(TaskLoading());
    try {
      final weeklyTasks = await getWeeklyTasksUseCase(startOfWeek);
      emit(WeeklyTasksLoaded(
        weeklyTasks: weeklyTasks,
        startOfWeek: startOfWeek,
      ));
    } catch (e) {
      emit(TaskError(message: 'Failed to load weekly tasks'));
    }
  }

  Future<void> addNewTask(Task task) async {
    await addTaskUseCase(task);
    _reloadCurrentState();
  }

  Future<void> addNewTasks(List<Task> tasks) async {
    for (final task in tasks) {
      await addTaskUseCase(task);
    }
    _reloadCurrentState();
  }

  Future<void> markTaskAsCompleted(int taskId) async {
    await updateTaskStatusUseCase(taskId, TaskStatus.completed);
    _reloadCurrentState();
  }

  Future<void> markTaskAsInProgress(int taskId) async {
    await updateTaskStatusUseCase(taskId, TaskStatus.inProgress);
    _reloadCurrentState();
  }

  Future<void> deleteTask(int taskId) async {
    await deleteTaskUseCase(taskId);
    _reloadCurrentState();
  }

  Future<void> updateTaskDetails(Task task) async {
    await updateTaskUseCase(task);
    _reloadCurrentState();
  }

  void _reloadCurrentState() {
    final currentState = state;
    if (currentState is TodayTasksLoaded) {
      loadTodayTasks();
    } else if (currentState is WeeklyTasksLoaded) {
      loadWeeklyTasks(currentState.startOfWeek);
    }
  }
}
