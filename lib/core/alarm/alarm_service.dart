import 'package:drift/drift.dart' show Value;
import 'package:alarm/alarm.dart' as plugin;

import '../db/database.dart';
import 'trigger.dart';

/// Skema id untuk plugin `alarm`:
///  - alarm biasa: `alarmId * 100 + k`, k = 0..6 (7 pemicu ke depan,
///    supaya alarm berulang tetap hidup walau app tidak dibuka lagi),
///  - snooze: `alarmId * 100 + 99`,
///  - timer: `timerBase + timerId`.
const kOccurrences = 7;
const kSnoozeSlot = 99;
const kTimerBase = 90000000;

int alarmIdOf(int pluginId) =>
    pluginId >= kTimerBase ? -1 : pluginId ~/ 100;
bool isTimerId(int pluginId) => pluginId >= kTimerBase;
int timerIdOf(int pluginId) => pluginId - kTimerBase;
bool isSnoozeId(int pluginId) =>
    pluginId < kTimerBase && pluginId % 100 == kSnoozeSlot;

class AlarmService {
  AlarmService(this.db);
  final AppDatabase db;

  /// Pemicu berikutnya dari semua alarm aktif (null bila tidak ada).
  static DateTime? nextOf(List<Alarm> alarms, DateTime now) {
    DateTime? best;
    for (final a in alarms.where((a) => a.enabled)) {
      final t = nextTrigger(
          hour: a.hour, minute: a.minute, repeatDays: a.repeatDays, from: now);
      if (best == null || t.isBefore(best)) best = t;
    }
    return best;
  }

  plugin.AlarmSettings _settings(int id, DateTime at, Alarm a, String body) {
    return plugin.AlarmSettings(
      id: id,
      dateTime: at,
      assetAudioPath: a.tone,
      loopAudio: true,
      vibrate: a.vibrate,
      fadeDuration: 15, // volume naik bertahap
      warningNotificationOnKill: true,
      androidFullScreenIntent: true,
      notificationSettings: plugin.NotificationSettings(
        title: a.label.isEmpty ? 'Alarm' : a.label,
        body: body,
        stopButton: 'Matikan',
      ),
    );
  }

  String _hhmm(int h, int m) =>
      '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}';

  /// Jadwalkan ulang satu alarm (batalkan dulu semua slot lamanya).
  Future<void> schedule(Alarm a) async {
    await cancel(a.id);
    if (!a.enabled) return;
    var from = DateTime.now();
    final count = a.repeatDays == 0 ? 1 : kOccurrences;
    for (var k = 0; k < count; k++) {
      final at = nextTrigger(
          hour: a.hour, minute: a.minute, repeatDays: a.repeatDays, from: from);
      await plugin.Alarm.set(
          alarmSettings:
              _settings(a.id * 100 + k, at, a, _hhmm(a.hour, a.minute)));
      from = at;
    }
  }

  Future<void> cancel(int alarmId) async {
    for (var k = 0; k < kOccurrences; k++) {
      await plugin.Alarm.stop(alarmId * 100 + k);
    }
    await plugin.Alarm.stop(alarmId * 100 + kSnoozeSlot);
  }

  /// Tunda alarm [alarmId] selama [minutes] menit.
  Future<void> snooze(int alarmId, int minutes) async {
    final a = await db.alarmById(alarmId);
    if (a == null) return;
    final at = DateTime.now().add(Duration(minutes: minutes));
    await plugin.Alarm.set(
        alarmSettings: _settings(alarmId * 100 + kSnoozeSlot, at, a,
            'Ditunda $minutes menit'));
  }

  /// Dipanggil saat pengguna mematikan alarm [pluginId] yang berbunyi.
  Future<void> dismiss(int pluginId) async {
    await plugin.Alarm.stop(pluginId);
    if (isTimerId(pluginId)) return;
    final id = alarmIdOf(pluginId);
    final a = await db.alarmById(id);
    if (a == null || isSnoozeId(pluginId)) return;
    if (a.repeatDays == 0) {
      // Alarm sekali: matikan setelah berbunyi.
      await db.patchAlarm(id, const AlarmsCompanion(enabled: Value(false)));
    } else {
      // Isi ulang jendela 7 pemicu ke depan.
      await schedule(a);
    }
  }

  /// Samakan jadwal plugin dengan DB. Dipanggil saat app dibuka/dilanjutkan,
  /// setelah ganti zona waktu/jam, dan setelah reboot.
  Future<void> syncAll() async {
    final alarms = await db.allAlarms();
    final scheduled = await plugin.Alarm.getAlarms();
    final ringing = <int>{};
    for (final s in scheduled) {
      if (await plugin.Alarm.isRinging(s.id)) ringing.add(s.id);
    }
    final validIds = {for (final a in alarms) a.id};

    // Buang jadwal yatim (alarm sudah dihapus).
    for (final s in scheduled) {
      if (isTimerId(s.id)) continue;
      if (!validIds.contains(alarmIdOf(s.id))) await plugin.Alarm.stop(s.id);
    }

    for (final a in alarms) {
      if (!a.enabled) {
        await cancel(a.id);
        continue;
      }
      final mine = scheduled.where((s) => !isTimerId(s.id) && alarmIdOf(s.id) == a.id);
      if (mine.any((s) => ringing.contains(s.id))) continue;
      if (a.repeatDays == 0 && mine.isEmpty) {
        // Sudah berbunyi dan dimatikan lewat notifikasi saat app tertutup.
        await db.patchAlarm(a.id, const AlarmsCompanion(enabled: Value(false)));
        continue;
      }
      // Hitung ulang: menangani perubahan zona waktu/jam sistem.
      final expected = nextTrigger(
          hour: a.hour,
          minute: a.minute,
          repeatDays: a.repeatDays,
          from: DateTime.now());
      final first = mine.where((s) => !isSnoozeId(s.id)).toList()
        ..sort((x, y) => x.dateTime.compareTo(y.dateTime));
      final ok = first.isNotEmpty &&
          first.first.dateTime.difference(expected).inSeconds.abs() < 5 &&
          (a.repeatDays == 0 || first.length >= kOccurrences - 1);
      if (!ok) await schedule(a);
    }
  }
}
