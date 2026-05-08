import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../cubit/task_cubit.dart';
import '../widgets/task_error_view.dart';
import '../widgets/weekly_day_card.dart';

class WeeklyView extends StatefulWidget {
  const WeeklyView({super.key});

  @override
  State<WeeklyView> createState() => _WeeklyViewState();
}

class _WeeklyViewState extends State<WeeklyView> {
  DateTime _currentWeekStart = DateTime.now();

  @override
  void initState() {
    super.initState();
    _currentWeekStart = _getStartOfWeek(DateTime.now());
    _loadWeeklyTasks();
  }

  DateTime _getStartOfWeek(DateTime date) {
    return date.subtract(Duration(days: date.weekday - 1));
  }

  void _loadWeeklyTasks() {
    context.read<TaskCubit>().loadWeeklyTasks(_currentWeekStart);
  }

  void _changeWeek(int days) {
    setState(() => _currentWeekStart = _currentWeekStart.add(Duration(days: days)));
    _loadWeeklyTasks();
  }

  @override
  Widget build(BuildContext context) {
    final weekEnd = _currentWeekStart.add(const Duration(days: 6));
    final weekRange = '${DateFormat('MMM d').format(_currentWeekStart)} - ${DateFormat('MMM d').format(weekEnd)}';

    return Scaffold(
      appBar: AppBar(
        title: _WeeklyHeader(range: weekRange),
        actions: _buildActions(),
      ),
      body: BlocConsumer<TaskCubit, TaskState>(
        listener: _listener,
        builder: (context, state) {
          if (state is TaskLoading) return const Center(child: CircularProgressIndicator());
          if (state is WeeklyTasksLoaded) {
            return _WeeklyList(weekStart: _currentWeekStart, tasks: state.weeklyTasks);
          }
          if (state is TaskError) return TaskErrorView(message: state.message, onRetry: _loadWeeklyTasks);
          return const SizedBox.shrink();
        },
      ),
    );
  }

  List<Widget> _buildActions() => [
    IconButton(onPressed: () => _changeWeek(-7), icon: const Icon(Icons.chevron_left)),
    IconButton(onPressed: () => _changeWeek(7), icon: const Icon(Icons.chevron_right)),
    IconButton(onPressed: _loadWeeklyTasks, icon: const Icon(Icons.refresh)),
  ];

  void _listener(BuildContext context, TaskState state) {
    if (state is TaskError) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message), backgroundColor: Colors.red));
    }
  }
}

class _WeeklyHeader extends StatelessWidget {
  final String range;
  const _WeeklyHeader({required this.range});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Weekly Plan'),
        Text(range, style: TextStyle(fontSize: 13.0, color: Colors.grey.shade600, fontWeight: FontWeight.w400)),
      ],
    );
  }
}

class _WeeklyList extends StatelessWidget {
  final DateTime weekStart;
  final List<dynamic> tasks; // Task type is implied
  const _WeeklyList({required this.weekStart, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 7,
      itemBuilder: (context, index) {
        final day = weekStart.add(Duration(days: index));
        return WeeklyDayCard(day: day, tasks: tasks.cast());
      },
    );
  }
}
