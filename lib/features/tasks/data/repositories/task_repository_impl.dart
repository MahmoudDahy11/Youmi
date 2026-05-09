import 'package:isar/isar.dart';
import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../models/task_model.dart';

class TaskRepositoryImpl implements TaskRepository {
  final Isar isar;

  TaskRepositoryImpl({required this.isar});

  @override
  Future<List<Task>> getTasksByDate(DateTime date) async {
    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(const Duration(days: 1));

    final models = await isar.taskModels
        .where()
        .scheduledDateBetween(start, end)
        .findAll();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<List<Task>> getTasksForWeek(DateTime startOfWeek) async {
    final end = startOfWeek.add(const Duration(days: 7));
    final models = await isar.taskModels
        .where()
        .scheduledDateBetween(startOfWeek, end)
        .findAll();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<List<Task>> getTodayTasks(DateTime today) async {
    final start = DateTime(today.year, today.month, today.day);
    final end = start.add(const Duration(days: 1));

    final models = await isar.taskModels
        .where()
        .scheduledDateBetween(start, end)
        .findAll();
    return models
        .where((t) => t.status != TaskStatus.completed.value)
        .map((m) => m.toEntity())
        .toList();
  }

  @override
  Future<List<Task>> getOverdueTasks() async {
    final models = await isar.taskModels
        .filter()
        .statusEqualTo(TaskStatus.overdue.value)
        .findAll();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<void> addTask(Task task) async {
    await isar.writeTxn(() => isar.taskModels.put(TaskModel.fromEntity(task)));
  }

  @override
  Future<void> updateTask(Task task) async {
    final model = await isar.taskModels.get(task.id);
    if (model != null) {
      final updated = TaskModel.fromEntity(task);
      await isar.writeTxn(() => isar.taskModels.put(updated));
    }
  }

  @override
  Future<void> deleteTask(int taskId) async {
    await isar.writeTxn(() => isar.taskModels.delete(taskId));
  }

  @override
  Future<void> markTaskStatus(int taskId, TaskStatus status) async {
    final model = await isar.taskModels.get(taskId);
    if (model != null) {
      model.status = status.value;
      if (status == TaskStatus.completed) model.completedAt = DateTime.now();
      await isar.writeTxn(() => isar.taskModels.put(model));
    }
  }

  @override
  Future<void> handleOverdueTasks() async {
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    final tasks = (await isar.taskModels
            .filter()
            .statusEqualTo(TaskStatus.pending.value)
            .findAll())
        .where((t) => t.scheduledDate.isBefore(todayStart))
        .toList();

    await isar.writeTxn(() async {
      for (final task in tasks) {
        task.status = TaskStatus.overdue.value;
        if (task.isFlexible) task.scheduledDate = todayStart;
        await isar.taskModels.put(task);
      }
    });
  }
}
