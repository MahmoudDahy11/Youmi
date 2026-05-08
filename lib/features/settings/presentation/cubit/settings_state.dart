part of 'settings_cubit.dart';

abstract class AppSettingsState {}

class AppSettingsInitial extends AppSettingsState {}

class AppSettingsLoading extends AppSettingsState {}

class AppSettingsLoaded extends AppSettingsState {
  final AppSettings settings;

  AppSettingsLoaded({required this.settings});
}

class AppSettingsError extends AppSettingsState {
  final String message;

  AppSettingsError({required this.message});
}
