import 'package:detik/core/alarm/trigger.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('sekali: hari ini bila belum lewat', () {
    final t = nextTrigger(hour: 7, minute: 30, repeatDays: 0, from: DateTime(2026, 11, 21, 6, 0));
    expect(t, DateTime(2026, 11, 21, 7, 30));
  });

  test('sekali: besok bila sudah lewat, termasuk menit yang sama', () {
    expect(nextTrigger(hour: 7, minute: 30, repeatDays: 0, from: DateTime(2026, 11, 21, 7, 30)),
        DateTime(2026, 11, 22, 7, 30));
  });

  test('lintas tengah malam dan akhir bulan', () {
    expect(nextTrigger(hour: 0, minute: 5, repeatDays: 0, from: DateTime(2026, 11, 30, 23, 59)),
        DateTime(2026, 12, 1, 0, 5));
  });

  test('hari tertentu: Senin dan Jumat', () {
    const days = 1 | (1 << 4);
    // 21 Nov 2026 = Sabtu -> Senin 23 Nov
    expect(nextTrigger(hour: 8, minute: 0, repeatDays: days, from: DateTime(2026, 11, 21, 9, 0)),
        DateTime(2026, 11, 23, 8, 0));
    // Senin 23 Nov 07:00 sebelum 08:00 -> hari yang sama
    expect(nextTrigger(hour: 8, minute: 0, repeatDays: days, from: DateTime(2026, 11, 23, 7, 0)),
        DateTime(2026, 11, 23, 8, 0));
    // Senin sudah lewat -> Jumat 27 Nov
    expect(nextTrigger(hour: 8, minute: 0, repeatDays: days, from: DateTime(2026, 11, 23, 8, 1)),
        DateTime(2026, 11, 27, 8, 0));
  });

  test('hari yang sama minggu depan bila hanya satu hari dipilih', () {
    const sabtu = 1 << 5;
    expect(nextTrigger(hour: 6, minute: 0, repeatDays: sabtu, from: DateTime(2026, 11, 21, 6, 0)),
        DateTime(2026, 11, 28, 6, 0));
  });

  test('format hitung mundur', () {
    expect(formatCountdown(const Duration(hours: 7, minutes: 29, seconds: 10)), '7 jam 30 menit');
    expect(formatCountdown(const Duration(seconds: 20)), '1 menit');
    expect(formatCountdown(const Duration(days: 1, hours: 2)), '1 hari 2 jam');
  });
}
