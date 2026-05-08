import 'package:flutter/material.dart';
import '../../../../core/widgets/task_card.dart';
import '../../domain/entities/task.dart';
import '../cubit/task_cubit.dart';
import 'task_details_dialog.dart';
import 'task_dialogs.dart';

class TaskListItem extends StatelessWidget {
  final Task task;
  final TaskCubit cubit;

  const TaskListItem({
    super.key,
    required this.task,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return TaskCard(
      task: task,
      onTap: () => _showTaskDetails(context),
      onComplete: () => cubit.markTaskAsCompleted(task.id),
      onStart: () => cubit.markTaskAsInProgress(task.id),
    );
  }

  void _showTaskDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => TaskDetailsDialog(
        task: task,
        onDelete: () {
          Navigator.pop(ctx);
          TaskDialogs.showConfirmDelete(
            context: context,
            task: task,
            cubit: cubit,
          );
        },
        onEdit: () {
          Navigator.pop(ctx);
          TaskDialogs.showEditTask(
            context: context,
            task: task,
            cubit: cubit,
          );
        },
      ),
    );
  }
}
