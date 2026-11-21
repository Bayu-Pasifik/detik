import 'package:drift/drift.dart' show Value;
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/alarm/alarm_providers.dart';
import '../../core/alarm/alarm_service.dart';
import '../../core/db/database.dart';
import '../../core/l10n.dart';
import '../../core/permissions/permission_service.dart';
import '../../core/providers.dart';
import '../../core/rive/rive_view.dart';
import '../../core/theme/detik_colors.dart';
import '../../core/theme/detik_theme.dart';
import '../../l10n/app_localizations.dart';

List<String> dayNames(AppLocalizations l) =>
    [l.dayMon, l.dayTue, l.dayWed, l.dayThu, l.dayFri, l.daySat, l.daySun];

String repeatText(AppLocalizations l, int mask) {
  if (mask == 0) return l.alarmOnce;
  if (mask == 127) return l.alarmEveryDay;
  if (mask == 31) return l.alarmWeekdays;
  final names = dayNames(l);
  return [for (var i = 0; i < 7; i++) if (mask & (1 << i) != 0) names[i]].join(', ');
}

class AlarmListPage extends ConsumerWidget {
  const AlarmListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l;
    final c = context.colors;
    final alarms = ref.watch(alarmsProvider).value ?? const <Alarm>[];
    final loaded = ref.watch(alarmsProvider).hasValue;
    final now = ref.watch(nowProvider);
    final next = AlarmService.nextOf(alarms, now);
    final perm = ref.watch(permissionStateProvider).value;
    final s = ref.watch(settingsValueProvider);

    return Scaffold(
      floatingActionButton: _SpringFab(
        onPressed: () => context.push('/alarm/edit'),
        label: l.alarmCreate,
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  DetikSpacing.screenMargin, 8, 8, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(l.tabAlarm,
                        style: Theme.of(context).textTheme.titleLarge),
                  ),
                  IconButton(
                    tooltip: l.settings,
                    icon: const Icon(Icons.settings_outlined),
                    onPressed: () => context.push('/settings'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: DetikSpacing.screenMargin, vertical: 4),
              child: Text(
                next == null
                    ? l.alarmNoneActive
                    : l.alarmNextIn(countdownText(l, next.difference(now))),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: next == null ? c.textSecondary : c.accent),
              ),
            ),
            if (perm != null && !perm.allCritical)
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                child: Material(
                  color: c.accentSoft,
                  borderRadius: BorderRadius.circular(DetikRadius.button),
                  child: ListTile(
                    leading: Icon(Icons.warning_amber_rounded, color: c.accent),
                    title: Text(l.permBanner),
                    trailing: TextButton(
                      onPressed: () async {
                        await context.push('/permissions');
                        ref.invalidate(permissionStateProvider);
                      },
                      child: Text(l.permFix),
                    ),
                  ),
                ),
              ),
            Expanded(
              child: !loaded
                  ? const SizedBox.shrink()
                  : alarms.isEmpty
                      ? _EmptyState(reduceMotion: s.reduceMotion)
                      : ListView.separated(
                          padding: const EdgeInsets.fromLTRB(20, 12, 20, 120),
                          itemCount: alarms.length,
                          separatorBuilder: (_, _) => const SizedBox(height: 12),
                          itemBuilder: (context, i) =>
                              _AlarmCard(alarm: alarms[i], use24h: s.use24h),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.reduceMotion});
  final bool reduceMotion;

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 200,
              child: Opacity(
                opacity: 0.8,
                child: RiveView(
                  asset: 'assets/rive/orbit_system.riv',
                  reduceMotion: reduceMotion,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(l.alarmEmptyTitle,
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(l.alarmEmptyBody,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: context.colors.textSecondary)),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () => context.push('/alarm/edit'),
              child: Text(l.alarmCreate),
            ),
          ],
        ),
      ),
    );
  }
}

