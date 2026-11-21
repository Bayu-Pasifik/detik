import 'package:material_ui/material_ui.dart';

import '../l10n/app_localizations.dart';

extension L10nContext on BuildContext {
  AppLocalizations get l => AppLocalizations.of(this);
}

/// "1 hari 2 jam 5 menit" yang dilokalkan, dari selisih [d] (dibulatkan ke atas
/// ke menit).
String countdownText(AppLocalizations l, Duration d) {
  final totalMin = (d.inSeconds / 60).ceil();
  final days = totalMin ~/ (24 * 60);
  final hours = (totalMin % (24 * 60)) ~/ 60;
  final mins = totalMin % 60;
  final parts = <String>[
    if (days > 0) l.durationDays('$days'),
    if (hours > 0) l.durationHours('$hours'),
    if (mins > 0 || (days == 0 && hours == 0)) l.durationMinutes('$mins'),
  ];
  return parts.join(' ');
}

String two(int v) => v.toString().padLeft(2, '0');

String formatHm(int h, int m, {required bool use24h}) {
  if (use24h) return '${two(h)}:${two(m)}';
  final suffix = h >= 12 ? 'PM' : 'AM';
  var hh = h % 12;
  if (hh == 0) hh = 12;
  return '$hh:${two(m)} $suffix';
}
