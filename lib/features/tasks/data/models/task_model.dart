import 'package:isar/isar.dart';
import '../../domain/entities/task.dart';

part 'task_model.g.dart';

@Collection()
class TaskModel {
  Id id = Isar.autoIncrement;

  @Index()
  late String title;

  String? description;

  @Index()
  late DateTime scheduledDate;

  late String status;

  late bool isFlexible;

  late DateTime createdAt;

  DateTime? completedAt;

  Task toEntity() {
    return Task(
      id: id,
      title: title,
      description: description,
      scheduledDate: scheduledDate,
      status: TaskStatusExtension.fromString(status),
      isFlexible: isFlexible,
      createdAt: createdAt,
      completedAt: completedAt,
    );
  }

  static TaskModel fromEntity(Task task) {
    final model = TaskModel()
      ..title = task.title
      ..description = task.description
      ..scheduledDate = task.scheduledDate
      ..status = task.status.value
      ..isFlexible = task.isFlexible
      ..createdAt = task.createdAt
      ..completedAt = task.completedAt;

    if (task.id != 0) {
      model.id = task.id;
    }

    return model;
  }
}
