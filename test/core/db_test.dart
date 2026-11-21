import 'package:detik/core/db/database.dart';
import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  setUp(() => db = AppDatabase(NativeDatabase.memory()));
  tearDown(() => db.close());

  test('alarm: simpan, patch, urut menurut jam, hapus', () async {
    final a = await db.saveAlarm(AlarmsCompanion.insert(hour: 9, minute: 0));
    final b = await db.saveAlarm(AlarmsCompanion.insert(hour: 6, minute: 30));
    final list = await db.allAlarms();
    expect(list.length, 2);
    await db.patchAlarm(a, const AlarmsCompanion(enabled: Value(false)));
    expect((await db.alarmById(a))!.enabled, isFalse);
    expect((await db.alarmById(a))!.hour, 9); // field lain tidak berubah
    final first = (await db.watchAlarms().first).first;
    expect(first.id, b);
    await db.deleteAlarm(a);
    expect(await db.alarmById(a), isNull);
  });

  test('timer: patch tidak menyentuh durasi', () async {
    final id = await db.saveTimer(TimersCompanion.insert(durationMs: 60000));
    await db.patchTimer(id, const TimersCompanion(endsAtMs: Value(123)));
    final t = (await db.select(db.timers).get()).single;
    expect(t.durationMs, 60000);
    expect(t.endsAtMs, 123);
  });

  test('jam dunia dan pengaturan', () async {
    await db.addWorldClock('Tokyo', 'Asia/Tokyo');
    expect((await db.watchWorldClocks().first).single.city, 'Tokyo');
    await db.setSetting('themeMode', 'light');
    await db.setSetting('themeMode', 'dark');
    expect(await db.getSetting('themeMode'), 'dark');
  });
}
