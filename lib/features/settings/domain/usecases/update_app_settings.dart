import '../entities/app_settings.dart';
import '../repositories/settings_repository.dart';

class UpdateAppSettingsUseCase {
  final SettingsRepository repository;

  UpdateAppSettingsUseCase(this.repository);

  Future<void> call(AppSettings settings) {
    return repository.updateSettings(settings);
  }
}
