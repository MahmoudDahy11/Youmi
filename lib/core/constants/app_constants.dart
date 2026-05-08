class AppSpacing {
  static const double small = 8.0;
  static const double medium = 16.0;
  static const double large = 24.0;
  static const double extraLarge = 32.0;
}

class AppFontSizes {
  static const double small = 12.0;
  static const double body = 14.0;
  static const double medium = 16.0;
  static const double large = 20.0;
  static const double title = 24.0;
}

class AppDurations {
  static const Duration short = Duration(milliseconds: 200);
  static const Duration medium = Duration(milliseconds: 500);
  static const Duration autosaveDelay = Duration(seconds: 2);
}

class ReminderDefaults {
  static const int defaultReminderHour = 21;
  static const int overdueCheckHour = 0;
  static const int weeklyResetDay = 6; // Sunday
}
