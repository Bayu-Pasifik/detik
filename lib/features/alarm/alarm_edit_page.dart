import 'package:drift/drift.dart' show Value;
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/alarm/alarm_providers.dart';
import '../../core/alarm/alarm_service.dart';
import '../../core/db/database.dart';
import '../../core/l10n.dart';
import '../../core/providers.dart';
import '../../core/theme/detik_colors.dart';
import '../settings/tone_picker.dart';
import 'alarm_list_page.dart' show dayNames;

class AlarmEditPage extends ConsumerStatefulWidget {
  const AlarmEditPage({super.key, this.alarmId});
  final int? alarmId;

  @override
  ConsumerState<AlarmEditPage> createState() => _AlarmEditPageState();
}

class _AlarmEditPageState extends ConsumerState<AlarmEditPage> {
  late int _hour;
  late int _minute;
  int _repeat = 0;
  String _tone = 'assets/audio/pagi.wav';
  bool _vibrate = true;
  int _snooze = 10;
  final _label = TextEditingController();
  bool _ready = false;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now().add(const Duration(minutes: 1));
    _hour = now.hour;
    _minute = now.minute;
    _load();
  }

  Future<void> _load() async {
    final db = ref.read(databaseProvider);
    final s = ref.read(settingsValueProvider);
    final id = widget.alarmId;
    if (id != null) {
      final a = await db.alarmById(id);
      if (a != null) {
        _hour = a.hour;
        _minute = a.minute;
        _repeat = a.repeatDays;
        _tone = a.tone;
        _vibrate = a.vibrate;
        _snooze = a.snoozeMinutes;
        _label.text = a.label;
      }
    } else {
      _tone = s.defaultTone;
      _vibrate = s.defaultVibrate;
      _snooze = s.snoozeMinutes;
    }
    if (mounted) setState(() => _ready = true);
  }

  @override
  void dispose() {
    _label.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final db = ref.read(databaseProvider);
    final l = context.l;
    final companion = AlarmsCompanion(
      id: widget.alarmId == null ? const Value.absent() : Value(widget.alarmId!),
      hour: Value(_hour),
      minute: Value(_minute),
      label: Value(_label.text.trim()),
      repeatDays: Value(_repeat),
      enabled: const Value(true),
      tone: Value(_tone),
      vibrate: Value(_vibrate),
      snoozeMinutes: Value(_snooze),
    );
    final id = await db.saveAlarm(companion);
    final saved = await db.alarmById(id);
    if (saved != null) await ref.read(alarmServiceProvider).schedule(saved);
    if (!mounted) return;
    final t = AlarmService.nextOf([saved!], DateTime.now())!;
    final msg = l.alarmSetIn(countdownText(l, t.difference(DateTime.now())));
    final messenger = ScaffoldMessenger.of(context);
    context.pop();
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final c = context.colors;
    final names = dayNames(l);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.alarmId == null ? l.alarmNew : l.alarmEdit),
        leading: IconButton(
          icon: const Icon(Icons.close),
          tooltip: l.cancel,
          onPressed: () => context.pop(),
        ),
        actions: [
          TextButton(onPressed: _ready ? _save : null, child: Text(l.save)),
        ],
      ),
      body: !_ready
          ? const SizedBox.shrink()
          : ListView(
              padding: const EdgeInsets.all(20),
              children: [
                SizedBox(
                  height: 180,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      NumberWheel(
                        count: 24,
                        value: _hour,
                        semantic: l.timerHours,
                        onChanged: (v) => setState(() => _hour = v),
                      ),
                      Text(':',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(color: c.accent)),
                      NumberWheel(
                        count: 60,
                        value: _minute,
                        semantic: l.timerMinutes,
                        onChanged: (v) => setState(() => _minute = v),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _label,
                  decoration: InputDecoration(
                    labelText: l.alarmLabel,
                    filled: true,
                    fillColor: c.surface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(l.alarmRepeat, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (var i = 0; i < 7; i++)
                      FilterChip(
                        label: Text(names[i]),
                        selected: _repeat & (1 << i) != 0,
                        showCheckmark: false,
                        selectedColor: c.accentSoft,
                        side: BorderSide(
                            color: _repeat & (1 << i) != 0 ? c.accent : c.outline),
                        shape: const StadiumBorder(),
                        onSelected: (v) {
                          HapticFeedback.selectionClick();
                          setState(() => _repeat ^= (1 << i));
                        },
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l.alarmTone),
                  subtitle: Text(toneName(l, _tone)),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () async {
                    final t = await pickTone(context, _tone);
                    if (t != null) setState(() => _tone = t);
                  },
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l.alarmVibrate),
                  value: _vibrate,
                  onChanged: (v) => setState(() => _vibrate = v),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l.alarmSnooze),
                  trailing: DropdownButton<int>(
                    value: _snooze,
                    underline: const SizedBox.shrink(),
                    items: [
                      for (final m in const [5, 10, 15, 20, 30])
                        DropdownMenuItem(
                            value: m, child: Text(l.alarmSnoozeMinutes('$m'))),
                    ],
                    onChanged: (v) => setState(() => _snooze = v ?? 10),
                  ),
                ),
              ],
            ),
    );
  }
}

/// Roda angka dengan snap dan haptik ringan tiap langkah.
class NumberWheel extends StatefulWidget {
  const NumberWheel({
    super.key,
    required this.count,
    required this.value,
    required this.onChanged,
    required this.semantic,
  });
  final int count;
  final int value;
  final ValueChanged<int> onChanged;
  final String semantic;

  @override
  State<NumberWheel> createState() => _NumberWheelState();
}

class _NumberWheelState extends State<NumberWheel> {
  late final FixedExtentScrollController _c =
      FixedExtentScrollController(initialItem: widget.value);

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Semantics(
      label: widget.semantic,
      value: '${widget.value}',
      increasedValue: '${(widget.value + 1) % widget.count}',
      decreasedValue: '${(widget.value - 1) % widget.count}',
      onIncrease: () => _c.animateToItem(widget.value + 1,
          duration: const Duration(milliseconds: 200), curve: Curves.easeOut),
      onDecrease: () => _c.animateToItem(widget.value - 1,
          duration: const Duration(milliseconds: 200), curve: Curves.easeOut),
      child: SizedBox(
        width: 96,
        child: ListWheelScrollView.useDelegate(
          controller: _c,
          itemExtent: 64,
          perspective: 0.003,
          diameterRatio: 1.8,
          physics: const FixedExtentScrollPhysics(),
          onSelectedItemChanged: (i) {
            HapticFeedback.selectionClick();
            widget.onChanged(i % widget.count);
          },
          childDelegate: ListWheelChildLoopingListDelegate(
            children: [
              for (var i = 0; i < widget.count; i++)
                Center(
                  child: Text(
                    two(i),
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        color: i == widget.value ? c.textPrimary : c.textSecondary),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
