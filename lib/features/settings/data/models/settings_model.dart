import 'package:isar/isar.dart';

part 'settings_model.g.dart';

@Collection()
class SettingsModel {
  Id id = Isar.autoIncrement;

  late int reminderHour;

  late String themeMode;

  late int weeklyResetDay;
}
