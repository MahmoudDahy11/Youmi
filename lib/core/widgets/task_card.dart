import 'package:flutter/material.dart';
import '../../features/tasks/domain/entities/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onTap;
  final VoidCallback onComplete;
  final VoidCallback onStart;

  const TaskCard({
    super.key,
    required this.task,
    required this.onTap,
    required this.onComplete,
    required this.onStart,
  });

  @override
  Widget build(BuildContext context) {
    final isOverdue = task.status == TaskStatus.overdue;
    final isCompleted = task.status == TaskStatus.completed;
    final isInProgress = task.status == TaskStatus.inProgress;

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 4.0,
      ),
      color: isOverdue ? Colors.red.shade50 : null,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Checkbox(
                value: isCompleted,
                onChanged: (_) {
                  if (!isCompleted) {
                    onComplete();
                  }
                },
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        decoration:
                            isCompleted ? TextDecoration.lineThrough : null,
                        color: isOverdue ? Colors.red.shade700 : null,
                      ),
                    ),
                    if (task.description != null &&
                        task.description!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          task.description!,
                          style: TextStyle(
                            fontSize: 13.0,
                            color: Colors.grey.shade600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    if (isOverdue)
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          'Overdue',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.red.shade600,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              if (!isCompleted && !isInProgress) ...[
                const SizedBox(width: 8.0),
                IconButton(
                  onPressed: onStart,
                  icon: Icon(
                    Icons.play_arrow_rounded,
                    color: Colors.blue.shade600,
                  ),
                  tooltip: 'Start Task',
                ),
              ],
              if (isInProgress) ...[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Text(
                    'In Progress',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.orange.shade800,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
              if (task.isFlexible)
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Icon(
                    Icons.autorenew,
                    size: 16.0,
                    color: Colors.grey.shade500,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
