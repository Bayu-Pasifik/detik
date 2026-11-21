import 'package:detik/core/db/database.dart';
import 'package:detik/features/timer/timer_providers.dart';
import 'package:flutter_test/flutter_test.dart';

TimerRow row({int? endsAt, int? remaining, int dur = 60000}) =>
    TimerRow(id: 1, label: '', durationMs: dur, endsAtMs: endsAt, remainingMs: remaining);

void main() {
  test('berjalan: sisa dihitung dari waktu absolut, bukan tick', () {
    final t = row(endsAt: 100000);
    expect(TimerService.remainingMs(t, 40000), 60000);
    // app "tertidur" 30 dtk: sisa tetap benar
    expect(TimerService.remainingMs(t, 70000), 30000);
    expect(TimerService.remainingMs(t, 100000), 0);
    expect(TimerService.remainingMs(t, 120000), lessThan(0));
  });
  test('jeda: sisa tersimpan; siap: sisa = durasi', () {
    expect(TimerService.remainingMs(row(remaining: 25000), 999), 25000);
    expect(TimerService.remainingMs(row(), 999), 60000);
    expect(TimerService.isRunning(row(endsAt: 1)), isTrue);
    expect(TimerService.isRunning(row(remaining: 1)), isFalse);
  });
}
