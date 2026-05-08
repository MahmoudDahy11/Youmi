import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/task.dart';
import '../cubit/task_cubit.dart';
import 'task_list_headers.dart';
import 'task_list_item.dart';

class TodayTaskList extends StatelessWidget {
  final List<Task> overdueTasks;
  final List<Task> todayTasks;

  const TodayTaskList({
    super.key,
    required this.overdueTasks,
    required this.todayTasks,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TaskCubit>();
    return RefreshIndicator(
      onRefresh: () async => cubit.loadTodayTasks(),
      child: ListView(
        children: [
          if (overdueTasks.isNotEmpty) ...[
            const OverdueTasksHeader(),
            ...overdueTasks.map((t) => TaskListItem(task: t, cubit: cubit)),
            const SizedBox(height: 16.0),
            const Divider(height: 1.0),
            const SizedBox(height: 8.0),
          ],
          if (todayTasks.isNotEmpty) ...[
            const SectionHeader(title: 'Tasks'),
            ...todayTasks.map((t) => TaskListItem(task: t, cubit: cubit)),
          ],
          const SizedBox(height: 80.0),
        ],
      ),
    );
  }
}
