import 'package:flutter/material.dart';
import '../../../../core/widgets/edit_task_dialog.dart';
import '../../domain/entities/task.dart';
import '../cubit/task_cubit.dart';

class TaskDialogs {
  static Future<void> showConfirmDelete({
    required BuildContext context,
    required Task task,
    required TaskCubit cubit,
  }) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Task'),
        content: Text('Delete "${task.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              cubit.deleteTask(task.id);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  static Future<void> showEditTask({
    required BuildContext context,
    required Task task,
    required TaskCubit cubit,
  }) async {
    final updated = await showDialog<Task>(
      context: context,
      builder: (_) => EditTaskDialog(task: task),
    );
    if (updated != null) {
      cubit.updateTaskDetails(updated);
    }
  }
}
