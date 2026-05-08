import 'package:flutter/material.dart';

class AppSettings {
  final int id;
  final int reminderHour;
  final ThemeMode themeMode;
  final int weeklyResetDay;

  AppSettings({
    required this.id,
    required this.reminderHour,
    required this.themeMode,
    required this.weeklyResetDay,
  });

  AppSettings copyWith({
    int? id,
    int? reminderHour,
    ThemeMode? themeMode,
    int? weeklyResetDay,
  }) {
    return AppSettings(
      id: id ?? this.id,
      reminderHour: reminderHour ?? this.reminderHour,
      themeMode: themeMode ?? this.themeMode,
      weeklyResetDay: weeklyResetDay ?? this.weeklyResetDay,
    );
  }
}
