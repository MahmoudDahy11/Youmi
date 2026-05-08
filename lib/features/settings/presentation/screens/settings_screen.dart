import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youmi/main.dart';

import '../../domain/entities/app_settings.dart';
import '../cubit/settings_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsCubit, AppSettingsState>(
      listener: (context, state) {
        if (state is AppSettingsError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        if (state is AppSettingsLoaded) {
          final settings = state.settings;
          return Scaffold(
            appBar: AppBar(title: const Text('Settings')),
            body: ListView(
              children: [
                const SizedBox(height: 8.0),
                _buildSectionHeader('Reminders'),
                ListTile(
                  leading: const Icon(Icons.notifications_outlined),
                  title: const Text('Evening Review Reminder'),
                  subtitle: Text('${settings.reminderHour}:00 daily'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () async {
                    final selectedHour = await _showHourPicker(
                      context,
                      settings.reminderHour,
                    );
                    if (selectedHour != null) {
                      final updated = settings.copyWith(
                        reminderHour: selectedHour,
                      );
                      context.read<SettingsCubit>().updateSettings(updated);
                      await notificationService
                          .scheduleDailyEveningReminder(selectedHour);
                    }
                  },
                ),
                const Divider(),
                _buildSectionHeader('Appearance'),
                ListTile(
                  leading: const Icon(Icons.brightness_6_outlined),
                  title: const Text('Theme Mode'),
                  subtitle: Text(settings.themeMode.name),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    _showThemePicker(context, settings);
                  },
                ),
              ],
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 13.0,
          fontWeight: FontWeight.w700,
          color: Colors.grey,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Future<int?> _showHourPicker(BuildContext context, int currentHour) async {
    return showDialog<int>(
      context: context,
      builder: (context) {
        int selectedHour = currentHour;
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Evening Reminder Time'),
              content: SizedBox(
                height: 180,
                child: ListWheelScrollView(
                  itemExtent: 50,
                  onSelectedItemChanged: (index) {
                    setState(() {
                      selectedHour = index;
                    });
                  },
                  children: List.generate(
                    24,
                    (index) => Center(
                      child: Text(
                        '${index.toString().padLeft(2, '0')}:00',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: index == currentHour
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context, selectedHour),
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showThemePicker(BuildContext context, AppSettings settings) {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Select Theme'),
          children: [
            RadioListTile<ThemeMode>(
              title: const Text('System'),
              value: ThemeMode.system,
              groupValue: settings.themeMode,
              onChanged: (value) {
                final updated = settings.copyWith(themeMode: value!);
                context.read<SettingsCubit>().updateSettings(updated);
                Navigator.pop(context);
              },
            ),
            RadioListTile<ThemeMode>(
              title: const Text('Light'),
              value: ThemeMode.light,
              groupValue: settings.themeMode,
              onChanged: (value) {
                final updated = settings.copyWith(themeMode: value!);
                context.read<SettingsCubit>().updateSettings(updated);
                Navigator.pop(context);
              },
            ),
            RadioListTile<ThemeMode>(
              title: const Text('Dark'),
              value: ThemeMode.dark,
              groupValue: settings.themeMode,
              onChanged: (value) {
                final updated = settings.copyWith(themeMode: value!);
                context.read<SettingsCubit>().updateSettings(updated);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
