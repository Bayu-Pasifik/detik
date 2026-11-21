import 'package:detik/core/night/night_logic.dart';
import 'package:detik/core/settings/app_settings.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('jendela malam', () {
    test('lintas tengah malam 22:00-06:00', () {
      const s = 22 * 60, e = 6 * 60;
      expect(inNightWindow(23 * 60, s, e), isTrue);
      expect(inNightWindow(0, s, e), isTrue);
      expect(inNightWindow(5 * 60 + 59, s, e), isTrue);
      expect(inNightWindow(6 * 60, s, e), isFalse);
      expect(inNightWindow(12 * 60, s, e), isFalse);
      expect(inNightWindow(22 * 60, s, e), isTrue);
    });
    test('jendela dalam satu hari 01:00-05:00', () {
      expect(inNightWindow(3 * 60, 60, 300), isTrue);
      expect(inNightWindow(23 * 60, 60, 300), isFalse);
    });
    test('start == end berarti tidak pernah malam', () {
      expect(inNightWindow(0, 100, 100), isFalse);
    });
  });

  group('mode', () {
    final now = DateTime(2026, 11, 21, 23, 0);
    bool run(NightMode m, {bool dark = false}) => isNightNow(
        now: now, mode: m, startMin: 22 * 60, endMin: 6 * 60, systemDark: dark);
    test('auto mengikuti jadwal', () => expect(run(NightMode.auto), isTrue));
    test('on/off tetap', () {
      expect(run(NightMode.on), isTrue);
      expect(run(NightMode.off), isFalse);
    });
    test('system mengikuti mode gelap sistem', () {
      expect(run(NightMode.system, dark: true), isTrue);
      expect(run(NightMode.system, dark: false), isFalse);
    });
    test('perubahan zona waktu: jam lokal baru menentukan hasil', () {
      // Perangkat pindah zona: jam dinding 13:00 -> siang.
      expect(
          isNightNow(
              now: DateTime(2026, 11, 22, 13, 0),
              mode: NightMode.auto,
              startMin: 22 * 60,
              endMin: 6 * 60,
              systemDark: false),
          isFalse);
    });
  });
}
