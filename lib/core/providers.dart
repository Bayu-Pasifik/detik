import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'db/database.dart';
import 'settings/app_settings.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final settingsProvider = StreamProvider<AppSettings>((ref) {
  return ref.watch(databaseProvider).watchSettings().map(AppSettings.fromMap);
});

/// Pengaturan saat ini; nilai bawaan selama DB belum memuat.
final settingsValueProvider = Provider<AppSettings>(
  (ref) => ref.watch(settingsProvider).value ?? const AppSettings(),
);

Future<void> saveSetting(WidgetRef ref, String key, Object value) {
  final v = value is bool ? (value ? '1' : '0') : value.toString();
  return ref.read(databaseProvider).setSetting(key, v);
}

/// Berdetak tiap detik penuh (selaras dengan jam dinding).
final clockProvider = StreamProvider<DateTime>((ref) async* {
  while (true) {
    final now = DateTime.now();
    yield now;
    await Future<void>.delayed(
        Duration(milliseconds: 1000 - now.millisecond + 5));
  }
});

final nowProvider = Provider<DateTime>(
  (ref) => ref.watch(clockProvider).value ?? DateTime.now(),
);

/// Nilai malam 0-1 yang dianimasikan (lihat DetikApp). Dibaca langsung oleh
/// pelukis orbit lewat ValueListenable agar tidak membangun ulang widget.
final nightFactorProvider = Provider<ValueNotifier<double>>((ref) {
  final n = ValueNotifier<double>(0);
  ref.onDispose(n.dispose);
  return n;
});

/// Alarm sedang berbunyi? Orbit mempercepat 3x.
class _Flag extends Notifier<bool> {
  @override
  bool build() => false;
  void set(bool v) => state = v;
}

final ringingProvider = NotifierProvider<_Flag, bool>(_Flag.new);

/// Mode nakas aktif?
final nightstandProvider = NotifierProvider<_Flag, bool>(_Flag.new);
