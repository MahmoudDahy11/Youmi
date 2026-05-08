import 'package:flutter/material.dart';

import '../../features/tasks/domain/entities/task.dart';
import '../validation/task_validation.dart';

class AddTaskDialog extends StatefulWidget {
  final DateTime selectedDate;

  const AddTaskDialog({
    super.key,
    required this.selectedDate,
  });

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isFlexible = true;
  bool _repeatDailyThisWeek = false;
  DateTime _taskDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _taskDate = widget.selectedDate;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    if (_repeatDailyThisWeek) {
      return;
    }

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _taskDate,
      firstDate: DateTime.now().subtract(const Duration(days: 30)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (pickedDate != null) {
      setState(() {
        _taskDate = pickedDate;
      });
    }
  }

  DateTime _startOfWeek(DateTime date) {
    final normalizedDate = DateTime(date.year, date.month, date.day);
    return normalizedDate.subtract(Duration(days: normalizedDate.weekday - 1));
  }

  List<DateTime> _scheduledDates() {
    if (!_repeatDailyThisWeek) {
      return [_taskDate];
    }

    final monday = _startOfWeek(_taskDate);
    return List.generate(
      7,
      (index) => monday.add(Duration(days: index)),
    );
  }

  List<Task> _buildTasks() {
    final createdAt = DateTime.now();
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();

    return _scheduledDates()
        .map(
          (date) => Task(
            id: 0,
            title: title,
            description: description.isEmpty ? null : description,
            scheduledDate: date,
            status: TaskStatus.pending,
            isFlexible: _isFlexible,
            createdAt: createdAt,
            completedAt: null,
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Task'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Task Title',
                  hintText: 'Enter task title',
                ),
                validator: TaskValidation.validateTitle,
                autofocus: true,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description (optional)',
                  hintText: 'Enter task description',
                ),
                validator: TaskValidation.validateDescription,
                maxLines: 3,
                textInputAction: TextInputAction.newline,
              ),
              const SizedBox(height: 20.0),
              Opacity(
                opacity: _repeatDailyThisWeek ? 0.55 : 1.0,
                child: InkWell(
                  onTap: _repeatDailyThisWeek ? null : _selectDate,
                  borderRadius: BorderRadius.circular(4.0),
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'Date',
                      suffixIcon: Icon(
                        Icons.calendar_today,
                        color: _repeatDailyThisWeek
                            ? Theme.of(context).disabledColor
                            : null,
                      ),
                      enabled: !_repeatDailyThisWeek,
                    ),
                    child: Text(
                      '${_taskDate.year}-${_taskDate.month.toString().padLeft(2, '0')}-${_taskDate.day.toString().padLeft(2, '0')}',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Flexible Task'),
                subtitle: Text(
                  _isFlexible
                      ? 'Will move to next day if not completed'
                      : 'Must be completed on scheduled date',
                  style: const TextStyle(fontSize: 12.0),
                ),
                value: _isFlexible,
                onChanged: (value) {
                  setState(() {
                    _isFlexible = value;
                  });
                },
              ),
              const SizedBox(height: 8.0),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Repeat daily this week'),
                subtitle: const Text(
                  'This task will be added to every day from Monday to Sunday for the current week.',
                  style: TextStyle(fontSize: 12.0),
                ),
                value: _repeatDailyThisWeek,
                onChanged: (value) {
                  setState(() {
                    _repeatDailyThisWeek = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.of(context).pop(_buildTasks());
            }
          },
          child: const Text('Add Task'),
        ),
      ],
    );
  }
}
