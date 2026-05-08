import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/notes/presentation/screens/notes_screen.dart';
import '../../features/launch/presentation/screens/app_launch_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../features/tasks/presentation/screens/today_screen.dart';
import '../../features/tasks/presentation/screens/weekly_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/launch',
  routes: [
    GoRoute(
      path: '/launch',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: AppLaunchScreen(),
      ),
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return ScaffoldWithNavBar(child: child);
      },
      routes: [
        GoRoute(
          path: '/today',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: TodayScreen(),
          ),
        ),
        GoRoute(
          path: '/weekly',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: WeeklyScreen(),
          ),
        ),
        GoRoute(
          path: '/notes',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: NotesScreen(),
          ),
        ),
        GoRoute(
          path: '/settings',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: SettingsScreen(),
          ),
        ),
      ],
    ),
  ],
);

class ScaffoldWithNavBar extends StatelessWidget {
  final Widget child;

  const ScaffoldWithNavBar({super.key, required this.child});

  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/today')) return 0;
    if (location.startsWith('/weekly')) return 1;
    if (location.startsWith('/notes')) return 2;
    if (location.startsWith('/settings')) return 3;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/today');
        break;
      case 1:
        context.go('/weekly');
        break;
      case 2:
        context.go('/notes');
        break;
      case 3:
        context.go('/settings');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _calculateSelectedIndex(context);

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) => _onItemTapped(index, context),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.today_outlined),
            selectedIcon: Icon(Icons.today),
            label: 'Today',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_view_week_outlined),
            selectedIcon: Icon(Icons.calendar_view_week),
            label: 'Weekly',
          ),
          NavigationDestination(
            icon: Icon(Icons.note_outlined),
            selectedIcon: Icon(Icons.note),
            label: 'Notes',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
