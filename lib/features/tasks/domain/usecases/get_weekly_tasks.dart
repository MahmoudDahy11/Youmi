import '../entities/task.dart';
import '../repositories/task_repository.dart';

class GetWeeklyTasksUseCase {
  final TaskRepository repository;

  GetWeeklyTasksUseCase(this.repository);

  Future<List<Task>> call(DateTime startOfWeek) {
    return repository.getTasksForWeek(startOfWeek);
  }
}
