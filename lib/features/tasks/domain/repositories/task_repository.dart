import '../entities/task.dart';

abstract class TaskRepository {
  Future<List<Task>> getTasksByDate(DateTime date);
  Future<List<Task>> getTasksForWeek(DateTime startOfWeek);
  Future<List<Task>> getTodayTasks(DateTime today);
  Future<List<Task>> getOverdueTasks();
  Future<void> addTask(Task task);
  Future<void> updateTask(Task task);
  Future<void> deleteTask(int taskId);
  Future<void> markTaskStatus(int taskId, TaskStatus status);
  Future<void> handleOverdueTasks();
}
