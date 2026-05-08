import 'package:flutter/material.dart';

class OverdueTasksHeader extends StatelessWidget {
  const OverdueTasksHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
      child: Row(
        children: [
          Icon(
            Icons.warning_amber_rounded,
            size: 20.0,
            color: Colors.red.shade400,
          ),
          const SizedBox(width: 8.0),
          Text(
            'Overdue',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w700,
              color: Colors.red.shade600,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w700,
          color: Colors.grey.shade700,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
