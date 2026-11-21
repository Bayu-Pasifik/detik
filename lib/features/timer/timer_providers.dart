import 'package:alarm/alarm.dart' as plugin;
import 'package:drift/drift.dart' show Value;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/alarm/alarm_service.dart';
import '../../core/db/database.dart';
import '../../core/providers.dart';

final timersProvider = StreamProvider<List<TimerRow>>(
    (ref) => ref.watch(databaseProvider).watchTimers());

final timerServiceProvider =
    Provider((ref) => TimerService(ref.watch(databaseProvider)));

/// Mesin timer berbasis waktu absolut: yang disimpan adalah `endsAtMs`
/// (saat berjalan) atau `remainingMs` (saat jeda), bukan hitungan per tick,
/// jadi tahan app di latar/ditutup. Bunyi selesai dijadwalkan lewat plugin
/// alarm; notifikasi persisten memakai chronometer hitung mundur.
class TimerService {
  TimerService(this.db);
  final AppDatabase db;

  static final _notif = FlutterLocalNotificationsPlugin();
  static bool _notifReady = false;

  static Future<void> initNotifications() async {
    if (_notifReady) return;
    await _notif.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      ),
    );
    _notifReady = true;
  }

  /// Sisa waktu pada [now]; negatif/0 berarti selesai.
  static int remainingMs(TimerRow t, int nowMs) {
    if (t.endsAtMs != null) return t.endsAtMs! - nowMs;
    return t.remainingMs ?? t.durationMs;
  }

  static bool isRunning(TimerRow t) => t.endsAtMs != null;

  Future<int> create(int durationMs, String label) {
    return db.saveTimer(TimersCompanion.insert(durationMs: durationMs)
        .copyWith(label: Value(label), remainingMs: Value(durationMs)));
  }

  Future<void> start(TimerRow t, {String title = 'Timer', String running = 'Timer'}) async {
    final nowMs = DateTime.now().millisecondsSinceEpoch;
    final rem = t.remainingMs ?? t.durationMs;
    final endsAt = nowMs + rem;
    await db.patchTimer(t.id, TimersCompanion(
      endsAtMs: Value(endsAt),
      remainingMs: const Value(null),
    ));
    await plugin.Alarm.set(
      alarmSettings: plugin.AlarmSettings(
        id: kTimerBase + t.id,
        dateTime: DateTime.fromMillisecondsSinceEpoch(endsAt),
        assetAudioPath: 'assets/audio/komet.wav',
        loopAudio: true,
        vibrate: true,
        fadeDuration: 0,
        warningNotificationOnKill: false,
        notificationSettings: plugin.NotificationSettings(
          title: t.label.isEmpty ? title : t.label,
          body: title,
          stopButton: 'OK',
        ),
      ),
    );
    await _showRunning(t, endsAt, running);
  }

  Future<void> pause(TimerRow t) async {
    final nowMs = DateTime.now().millisecondsSinceEpoch;
    final rem = (t.endsAtMs! - nowMs).clamp(0, t.durationMs);
    await plugin.Alarm.stop(kTimerBase + t.id);
    await _notif.cancel(id: _nid(t.id));
    await db.patchTimer(t.id, TimersCompanion(
      endsAtMs: const Value(null),
      remainingMs: Value(rem),
    ));
  }

  Future<void> reset(TimerRow t) async {
    await plugin.Alarm.stop(kTimerBase + t.id);
    await _notif.cancel(id: _nid(t.id));
    await db.patchTimer(t.id, TimersCompanion(
      endsAtMs: const Value(null),
      remainingMs: Value(t.durationMs),
    ));
  }

  Future<void> delete(TimerRow t) async {
    await plugin.Alarm.stop(kTimerBase + t.id);
    await _notif.cancel(id: _nid(t.id));
    await db.deleteTimer(t.id);
  }

  /// Dipanggil saat timer selesai dan pengguna mematikan bunyinya.
  Future<void> onFinished(int timerId) async {
    await _notif.cancel(id: _nid(timerId));
    final rows = await db.select(db.timers).get();
    final t = rows.where((r) => r.id == timerId);
    if (t.isEmpty) return;
    await db.patchTimer(timerId, TimersCompanion(
      endsAtMs: const Value(null),
      remainingMs: Value(t.first.durationMs),
    ));
  }

  int _nid(int timerId) => 5000 + timerId;

  Future<void> _showRunning(TimerRow t, int endsAt, String title) async {
    await initNotifications();
    await _notif.show(
      id: _nid(t.id),
      title: t.label.isEmpty ? title : t.label,
      body: title,
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          'timer_running',
          'Timer',
          channelDescription: 'Timer yang sedang berjalan',
          importance: Importance.low,
          priority: Priority.low,
          ongoing: true,
          onlyAlertOnce: true,
          showWhen: true,
          when: endsAt,
          usesChronometer: true,
          chronometerCountDown: true,
          category: AndroidNotificationCategory.progress,
        ),
      ),
    );
  }

  /// Samakan state dengan kenyataan: timer yang sudah lewat waktunya saat app
  /// tertutup dikembalikan ke keadaan siap.
  Future<void> reconcile() async {
    final nowMs = DateTime.now().millisecondsSinceEpoch;
    final rows = await db.select(db.timers).get();
    for (final t in rows) {
      if (t.endsAtMs != null && t.endsAtMs! < nowMs - 60 * 1000) {
        final ringing = await plugin.Alarm.isRinging(kTimerBase + t.id);
        if (!ringing) await onFinished(t.id);
      }
    }
  }
}
