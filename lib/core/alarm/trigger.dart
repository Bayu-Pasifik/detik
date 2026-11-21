/// Hitung waktu pemicu alarm berikutnya.
///
/// [repeatDays]: bitmask, bit0 = Senin ... bit6 = Minggu. 0 = sekali
/// (pemicu berikutnya = hari ini bila belum lewat, kalau tidak besok).
/// Perhitungan memakai komponen waktu lokal, jadi mengikuti zona waktu
/// perangkat saat ini.
DateTime nextTrigger({
  required int hour,
  required int minute,
  required int repeatDays,
  required DateTime from,
}) {
  for (var offset = 0; offset <= 7; offset++) {
    final day = DateTime(from.year, from.month, from.day + offset);
    final candidate = DateTime(day.year, day.month, day.day, hour, minute);
    if (!candidate.isAfter(from)) continue;
    if (repeatDays == 0) return candidate;
    // DateTime.weekday: 1 = Senin ... 7 = Minggu
    if (repeatDays & (1 << (candidate.weekday - 1)) != 0) return candidate;
  }
  // Tidak tercapai: untuk repeatDays != 0 selalu ada hari cocok dalam 8 hari.
  throw StateError('Tidak ada pemicu untuk repeatDays=$repeatDays');
}

/// Teks "dalam 7 jam 30 menit" dari selisih [d].
String formatCountdown(Duration d) {
  final totalMin = (d.inSeconds / 60).ceil();
  final days = totalMin ~/ (24 * 60);
  final hours = (totalMin % (24 * 60)) ~/ 60;
  final mins = totalMin % 60;
  final parts = <String>[
    if (days > 0) '$days hari',
    if (hours > 0) '$hours jam',
    if (mins > 0 || (days == 0 && hours == 0)) '$mins menit',
  ];
  return parts.join(' ');
}
