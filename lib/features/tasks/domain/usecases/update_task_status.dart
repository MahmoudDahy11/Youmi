import '../entities/task.dart';
import '../repositories/task_repository.dart';

class UpdateTaskStatusUseCase {
  final TaskRepository repository;

  UpdateTaskStatusUseCase(this.repository);

  Future<void> call(int taskId, TaskStatus status) {
    return repository.markTaskStatus(taskId, status);
  }
}
