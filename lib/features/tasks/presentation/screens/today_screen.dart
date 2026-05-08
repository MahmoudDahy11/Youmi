import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection.dart';
import '../cubit/task_cubit.dart';
import 'today_view.dart';

class TodayScreen extends StatelessWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TaskCubit>(
      create: (_) => getIt<TaskCubit>()..loadTodayTasks(),
      child: const TodayView(),
    );
  }
}
