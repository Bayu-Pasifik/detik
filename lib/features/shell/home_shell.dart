import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/l10n.dart';
import '../../core/theme/detik_colors.dart';

class HomeShell extends StatelessWidget {
  const HomeShell({super.key, required this.shell});
  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final c = context.colors;
    return Scaffold(
      body: shell,
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: c.surface,
          indicatorColor: c.accentSoft,
          indicatorShape: const StadiumBorder(),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          iconTheme: WidgetStateProperty.resolveWith((s) => IconThemeData(
              color: s.contains(WidgetState.selected) ? c.accent : c.textSecondary)),
          labelTextStyle: WidgetStateProperty.resolveWith((s) => TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: s.contains(WidgetState.selected) ? c.accent : c.textSecondary)),
        ),
        child: NavigationBar(
          selectedIndex: shell.currentIndex,
          animationDuration: const Duration(milliseconds: 250),
          onDestinationSelected: (i) {
            HapticFeedback.selectionClick();
            shell.goBranch(i, initialLocation: i == shell.currentIndex);
          },
          destinations: [
            NavigationDestination(
                icon: const Icon(Icons.alarm_outlined),
                selectedIcon: const Icon(Icons.alarm),
                label: l.tabAlarm),
            NavigationDestination(
                icon: const Icon(Icons.public_outlined),
                selectedIcon: const Icon(Icons.public),
                label: l.tabClock),
            NavigationDestination(
                icon: const Icon(Icons.hourglass_empty_outlined),
                selectedIcon: const Icon(Icons.hourglass_bottom),
                label: l.tabTimer),
            NavigationDestination(
                icon: const Icon(Icons.timer_outlined),
                selectedIcon: const Icon(Icons.timer),
                label: l.tabStopwatch),
          ],
        ),
      ),
    );
  }
}
