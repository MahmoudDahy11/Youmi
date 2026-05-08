import '../entities/task.dart';
import '../repositories/task_repository.dart';

class GetTodayTasksUseCase {
  final TaskRepository repository;

  GetTodayTasksUseCase(this.repository);

  Future<List<Task>> call(DateTime today) {
    return repository.getTodayTasks(today);
  }
}
