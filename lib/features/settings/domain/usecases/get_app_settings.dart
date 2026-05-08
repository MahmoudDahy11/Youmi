import '../entities/app_settings.dart';
import '../repositories/settings_repository.dart';

class GetAppSettingsUseCase {
  final SettingsRepository repository;

  GetAppSettingsUseCase(this.repository);

  Future<AppSettings> call() {
    return repository.getSettings();
  }
}
