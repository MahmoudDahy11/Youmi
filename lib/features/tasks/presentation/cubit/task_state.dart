part of 'task_cubit.dart';

abstract class TaskState {}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TodayTasksLoaded extends TaskState {
  final List<Task> todayTasks;
  final List<Task> overdueTasks;

  TodayTasksLoaded({
    required this.todayTasks,
    required this.overdueTasks,
  });
}

class WeeklyTasksLoaded extends TaskState {
  final List<Task> weeklyTasks;
  final DateTime startOfWeek;

  WeeklyTasksLoaded({
    required this.weeklyTasks,
    required this.startOfWeek,
  });
}

class TaskError extends TaskState {
  final String message;

  TaskError({required this.message});
}
