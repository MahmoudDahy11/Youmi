import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

import '../../core/di/injection.dart';
import '../../features/tasks/domain/usecases/handle_overdue_tasks.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  Timer? _dailyCheckTimer;
  DateTime _lastOverdueCheckDate = DateTime.now();

  Future<void> initialize() async {
    // Initialize timezone data
    tzdata.initializeTimeZones();

    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const linuxSettings = LinuxInitializationSettings(
      defaultActionName: 'Open notification',
    );
    const initSettings = InitializationSettings(
      android: androidSettings,
      linux: linuxSettings,
    );

    await _plugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTap,
    );

    // Run overdue check at startup
    await _performOverdueCheckIfNeeded();

    // Start periodic timer to check overdue every 30 minutes
    _startPeriodicOverdueCheck();
  }

  Future<void> scheduleDailyEveningReminder(int hour) async {
    // zonedSchedule is only available on Android
    try {
      // Cancel previous reminder
      await _plugin.cancel(100);

      final now = DateTime.now();
      var scheduledDate = DateTime(now.year, now.month, now.day, hour, 0, 0);

      // If the scheduled time has already passed today, schedule for tomorrow
      if (scheduledDate.isBefore(now)) {
        scheduledDate = scheduledDate.add(const Duration(days: 1));
      }

      await _plugin.zonedSchedule(
        100,
        'Evening Review',
        'Time to review your tasks for today and plan tomorrow.',
        tz.TZDateTime.from(scheduledDate, tz.local),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'evening_review_channel',
            'Evening Review',
            channelDescription: 'Daily evening task review reminder',
            importance: Importance.high,
            priority: Priority.high,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    } catch (e) {
      debugPrint('Scheduled notification not available on this platform: $e');
    }
  }

  Future<void> _performOverdueCheckIfNeeded() async {
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);

    if (_lastOverdueCheckDate.isBefore(todayDate)) {
      try {
        final handleOverdue = getIt<HandleOverdueTasksUseCase>();
        await handleOverdue();
      } catch (e) {
        debugPrint('Overdue check failed: $e');
      }
      _lastOverdueCheckDate = todayDate;
    }
  }

  void _startPeriodicOverdueCheck() {
    _dailyCheckTimer?.cancel();
    _dailyCheckTimer = Timer.periodic(
      const Duration(minutes: 30),
      (_) => _performOverdueCheckIfNeeded(),
    );
  }

  void _onNotificationTap(NotificationResponse response) {
    // Future feature: navigate to today screen when tapping notification
  }

  void dispose() {
    _dailyCheckTimer?.cancel();
  }
}
