import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../core/db/database.dart';
import '../../core/l10n.dart';
import '../../core/orbit/orbit_painter.dart';
import '../../core/providers.dart';
import '../../core/theme/detik_colors.dart';
import '../../core/theme/detik_theme.dart';
import '../../core/widgets/flip_clock.dart';
import 'add_city_sheet.dart';

final worldClocksProvider = StreamProvider<List<WorldClock>>(
    (ref) => ref.watch(databaseProvider).watchWorldClocks());

class ClockPage extends ConsumerStatefulWidget {
  const ClockPage({super.key});

  @override
  ConsumerState<ClockPage> createState() => _ClockPageState();
}

class _ClockPageState extends ConsumerState<ClockPage> {
  final _stackKey = GlobalKey();
  final _clockKey = GlobalKey();
  Rect? _avoid;

  void _measure() {
    final stack = _stackKey.currentContext?.findRenderObject() as RenderBox?;
    final clock = _clockKey.currentContext?.findRenderObject() as RenderBox?;
    if (stack == null || clock == null || !clock.hasSize) return;
    final r = clock.localToGlobal(Offset.zero, ancestor: stack) & clock.size;
    if (r != _avoid) setState(() => _avoid = r);
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final l = context.l;
    final s = ref.watch(settingsValueProvider);
    final now = ref.watch(nowProvider);
    final night = ref.watch(nightFactorProvider);
    WidgetsBinding.instance.addPostFrameCallback((_) => _measure());

    return Scaffold(
      body: Stack(
        key: _stackKey,
        children: [
          Positioned.fill(
            child: OrbitBackground(
              night: night,
              accent: c.accent,
              avoid: _avoid,
              reduceMotion: s.reduceMotion,
              center: const Offset(0.5, 0.52),
            ),
          ),
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                      DetikSpacing.screenMargin, 8, 8, 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(_dateText(context, now),
                            style: Theme.of(context).textTheme.titleMedium),
                      ),
                      IconButton(
                        tooltip: l.nightstand,
                        icon: const Icon(Icons.nightlight_outlined),
                        onPressed: () => context.push('/nightstand'),
                      ),
                      IconButton(
                        tooltip: l.settings,
                        icon: const Icon(Icons.settings_outlined),
                        onPressed: () => context.push('/settings'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  key: _clockKey,
                  padding: const EdgeInsets.symmetric(
                      horizontal: DetikSpacing.screenMargin),
                  child: FlipClock(
                    time: now,
                    use24h: s.use24h,
                    reduceMotion: s.reduceMotion,
                  ),
                ),
                const SizedBox(height: 24),
                const Expanded(child: _WorldClockList()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _dateText(BuildContext context, DateTime now) {
    final locale = Localizations.localeOf(context).languageCode;
    final days = locale == 'id'
        ? ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu']
        : ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    final months = locale == 'id'
        ? ['Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun', 'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des']
        : ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${days[now.weekday - 1]}, ${now.day} ${months[now.month - 1]} ${now.year}';
  }
}

class _WorldClockList extends ConsumerWidget {
  const _WorldClockList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l;
    final c = context.colors;
    final items = ref.watch(worldClocksProvider).value ?? const [];
    final now = ref.watch(nowProvider);
    final use24h = ref.watch(settingsValueProvider).use24h;
    final localOffset = now.timeZoneOffset;

    return Container(
      decoration: BoxDecoration(
        color: c.surface.withValues(alpha: 0.55),
        borderRadius: const BorderRadius.vertical(
            top: Radius.circular(DetikRadius.sheet)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 12, 0),
            child: Row(
              children: [
                Expanded(
                    child: Text(l.tabClock,
                        style: Theme.of(context).textTheme.titleMedium)),
                TextButton.icon(
                  onPressed: () => showAddCitySheet(context, ref),
                  icon: const Icon(Icons.add),
                  label: Text(l.clockAddCity),
                ),
              ],
            ),
          ),
          Expanded(
            child: items.isEmpty
                ? Center(
                    child: Text(l.clockNoCities,
                        style: Theme.of(context).textTheme.labelSmall))
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 16),
                    itemCount: items.length,
                    itemBuilder: (context, i) {
                      final w = items[i];
                      final loc = tz.getLocation(w.tzName);
                      final t = tz.TZDateTime.from(now, loc);
                      final diffMin =
                          t.timeZoneOffset.inMinutes - localOffset.inMinutes;
                      final isDay = t.hour >= 6 && t.hour < 18;
                      return Dismissible(
                        key: ValueKey('wc${w.id}'),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 24),
                          color: c.danger.withValues(alpha: 0.2),
                          child: Icon(Icons.delete_outline, color: c.danger),
                        ),
                        onDismissed: (_) =>
                            ref.read(databaseProvider).deleteWorldClock(w.id),
                        child: ListTile(
                          leading: Icon(
                            isDay ? Icons.wb_sunny_outlined : Icons.dark_mode_outlined,
                            color: isDay ? c.accent : c.textSecondary,
                            semanticLabel: isDay ? l.clockDay : l.clockNight,
                          ),
                          title: Text(w.city,
                              style: Theme.of(context).textTheme.titleMedium),
                          subtitle: Text(_diffText(l, diffMin),
                              style: Theme.of(context).textTheme.labelSmall),
                          trailing: Text(
                            formatHm(t.hour, t.minute, use24h: use24h),
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(fontSize: 28),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  String _diffText(dynamic l, int diffMin) {
    if (diffMin == 0) return l.clockSameTime as String;
    final h = (diffMin.abs() / 60);
    final txt = h == h.roundToDouble() ? h.toInt().toString() : h.toStringAsFixed(1);
    return diffMin > 0
        ? l.clockHoursAhead(txt) as String
        : l.clockHoursBehind(txt) as String;
  }
}
