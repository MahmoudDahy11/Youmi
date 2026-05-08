import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/date_helpers.dart';
import '../../../../core/widgets/add_task_dialog.dart';
import '../../domain/entities/task.dart';
import '../cubit/task_cubit.dart';
import 'task_list_item.dart';

class WeeklyDayCard extends StatelessWidget {
  final DateTime day;
  final List<Task> tasks;

  const WeeklyDayCard({super.key, required this.day, required this.tasks});

  @override
  Widget build(BuildContext context) {
    final isToday = day.isSameDay(DateTime.now());
    final dayTasks = tasks.where((t) => t.scheduledDate.isSameDay(day)).toList();
    final completedCount = dayTasks.where((t) => t.status == TaskStatus.completed).length;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      color: isToday ? Colors.blue.shade50 : null,
      child: ExpansionTile(
        initiallyExpanded: isToday,
        leading: _DayIcon(day: day, isToday: isToday),
        title: _DayTitle(
          dayName: DateFormat('EEEE').format(day),
          isToday: isToday,
          count: dayTasks.length,
          completed: completedCount,
        ),
        subtitle: Text(DateFormat('MMM d').format(day), style: const TextStyle(fontSize: 12.0, color: Colors.grey)),
        trailing: IconButton(
          onPressed: () => _addTask(context),
          icon: Icon(Icons.add_circle_outline, color: Colors.blue.shade600),
        ),
        children: [
          if (dayTasks.isEmpty) _EmptyDay() else ...dayTasks.map((t) => TaskListItem(task: t, cubit: context.read<TaskCubit>())),
          const SizedBox(height: 8.0),
        ],
      ),
    );
  }

  Future<void> _addTask(BuildContext context) async {
    final newTasks = await showDialog<List<Task>>(
      context: context,
      builder: (context) => AddTaskDialog(selectedDate: day),
    );
    if (newTasks != null && newTasks.isNotEmpty && context.mounted) {
      await context.read<TaskCubit>().addNewTasks(newTasks);
    }
  }
}

class _DayIcon extends StatelessWidget {
  final DateTime day;
  final bool isToday;
  const _DayIcon({required this.day, required this.isToday});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: isToday ? Colors.blue.shade100 : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        DateFormat('d').format(day),
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0, color: isToday ? Colors.blue.shade700 : Colors.grey.shade700),
      ),
    );
  }
}

class _DayTitle extends StatelessWidget {
  final String dayName;
  final bool isToday;
  final int count;
  final int completed;

  const _DayTitle({required this.dayName, required this.isToday, required this.count, required this.completed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(dayName, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15.0, color: isToday ? Colors.blue.shade700 : null)),
        ),
        if (count > 0)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
            decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(10.0)),
            child: Text('$completed/$count', style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500)),
          ),
      ],
    );
  }
}

class _EmptyDay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Text('No tasks scheduled', style: TextStyle(fontSize: 14.0, color: Colors.grey, fontStyle: FontStyle.italic)),
    );
  }
}
