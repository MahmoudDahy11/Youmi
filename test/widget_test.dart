import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:youmi/features/tasks/data/models/task_model.dart';
import 'package:youmi/features/tasks/domain/entities/task.dart';

void main() {
  group('TaskModel.fromEntity', () {
    test('uses Isar auto-increment id for new tasks', () {
      final task = Task(
        id: 0,
        title: 'Plan the day',
        scheduledDate: DateTime(2026, 5, 9),
        status: TaskStatus.pending,
        isFlexible: true,
        createdAt: DateTime(2026, 5, 9, 9),
      );

      final model = TaskModel.fromEntity(task);

      expect(model.id, Isar.autoIncrement);
    });

    test('keeps the existing id when updating a task', () {
      final task = Task(
        id: 42,
        title: 'Plan the day',
        scheduledDate: DateTime(2026, 5, 9),
        status: TaskStatus.inProgress,
        isFlexible: false,
        createdAt: DateTime(2026, 5, 9, 9),
      );

      final model = TaskModel.fromEntity(task);

      expect(model.id, 42);
    });
  });
}