class _AlarmCard extends ConsumerWidget {
  const _AlarmCard({required this.alarm, required this.use24h});
  final Alarm alarm;
  final bool use24h;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l;
    final c = context.colors;
    final a = alarm;
    return Dismissible(
      key: ValueKey('alarm${a.id}'),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        decoration: BoxDecoration(
          color: c.danger.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(DetikRadius.card),
        ),
        child: Icon(Icons.delete_outline, color: c.danger),
      ),
      onDismissed: (_) async {
        final db = ref.read(databaseProvider);
        final svc = ref.read(alarmServiceProvider);
        await svc.cancel(a.id);
        await db.deleteAlarm(a.id);
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(l.alarmDeleted),
          action: SnackBarAction(
            label: l.undo,
            onPressed: () async {
              await db.saveAlarm(AlarmsCompanion.insert(
                hour: a.hour,
                minute: a.minute,
              ).copyWith(
                id: Value(a.id),
                label: Value(a.label),
                repeatDays: Value(a.repeatDays),
                enabled: Value(a.enabled),
                tone: Value(a.tone),
                vibrate: Value(a.vibrate),
                snoozeMinutes: Value(a.snoozeMinutes),
              ));
              final restored = await db.alarmById(a.id);
              if (restored != null) await svc.schedule(restored);
            },
          ),
        ));
      },
      child: Material(
        color: c.surface,
        borderRadius: BorderRadius.circular(DetikRadius.card),
        child: InkWell(
          borderRadius: BorderRadius.circular(DetikRadius.card),
          onTap: () => context.push('/alarm/edit?id=${a.id}'),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Opacity(
                    opacity: a.enabled ? 1 : 0.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          formatHm(a.hour, a.minute, use24h: use24h),
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          [
                            if (a.label.isNotEmpty) a.label,
                            repeatText(l, a.repeatDays),
                          ].join(' · '),
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                  ),
                ),
                SunMoonToggle(
                  value: a.enabled,
                  semanticLabel:
                      '${l.tabAlarm} ${formatHm(a.hour, a.minute, use24h: use24h)}',
                  onChanged: (v) async {
                    HapticFeedback.lightImpact();
                    final db = ref.read(databaseProvider);
                    await db.patchAlarm(a.id, AlarmsCompanion(enabled: Value(v)));
                    final updated = await db.alarmById(a.id);
                    final svc = ref.read(alarmServiceProvider);
                    if (updated == null) return;
                    await svc.schedule(updated);
                    if (v && context.mounted) {
                      final t = AlarmService.nextOf([updated], DateTime.now());
                      if (t != null) {
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(SnackBar(
                              content: Text(l.alarmSetIn(countdownText(
                                  l, t.difference(DateTime.now()))))));
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Toggle pil dengan knob matahari/bulan dan pegas saat berpindah.
/// (Pengganti Flutter sampai file Rive `alarm_toggle` tersedia.)
class SunMoonToggle extends StatelessWidget {
  const SunMoonToggle({
    super.key,
    required this.value,
    required this.onChanged,
    this.semanticLabel,
  });
  final bool value;
  final ValueChanged<bool> onChanged;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Semantics(
      toggled: value,
      label: semanticLabel,
      button: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => onChanged(!value),
        child: SizedBox(
          width: 64,
          height: 48,
          child: Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOut,
              width: 60,
              height: 32,
              decoration: BoxDecoration(
                color: value ? c.accentSoft : c.surfaceHigh,
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: value ? c.accent : c.outline),
              ),
              child: AnimatedAlign(
                duration: const Duration(milliseconds: 380),
                curve: Curves.elasticOut,
                alignment: value ? Alignment.centerRight : Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: value ? c.accent : c.textSecondary,
                    ),
                    child: Icon(
                      value ? Icons.wb_sunny : Icons.dark_mode,
                      size: 14,
                      color: c.bg,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SpringFab extends StatefulWidget {
  const _SpringFab({required this.onPressed, required this.label});
  final VoidCallback onPressed;
  final String label;

  @override
  State<_SpringFab> createState() => _SpringFabState();
}

class _SpringFabState extends State<_SpringFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 500))
    ..forward();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: CurvedAnimation(parent: _c, curve: Curves.elasticOut),
      child: FloatingActionButton(
        tooltip: widget.label,
        onPressed: widget.onPressed,
        child: const Icon(Icons.add),
      ),
    );
  }
}
