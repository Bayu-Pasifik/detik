import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'database.g.dart';

/// Alarm. [repeatDays] = bitmask hari: bit0 = Senin ... bit6 = Minggu. 0 = sekali.
class Alarms extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get hour => integer()();
  IntColumn get minute => integer()();
  TextColumn get label => text().withDefault(const Constant(''))();
  IntColumn get repeatDays => integer().withDefault(const Constant(0))();
  BoolColumn get enabled => boolean().withDefault(const Constant(true))();
  TextColumn get tone => text().withDefault(const Constant('assets/audio/pagi.wav'))();
  BoolColumn get vibrate => boolean().withDefault(const Constant(true))();
  IntColumn get snoozeMinutes => integer().withDefault(const Constant(10))();
}

/// Timer berbasis waktu absolut: [endsAtMs] terisi saat berjalan,
/// [remainingMs] terisi saat dijeda/berhenti.
@DataClassName("TimerRow")
class Timers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get label => text().withDefault(const Constant(''))();
  IntColumn get durationMs => integer()();
  IntColumn get endsAtMs => integer().nullable()();
  IntColumn get remainingMs => integer().nullable()();
}

class WorldClocks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get city => text()();
  TextColumn get tzName => text()();
}

class Settings extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();
  @override
  Set<Column> get primaryKey => {key};
}

@DriftDatabase(tables: [Alarms, Timers, WorldClocks, Settings])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
      : super(executor ?? driftDatabase(name: 'detik'));

  @override
  int get schemaVersion => 1;

  // ---- Alarm ----
  Stream<List<Alarm>> watchAlarms() => (select(alarms)
        ..orderBy([(a) => OrderingTerm.asc(a.hour), (a) => OrderingTerm.asc(a.minute)]))
      .watch();
  Future<List<Alarm>> allAlarms() => select(alarms).get();
  Future<Alarm?> alarmById(int id) =>
      (select(alarms)..where((a) => a.id.equals(id))).getSingleOrNull();
  Future<int> saveAlarm(AlarmsCompanion a) => into(alarms).insertOnConflictUpdate(a);
  Future<int> patchAlarm(int id, AlarmsCompanion c) =>
      (update(alarms)..where((a) => a.id.equals(id))).write(c);
  Future<int> deleteAlarm(int id) => (delete(alarms)..where((a) => a.id.equals(id))).go();

  // ---- Timer ----
  Stream<List<TimerRow>> watchTimers() => select(timers).watch();
  Future<int> saveTimer(TimersCompanion t) => into(timers).insertOnConflictUpdate(t);
  Future<int> patchTimer(int id, TimersCompanion c) =>
      (update(timers)..where((t) => t.id.equals(id))).write(c);
  Future<int> deleteTimer(int id) => (delete(timers)..where((t) => t.id.equals(id))).go();

  // ---- Jam dunia ----
  Stream<List<WorldClock>> watchWorldClocks() => select(worldClocks).watch();
  Future<int> addWorldClock(String city, String tz) =>
      into(worldClocks).insert(WorldClocksCompanion.insert(city: city, tzName: tz));
  Future<int> deleteWorldClock(int id) =>
      (delete(worldClocks)..where((t) => t.id.equals(id))).go();

  // ---- Pengaturan ----
  Future<String?> getSetting(String key) async =>
      (await (select(settings)..where((s) => s.key.equals(key))).getSingleOrNull())?.value;
  Future<void> setSetting(String key, String value) =>
      into(settings).insertOnConflictUpdate(SettingsCompanion.insert(key: key, value: value));
  Stream<Map<String, String>> watchSettings() =>
      select(settings).watch().map((rows) => {for (final r in rows) r.key: r.value});
}
