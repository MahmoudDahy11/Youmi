class Task {
  final int id;
  final String title;
  final String? description;
  final DateTime scheduledDate;
  final TaskStatus status;
  final bool isFlexible;
  final DateTime createdAt;
  final DateTime? completedAt;

  Task({
    required this.id,
    required this.title,
    this.description,
    required this.scheduledDate,
    required this.status,
    required this.isFlexible,
    required this.createdAt,
    this.completedAt,
  });

  Task copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? scheduledDate,
    TaskStatus? status,
    bool? isFlexible,
    DateTime? createdAt,
    DateTime? completedAt,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      status: status ?? this.status,
      isFlexible: isFlexible ?? this.isFlexible,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }
}

enum TaskStatus {
  pending,
  inProgress,
  completed,
  overdue,
  archived,
}

extension TaskStatusExtension on TaskStatus {
  String get value {
    switch (this) {
      case TaskStatus.pending:
        return 'pending';
      case TaskStatus.inProgress:
        return 'inProgress';
      case TaskStatus.completed:
        return 'completed';
      case TaskStatus.overdue:
        return 'overdue';
      case TaskStatus.archived:
        return 'archived';
    }
  }

  static TaskStatus fromString(String status) {
    switch (status) {
      case 'pending':
        return TaskStatus.pending;
      case 'inProgress':
        return TaskStatus.inProgress;
      case 'completed':
        return TaskStatus.completed;
      case 'overdue':
        return TaskStatus.overdue;
      case 'archived':
        return TaskStatus.archived;
      default:
        return TaskStatus.pending;
    }
  }
}
