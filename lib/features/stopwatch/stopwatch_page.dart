import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/l10n.dart';
import '../../core/theme/detik_colors.dart';
import '../../core/theme/detik_theme.dart';

String formatStopwatch(Duration d) {
  final cs = (d.inMilliseconds ~/ 10) % 100;
  final s = d.inSeconds % 60;
  final m = d.inMinutes % 60;
  final h = d.inHours;
  final base = '${two(m)}:${two(s)}.${two(cs)}';
  return h > 0 ? '$h:$base' : base;
}

/// Stopwatch dengan `Stopwatch` (jam monoton): tetap akurat walau app di
/// latar atau layar diputar; tampilan diperbarui tiap frame (~10 ms).
class StopwatchPage extends StatefulWidget {
  const StopwatchPage({super.key});

  @override
  State<StopwatchPage> createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage>
    with SingleTickerProviderStateMixin {
  final _sw = Stopwatch();
  late final Ticker _ticker;
  final _elapsed = ValueNotifier<Duration>(Duration.zero);
  final List<Duration> _laps = []; // total saat lap ditekan

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((_) => _elapsed.value = _sw.elapsed);
  }

  @override
  void dispose() {
    _ticker.dispose();
    _elapsed.dispose();
    super.dispose();
  }

  void _toggle() {
    HapticFeedback.lightImpact();
    setState(() {
      if (_sw.isRunning) {
        _sw.stop();
        _ticker.stop();
        _elapsed.value = _sw.elapsed;
      } else {
        _sw.start();
        _ticker.start();
      }
    });
  }

  void _lapOrReset() {
    HapticFeedback.selectionClick();
    setState(() {
      if (_sw.isRunning) {
        _laps.insert(0, _sw.elapsed);
      } else {
        _sw.reset();
        _laps.clear();
        _elapsed.value = Duration.zero;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final c = context.colors;
    final running = _sw.isRunning;
    final started = _sw.elapsed > Duration.zero;
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: OrientationBuilder(builder: (context, orientation) {
          final display = Center(
            child: ValueListenableBuilder<Duration>(
              valueListenable: _elapsed,
              builder: (_, d, _) => FittedBox(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Semantics(
                    label: formatStopwatch(d),
                    child: Text(
                      formatStopwatch(d),
                      style: TextStyle(
                        fontSize: 72,
                        fontWeight: FontWeight.w300,
                        color: c.textPrimary,
                        fontFeatures: DetikTheme.tabular,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
          final controls = Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(
                onPressed: started ? _lapOrReset : null,
                child: Text(running ? l.stopwatchLap : l.timerReset),
              ),
              FilledButton(
                onPressed: _toggle,
                child: Text(running ? l.timerPause : (started ? l.timerResume : l.timerStart)),
              ),
            ],
          );
          final laps = _laps.isEmpty
              ? Center(
                  child: Text(l.stopwatchNoLaps,
                      style: Theme.of(context).textTheme.labelSmall))
              : ListView.builder(
                  itemCount: _laps.length,
                  itemBuilder: (_, i) {
                    final n = _laps.length - i;
                    final prev = i + 1 < _laps.length ? _laps[i + 1] : Duration.zero;
                    return ListTile(
                      title: Text(l.stopwatchLapN('$n')),
                      subtitle: Text('+${formatStopwatch(_laps[i] - prev)}'),
                      trailing: Text(formatStopwatch(_laps[i]),
                          style: Theme.of(context).textTheme.titleMedium),
                    );
                  },
                );
          if (orientation == Orientation.landscape) {
            return Row(children: [
              Expanded(child: Column(children: [Expanded(child: display), controls, const SizedBox(height: 16)])),
              Expanded(child: laps),
            ]);
          }
          return Column(children: [
            Expanded(flex: 2, child: display),
            controls,
            const SizedBox(height: 16),
            Expanded(flex: 3, child: laps),
          ]);
        }),
      ),
    );
  }
}
