import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/task.dart';

class TaskDetailsDialog extends StatelessWidget {
  final Task task;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const TaskDetailsDialog({
    super.key,
    required this.task,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(task.title),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _DetailRow(label: 'Status', value: task.status.value),
            _DetailRow(
              label: 'Type',
              value: task.isFlexible ? 'Flexible' : 'Hard',
            ),
            _DetailRow(
              label: 'Date',
              value: DateFormat('MMM d, yyyy').format(task.scheduledDate),
            ),
            if (task.description != null && task.description!.isNotEmpty) ...[
              const SizedBox(height: 12.0),
              const Text(
                'Description',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4.0),
              Text(task.description!),
            ],
            if (task.completedAt != null) ...[
              const SizedBox(height: 12.0),
              _DetailRow(
                label: 'Completed',
                value:
                    DateFormat('MMM d, yyyy HH:mm').format(task.completedAt!),
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: onDelete,
          child: const Text('Delete', style: TextStyle(color: Colors.red)),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
        ElevatedButton(
          onPressed: onEdit,
          child: const Text('Edit'),
        ),
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100.0,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14.0,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 14.0),
            ),
          ),
        ],
      ),
    );
  }
}
