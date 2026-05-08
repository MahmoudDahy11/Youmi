class TaskValidation {
  static String? validateTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Task title cannot be empty';
    }
    if (value.trim().length < 2) {
      return 'Task title must be at least 2 characters';
    }
    if (value.trim().length > 100) {
      return 'Task title must be less than 100 characters';
    }
    return null;
  }

  static String? validateDescription(String? value) {
    if (value != null && value.length > 500) {
      return 'Description must be less than 500 characters';
    }
    return null;
  }
}
