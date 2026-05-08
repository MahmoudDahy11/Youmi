import '../entities/task.dart';
import '../repositories/task_repository.dart';

class GetOverdueTasksUseCase {
  final TaskRepository repository;

  GetOverdueTasksUseCase(this.repository);

  Future<List<Task>> call() {
    return repository.getOverdueTasks();
  }
}
