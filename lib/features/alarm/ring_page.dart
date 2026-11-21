import 'package:alarm/alarm.dart' as plugin;
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/alarm/alarm_providers.dart';
import '../../core/alarm/alarm_service.dart';
import '../../core/l10n.dart';
import '../../core/orbit/orbit_painter.dart';
import '../../core/providers.dart';
import '../../core/theme/detik_colors.dart';
import '../../core/widgets/flip_clock.dart';
import '../timer/timer_providers.dart';

/// Layar alarm/timer berbunyi: penuh, orbit 3x + denyut, flip clock besar,
/// geser untuk mematikan, tombol tunda.
class RingPage extends ConsumerStatefulWidget {
  const RingPage({super.key, required this.pluginId});
  final int pluginId;

  @override
  ConsumerState<RingPage> createState() => _RingPageState();
}

class _RingPageState extends ConsumerState<RingPage> {
  String _title = '';
  int _snooze = 10;
  bool _finished = false;

  bool get _isTimer => isTimerId(widget.pluginId);

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final db = ref.read(databaseProvider);
    if (_isTimer) {
      final rows = await db.select(db.timers).get();
      final t = rows.where((r) => r.id == timerIdOf(widget.pluginId));
      _title = t.isEmpty ? '' : t.first.label;
    } else {
      final a = await db.alarmById(alarmIdOf(widget.pluginId));
      _title = a?.label ?? '';
      _snooze = a?.snoozeMinutes ?? 10;
    }
    if (mounted) setState(() {});
  }

  Future<void> _stop() async {
    if (_finished) return;
    _finished = true;
    HapticFeedback.mediumImpact();
    try {
      if (_isTimer) {
        await plugin.Alarm.stop(widget.pluginId);
        await ref.read(timerServiceProvider).onFinished(timerIdOf(widget.pluginId));
      } else {
        await ref.read(alarmServiceProvider).dismiss(widget.pluginId);
      }
    } finally {
      _leave();
    }
  }

  Future<void> _snoozeNow() async {
    if (_finished) return;
    _finished = true;
    final svc = ref.read(alarmServiceProvider);
    // dismiss dulu (menonaktifkan alarm sekali / mengisi ulang jadwal), lalu
    // pasang snooze supaya tidak ikut terhapus.
    await svc.dismiss(widget.pluginId);
    await svc.snooze(alarmIdOf(widget.pluginId), _snooze);
    _leave();
  }

  void _leave() {
    ref.read(ringingProvider.notifier).set(false);
    if (mounted) context.go('/alarm');
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final c = context.colors;
    final s = ref.watch(settingsValueProvider);
    final now = ref.watch(nowProvider);
    final night = ref.watch(nightFactorProvider);
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            OrbitBackground(
              night: night,
              accent: c.accent,
              fast: true,
              reduceMotion: s.reduceMotion,
              center: const Offset(0.5, 0.5),
            ),
            SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 48),
                  Text(_isTimer ? l.timerRinging : l.alarmRinging,
                      style: Theme.of(context).textTheme.titleMedium),
                  if (_title.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(_title,
                          style: Theme.of(context).textTheme.titleLarge),
                    ),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: FlipClock(
                      time: now,
                      use24h: s.use24h,
                      digitHeight: 110,
                      showSeconds: false,
                      reduceMotion: s.reduceMotion,
                    ),
                  ),
                  const Spacer(),
                  if (!_isTimer)
                    OutlinedButton(
                      onPressed: _snoozeNow,
                      child: Text(l.alarmSnoozeFor('$_snooze')),
                    ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: SlideToStop(label: l.alarmSlideStop, onDone: _stop),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Geser untuk mematikan. Alternatif aksesibilitas: ketuk dua kali
/// (aksi TalkBack) memicu aksi yang sama.
class SlideToStop extends StatefulWidget {
  const SlideToStop({super.key, required this.label, required this.onDone});
  final String label;
  final VoidCallback onDone;

  @override
  State<SlideToStop> createState() => _SlideToStopState();
}

class _SlideToStopState extends State<SlideToStop> {
  double _x = 0;
  static const _knob = 56.0;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Semantics(
      button: true,
      label: widget.label,
      onTap: widget.onDone,
      child: LayoutBuilder(builder: (context, box) {
        final max = box.maxWidth - _knob - 8;
        return Container(
          height: _knob + 8,
          decoration: BoxDecoration(
            color: c.surfaceHigh,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Center(
                child: Opacity(
                  opacity: (1 - _x / (max == 0 ? 1 : max)).clamp(0.0, 1.0),
                  child: Text(widget.label,
                      style: Theme.of(context).textTheme.titleMedium),
                ),
              ),
              Positioned(
                left: 4 + _x,
                child: GestureDetector(
                  onHorizontalDragUpdate: (d) =>
                      setState(() => _x = (_x + d.delta.dx).clamp(0.0, max)),
                  onHorizontalDragEnd: (_) {
                    if (_x > max * 0.85) {
                      widget.onDone();
                    } else {
                      setState(() => _x = 0);
                    }
                  },
                  child: Container(
                    width: _knob,
                    height: _knob,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: c.danger),
                    child: Icon(Icons.alarm_off, color: c.bg),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
