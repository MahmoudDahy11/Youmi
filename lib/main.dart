// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/injection.dart';
import 'core/router/app_router.dart';
import 'core/services/notification_service.dart';
import 'core/theme/app_theme.dart';
import 'features/settings/domain/usecases/get_app_settings.dart';
import 'features/settings/domain/usecases/update_app_settings.dart';
import 'features/settings/presentation/cubit/settings_cubit.dart';

final NotificationService notificationService = NotificationService();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();

  await notificationService.initialize();

  final getAppSettingsUseCase = getIt<GetAppSettingsUseCase>();
  final updateAppSettingsUseCase = getIt<UpdateAppSettingsUseCase>();

  // Schedule the daily reminder based on current settings
  final settings = await getAppSettingsUseCase();
  await notificationService.scheduleDailyEveningReminder(settings.reminderHour);

  runApp(
    Youmi(
      getAppSettingsUseCase: getAppSettingsUseCase,
      updateAppSettingsUseCase: updateAppSettingsUseCase,
    ),
  );
}

class Youmi extends StatelessWidget {
  final GetAppSettingsUseCase getAppSettingsUseCase;
  final UpdateAppSettingsUseCase updateAppSettingsUseCase;

  const Youmi({
    super.key,
    required this.getAppSettingsUseCase,
    required this.updateAppSettingsUseCase,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => SettingsCubit(
            getAppSettingsUseCase: getAppSettingsUseCase,
            updateAppSettingsUseCase: updateAppSettingsUseCase,
          )..loadSettings(),
        ),
      ],
      child: BlocBuilder<SettingsCubit, AppSettingsState>(
        builder: (context, state) {
          ThemeMode themeMode = ThemeMode.system;
          if (state is AppSettingsLoaded) {
            themeMode = state.settings.themeMode;
          }

          return MaterialApp.router(
            title: 'Youmi',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
            routerConfig: appRouter,
          );
        },
      ),
    );
  }
}
