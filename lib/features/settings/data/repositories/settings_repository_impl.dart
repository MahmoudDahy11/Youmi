import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

import '../../domain/entities/app_settings.dart';
import '../../domain/repositories/settings_repository.dart';
import '../models/settings_model.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final Isar isar;

  SettingsRepositoryImpl({required this.isar});

  @override
  Future<AppSettings> getSettings() async {
    final models = await isar.settingsModels.where().findAll();
    if (models.isEmpty) {
      return AppSettings(
        id: 0,
        reminderHour: 21,
        themeMode: ThemeMode.system,
        weeklyResetDay: 6,
      );
    }
    return _toEntity(models.first);
  }

  @override
  Future<void> updateSettings(AppSettings settings) async {
    final model = SettingsModel()
      ..id = settings.id
      ..reminderHour = settings.reminderHour
      ..themeMode = settings.themeMode.name
      ..weeklyResetDay = settings.weeklyResetDay;

    await isar.writeTxn(() async {
      await isar.settingsModels.put(model);
    });
  }

  AppSettings _toEntity(SettingsModel model) {
    return AppSettings(
      id: model.id,
      reminderHour: model.reminderHour,
      themeMode: _themeModeFromString(model.themeMode),
      weeklyResetDay: model.weeklyResetDay,
    );
  }

  ThemeMode _themeModeFromString(String mode) {
    switch (mode) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}
