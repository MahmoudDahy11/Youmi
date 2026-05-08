import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/widgets/add_task_dialog.dart';
import '../../domain/entities/task.dart';
import '../cubit/task_cubit.dart';
import '../widgets/task_error_view.dart';
import '../widgets/today_empty_state.dart';
import '../widgets/today_task_list.dart';

class TodayView extends StatelessWidget {
  const TodayView({super.key});

  @override
  Widget build(BuildContext context) {
    final todayDate = DateFormat('EEEE, MMMM d').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: _TodayHeader(date: todayDate),
        actions: [
          IconButton(
            onPressed: () => context.read<TaskCubit>().loadTodayTasks(),
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: BlocConsumer<TaskCubit, TaskState>(
        listener: _taskStateListener,
        builder: (context, state) {
          if (state is TaskLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is TodayTasksLoaded) {
            if (state.overdueTasks.isEmpty && state.todayTasks.isEmpty) {
              return const TodayEmptyState();
            }
            return TodayTaskList(
              overdueTasks: state.overdueTasks,
              todayTasks: state.todayTasks,
            );
          }
          if (state is TaskError) {
            return TaskErrorView(
              message: state.message,
              onRetry: () => context.read<TaskCubit>().loadTodayTasks(),
            );
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: const _AddButton(),
    );
  }

  void _taskStateListener(BuildContext context, TaskState state) {
    if (state is TaskError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.message), backgroundColor: Colors.red),
      );
    }
  }
}

class _TodayHeader extends StatelessWidget {
  final String date;
  const _TodayHeader({required this.date});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Today'),
        Text(
          date,
          style: TextStyle(
            fontSize: 13.0,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

class _AddButton extends StatelessWidget {
  const _AddButton();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () async {
        final tasks = await showDialog<List<Task>>(
          context: context,
          builder: (context) => AddTaskDialog(selectedDate: DateTime.now()),
        );
        if (tasks != null && tasks.isNotEmpty && context.mounted) {
          await context.read<TaskCubit>().addNewTasks(tasks);
        }
      },
      icon: const Icon(Icons.add),
      label: const Text('Add Task'),
    );
  }
}
