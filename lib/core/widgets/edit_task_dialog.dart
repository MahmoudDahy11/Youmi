import 'package:flutter/material.dart';

import '../../features/tasks/domain/entities/task.dart';
import '../validation/task_validation.dart';

class EditTaskDialog extends StatefulWidget {
  final Task task;

  const EditTaskDialog({super.key, required this.task});

  @override
  State<EditTaskDialog> createState() => _EditTaskDialogState();
}

class _EditTaskDialogState extends State<EditTaskDialog> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late DateTime _taskDate;
  late bool _isFlexible;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.task.title;
    _descriptionController.text = widget.task.description ?? '';
    _taskDate = widget.task.scheduledDate;
    _isFlexible = widget.task.isFlexible;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
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

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Task'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Task Title'),
                validator: TaskValidation.validateTitle,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration:
                    const InputDecoration(labelText: 'Description (optional)'),
                validator: TaskValidation.validateDescription,
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: _selectDate,
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Date',
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  child: Text(
                    '${_taskDate.year}-${_taskDate.month.toString().padLeft(2, '0')}-${_taskDate.day.toString().padLeft(2, '0')}',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Flexible Task'),
                value: _isFlexible,
                onChanged: (value) => setState(() => _isFlexible = value),
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
              final updatedTask = widget.task.copyWith(
                title: _titleController.text.trim(),
                description: _descriptionController.text.trim().isEmpty
                    ? null
                    : _descriptionController.text.trim(),
                scheduledDate: _taskDate,
                isFlexible: _isFlexible,
              );
              Navigator.of(context).pop(updatedTask);
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
