import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import 'alarm/alarm_edit_page.dart';
import 'alarm/alarm_list_page.dart';
import 'alarm/ring_page.dart';
import 'clock/clock_page.dart';
import 'clock/nightstand_page.dart';
import 'settings/permissions_page.dart';
import 'settings/settings_page.dart';
import 'shell/home_shell.dart';
import 'stopwatch/stopwatch_page.dart';
import 'timer/timer_page.dart';

CustomTransitionPage<void> _fade(GoRouterState s, Widget child) =>
    CustomTransitionPage<void>(
      key: s.pageKey,
      child: child,
      transitionDuration: const Duration(milliseconds: 220),
      transitionsBuilder: (_, a, _, c) => FadeTransition(
          opacity: CurvedAnimation(parent: a, curve: Curves.easeOut), child: c),
    );

CustomTransitionPage<void> _slideUp(GoRouterState s, Widget child) =>
    CustomTransitionPage<void>(
      key: s.pageKey,
      child: child,
      transitionDuration: const Duration(milliseconds: 280),
      transitionsBuilder: (_, a, _, c) => SlideTransition(
        position: Tween(begin: const Offset(0, 0.08), end: Offset.zero)
            .animate(CurvedAnimation(parent: a, curve: Curves.easeOutCubic)),
        child: FadeTransition(opacity: a, child: c),
      ),
    );

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/clock',
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => HomeShell(shell: shell),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/alarm',
              pageBuilder: (c, s) => _fade(s, const AlarmListPage()),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/clock',
              pageBuilder: (c, s) => _fade(s, const ClockPage()),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/timer',
              pageBuilder: (c, s) => _fade(s, const TimerPage()),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/stopwatch',
              pageBuilder: (c, s) => _fade(s, const StopwatchPage()),
            ),
          ]),
        ],
      ),
      GoRoute(
        path: '/alarm/edit',
        pageBuilder: (c, s) => _slideUp(
            s, AlarmEditPage(alarmId: int.tryParse(s.uri.queryParameters['id'] ?? ''))),
      ),
      GoRoute(
        path: '/settings',
        pageBuilder: (c, s) => _slideUp(s, const SettingsPage()),
      ),
      GoRoute(
        path: '/permissions',
        pageBuilder: (c, s) => _slideUp(s, const PermissionsPage()),
      ),
      GoRoute(
        path: '/nightstand',
        pageBuilder: (c, s) => _fade(s, const NightstandPage()),
      ),
      GoRoute(
        path: '/ring',
        pageBuilder: (c, s) => _fade(
            s, RingPage(pluginId: int.tryParse(s.uri.queryParameters['id'] ?? '') ?? 0)),
      ),
    ],
  );
});
