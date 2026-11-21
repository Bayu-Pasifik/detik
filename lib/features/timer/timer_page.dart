import 'dart:math' as math;

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/db/database.dart';
import '../../core/l10n.dart';
import '../../core/providers.dart';
import '../../core/theme/detik_colors.dart';
import '../../core/theme/detik_theme.dart';
import '../alarm/alarm_edit_page.dart' show NumberWheel;
import 'timer_providers.dart';

String formatMs(int ms) {
  final totalSec = (ms / 1000).ceil().clamp(0, 359999);
  final h = totalSec ~/ 3600;
  final m = (totalSec % 3600) ~/ 60;
  final s = totalSec % 60;
  return h > 0 ? '${two(h)}:${two(m)}:${two(s)}' : '${two(m)}:${two(s)}';
}

class TimerPage extends ConsumerWidget {
  const TimerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l;
    final timers = ref.watch(timersProvider).value ?? const <TimerRow>[];
    ref.watch(nowProvider); // rebuild tiap detik untuk hitung mundur

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: l.timerNew,
        onPressed: () => _newTimer(context, ref),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Text(l.tabTimer,
                  style: Theme.of(context).textTheme.titleLarge),
            ),
            Expanded(
              child: timers.isEmpty
                  ? Center(
                      child: Text(l.timerEmpty,
                          style: Theme.of(context).textTheme.labelSmall))
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 120),
                      itemCount: timers.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 12),
                      itemBuilder: (_, i) => _TimerCard(timer: timers[i]),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _newTimer(BuildContext context, WidgetRef ref) async {
    final l = context.l;
    var h = 0, m = 5, s = 0;
    final label = TextEditingController();
    final ok = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.fromLTRB(
            20, 20, 20, 20 + MediaQuery.viewInsetsOf(ctx).bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(l.timerNew, style: Theme.of(ctx).textTheme.titleLarge),
            SizedBox(
              height: 170,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  NumberWheel(
                      count: 24, value: h, semantic: l.timerHours, onChanged: (v) => h = v),
                  NumberWheel(
                      count: 60, value: m, semantic: l.timerMinutes, onChanged: (v) => m = v),
                  NumberWheel(
                      count: 60, value: s, semantic: l.timerSeconds, onChanged: (v) => s = v),
                ],
              ),
            ),
            TextField(
              controller: label,
              decoration: InputDecoration(labelText: l.timerLabelHint),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => Navigator.of(ctx).pop(true),
                child: Text(l.timerStart),
              ),
            ),
          ],
        ),
      ),
    );
    if (ok != true) return;
    final dur = ((h * 3600) + (m * 60) + s) * 1000;
    if (dur == 0) return;
    final svc = ref.read(timerServiceProvider);
    final id = await svc.create(dur, label.text.trim());
    final row = (await ref.read(databaseProvider).select(ref.read(databaseProvider).timers).get())
        .firstWhere((t) => t.id == id);
    await svc.start(row, title: l.tabTimer, running: l.timerRunningNotif);
  }
}

class _TimerCard extends ConsumerWidget {
  const _TimerCard({required this.timer});
  final TimerRow timer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l;
    final c = context.colors;
    final svc = ref.read(timerServiceProvider);
    final nowMs = DateTime.now().millisecondsSinceEpoch;
    final running = TimerService.isRunning(timer);
    final rem = TimerService.remainingMs(timer, nowMs).clamp(0, timer.durationMs);
    final progress = timer.durationMs == 0 ? 0.0 : rem / timer.durationMs;

    return Dismissible(
      key: ValueKey('timer${timer.id}'),
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
      onDismissed: (_) => svc.delete(timer),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: c.surface,
          borderRadius: BorderRadius.circular(DetikRadius.card),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 72,
              height: 72,
              child: CustomPaint(
                painter: _RingPainter(progress, c.accent, c.outline),
                child: Center(
                  child: Icon(running ? Icons.hourglass_top : Icons.hourglass_empty,
                      color: c.textSecondary, size: 22),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(formatMs(rem),
                      style: Theme.of(context).textTheme.displayMedium),
                  if (timer.label.isNotEmpty)
                    Text(timer.label, style: Theme.of(context).textTheme.labelSmall),
                ],
              ),
            ),
            IconButton(
              tooltip: l.timerReset,
              icon: const Icon(Icons.restart_alt),
              onPressed: () => svc.reset(timer),
            ),
            IconButton.filled(
              tooltip: running ? l.timerPause : l.timerStart,
              icon: Icon(running ? Icons.pause : Icons.play_arrow),
              onPressed: () {
                HapticFeedback.lightImpact();
                if (running) {
                  svc.pause(timer);
                } else {
                  svc.start(timer,
                      title: l.tabTimer, running: l.timerRunningNotif);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter(this.progress, this.color, this.track);
  final double progress;
  final Color color;
  final Color track;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final r = rect.deflate(5);
    final base = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(r, 0, math.pi * 2, false, base..color = track);
    canvas.drawArc(r, -math.pi / 2, math.pi * 2 * progress, false, base..color = color);
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.progress != progress || old.color != color;
}
