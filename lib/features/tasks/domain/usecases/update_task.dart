import '../entities/task.dart';
import '../repositories/task_repository.dart';

class UpdateTaskUseCase {
  final TaskRepository repository;

  UpdateTaskUseCase(this.repository);

  Future<void> call(Task task) {
    return repository.updateTask(task);
  }
}
