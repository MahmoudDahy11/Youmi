import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/app_settings.dart';
import '../../domain/usecases/get_app_settings.dart';
import '../../domain/usecases/update_app_settings.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<AppSettingsState> {
  final GetAppSettingsUseCase getAppSettingsUseCase;
  final UpdateAppSettingsUseCase updateAppSettingsUseCase;

  SettingsCubit({
    required this.getAppSettingsUseCase,
    required this.updateAppSettingsUseCase,
  }) : super(AppSettingsInitial());

  Future<void> loadSettings() async {
    emit(AppSettingsLoading());
    try {
      final settings = await getAppSettingsUseCase();
      emit(AppSettingsLoaded(settings: settings));
    } catch (e) {
      emit(AppSettingsError(message: 'Failed to load settings'));
    }
  }

  Future<void> updateSettings(AppSettings updatedSettings) async {
    await updateAppSettingsUseCase(updatedSettings);
    emit(AppSettingsLoaded(settings: updatedSettings));
  }
}
