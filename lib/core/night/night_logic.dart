import '../settings/app_settings.dart';

/// Apakah [minuteOfDay] (0–1439) ada di jendela malam [start]..[end].
/// Mendukung jendela yang melewati tengah malam (mis. 22:00–06:00).
bool inNightWindow(int minuteOfDay, int start, int end) {
  if (start == end) return false;
  if (start < end) return minuteOfDay >= start && minuteOfDay < end;
  return minuteOfDay >= start || minuteOfDay < end;
}

/// Target mode malam saat ini (true = malam).
bool isNightNow({
  required DateTime now,
  required NightMode mode,
  required int startMin,
  required int endMin,
  required bool systemDark,
}) {
  switch (mode) {
    case NightMode.on:
      return true;
    case NightMode.off:
      return false;
    case NightMode.system:
      return systemDark;
    case NightMode.auto:
      return inNightWindow(now.hour * 60 + now.minute, startMin, endMin);
  }
}
