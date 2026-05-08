import '../repositories/task_repository.dart';

class HandleOverdueTasksUseCase {
  final TaskRepository repository;

  HandleOverdueTasksUseCase(this.repository);

  Future<void> call() {
    return repository.handleOverdueTasks();
  }
}
