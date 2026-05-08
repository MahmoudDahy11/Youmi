import 'package:flutter/material.dart';

class TodayEmptyState extends StatelessWidget {
  const TodayEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.task_alt,
            size: 64.0,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 16.0),
          Text(
            'No tasks for today',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            'Tap the button below to add a task',
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }
}
