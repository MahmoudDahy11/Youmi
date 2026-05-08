import 'package:flutter/material.dart';

class TaskErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const TaskErrorView({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 48.0,
            color: Colors.red.shade300,
          ),
          const SizedBox(height: 16.0),
          Text(
            message,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
