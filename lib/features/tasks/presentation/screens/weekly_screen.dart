import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection.dart';
import '../cubit/task_cubit.dart';
import 'weekly_view.dart';

class WeeklyScreen extends StatelessWidget {
  const WeeklyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TaskCubit>(
      create: (_) => getIt<TaskCubit>(),
      child: const WeeklyView(),
    );
  }
}
