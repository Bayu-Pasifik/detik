import 'package:flutter/foundation.dart';

enum NightMode { auto, on, off, system }

/// Pengaturan aplikasi (disimpan di tabel `settings` sebagai teks).
@immutable
class AppSettings {
  const AppSettings({
    this.themeMode = 'dark',
    this.use24h = true,
    this.snoozeMinutes = 10,
    this.defaultTone = 'assets/audio/pagi.wav',
    this.defaultVibrate = true,
    this.reduceMotion = false,
    this.nightMode = NightMode.auto,
    this.nightStartMin = 22 * 60,
    this.nightEndMin = 6 * 60,
    this.locale = 'system',
  });

  /// 'dark' | 'light' | 'system'
  final String themeMode;
  final bool use24h;
  final int snoozeMinutes;
  final String defaultTone;
  final bool defaultVibrate;
  final bool reduceMotion;
  final NightMode nightMode;
  final int nightStartMin;
  final int nightEndMin;

  /// 'system' | 'id' | 'en'
  final String locale;

  factory AppSettings.fromMap(Map<String, String> m) {
    int i(String k, int d) => int.tryParse(m[k] ?? '') ?? d;
    bool b(String k, bool d) => m.containsKey(k) ? m[k] == '1' : d;
    return AppSettings(
      themeMode: m['themeMode'] ?? 'dark',
      use24h: b('use24h', true),
      snoozeMinutes: i('snoozeMinutes', 10),
      defaultTone: m['defaultTone'] ?? 'assets/audio/pagi.wav',
      defaultVibrate: b('defaultVibrate', true),
      reduceMotion: b('reduceMotion', false),
      nightMode: NightMode.values.firstWhere(
        (e) => e.name == m['nightMode'],
        orElse: () => NightMode.auto,
      ),
      nightStartMin: i('nightStartMin', 22 * 60),
      nightEndMin: i('nightEndMin', 6 * 60),
      locale: m['locale'] ?? 'system',
    );
  }
}
