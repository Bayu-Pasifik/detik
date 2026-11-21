import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/l10n.dart';
import '../../core/providers.dart';
import '../../core/settings/app_settings.dart';
import '../../core/theme/detik_colors.dart';
import 'tone_picker.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l;
    final c = context.colors;
    final s = ref.watch(settingsValueProvider);

    Widget header(String t) => Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 4),
          child: Text(t,
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(color: c.accent, fontWeight: FontWeight.w600)),
        );

    Future<void> pickTime(String key, int current) async {
      final t = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: current ~/ 60, minute: current % 60),
      );
      if (t != null) await saveSetting(ref, key, t.hour * 60 + t.minute);
    }

    String hm(int m) => '${two(m ~/ 60)}:${two(m % 60)}';

    return Scaffold(
      appBar: AppBar(
        title: Text(l.settings),
        leading: BackButton(onPressed: () => context.pop()),
      ),
      body: ListView(
        children: [
          header(l.settingsAppearance),
          ListTile(
            title: Text(l.settingsTheme),
            trailing: DropdownButton<String>(
              value: s.themeMode,
              underline: const SizedBox.shrink(),
              items: [
                DropdownMenuItem(value: 'dark', child: Text(l.themeDark)),
                DropdownMenuItem(value: 'light', child: Text(l.themeLight)),
                DropdownMenuItem(value: 'system', child: Text(l.themeSystem)),
              ],
              onChanged: (v) => saveSetting(ref, 'themeMode', v ?? 'dark'),
            ),
          ),
          ListTile(
            title: Text(l.settingsLanguage),
            trailing: DropdownButton<String>(
              value: s.locale,
              underline: const SizedBox.shrink(),
              items: [
                DropdownMenuItem(value: 'system', child: Text(l.languageSystem)),
                const DropdownMenuItem(value: 'id', child: Text('Bahasa Indonesia')),
                const DropdownMenuItem(value: 'en', child: Text('English')),
              ],
              onChanged: (v) => saveSetting(ref, 'locale', v ?? 'system'),
            ),
          ),
          SwitchListTile(
            title: Text(l.settingsTimeFormat),
            value: s.use24h,
            onChanged: (v) => saveSetting(ref, 'use24h', v),
          ),
          SwitchListTile(
            title: Text(l.settingsReduceMotion),
            value: s.reduceMotion,
            onChanged: (v) => saveSetting(ref, 'reduceMotion', v),
          ),
          header(l.settingsNight),
          ListTile(
            title: Text(l.settingsNight),
            trailing: DropdownButton<NightMode>(
              value: s.nightMode,
              underline: const SizedBox.shrink(),
              items: [
                DropdownMenuItem(value: NightMode.auto, child: Text(l.nightAuto)),
                DropdownMenuItem(value: NightMode.on, child: Text(l.nightOn)),
                DropdownMenuItem(value: NightMode.off, child: Text(l.nightOff)),
                DropdownMenuItem(value: NightMode.system, child: Text(l.nightSystem)),
              ],
              onChanged: (v) =>
                  saveSetting(ref, 'nightMode', (v ?? NightMode.auto).name),
            ),
          ),
          if (s.nightMode == NightMode.auto) ...[
            ListTile(
              title: Text(l.nightStart),
              trailing: Text(hm(s.nightStartMin)),
              onTap: () => pickTime('nightStartMin', s.nightStartMin),
            ),
            ListTile(
              title: Text(l.nightEnd),
              trailing: Text(hm(s.nightEndMin)),
              onTap: () => pickTime('nightEndMin', s.nightEndMin),
            ),
          ],
          header(l.settingsAlarmDefaults),
          ListTile(
            title: Text(l.settingsDefaultSnooze),
            trailing: DropdownButton<int>(
              value: s.snoozeMinutes,
              underline: const SizedBox.shrink(),
              items: [
                for (final m in const [5, 10, 15, 20, 30])
                  DropdownMenuItem(value: m, child: Text(l.alarmSnoozeMinutes('$m'))),
              ],
              onChanged: (v) => saveSetting(ref, 'snoozeMinutes', v ?? 10),
            ),
          ),
          ListTile(
            title: Text(l.settingsDefaultTone),
            subtitle: Text(toneName(l, s.defaultTone)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () async {
              final t = await pickTone(context, s.defaultTone);
              if (t != null) await saveSetting(ref, 'defaultTone', t);
            },
          ),
          SwitchListTile(
            title: Text(l.settingsDefaultVibrate),
            value: s.defaultVibrate,
            onChanged: (v) => saveSetting(ref, 'defaultVibrate', v),
          ),
          header(l.settingsPermissions),
          ListTile(
            leading: const Icon(Icons.shield_outlined),
            title: Text(l.settingsPermissions),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/permissions'),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
