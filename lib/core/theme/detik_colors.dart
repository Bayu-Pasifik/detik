import 'package:material_ui/material_ui.dart';

/// Token warna Detik (lihat docs/STYLE.md bagian 2).
///
/// Dipakai sebagai [ThemeExtension] supaya `Color.lerp` antar palet siang
/// dan malam bisa digerakkan oleh satu nilai `nightFactor` (0–1).
@immutable
class DetikColors extends ThemeExtension<DetikColors> {
  const DetikColors({
    required this.bg,
    required this.surface,
    required this.surfaceHigh,
    required this.outline,
    required this.textPrimary,
    required this.textSecondary,
    required this.accent,
    required this.accentSoft,
    required this.danger,
    required this.success,
  });

  final Color bg;
  final Color surface;
  final Color surfaceHigh;
  final Color outline;
  final Color textPrimary;
  final Color textSecondary;
  final Color accent;
  final Color accentSoft;
  final Color danger;
  final Color success;

  /// Tema gelap (utama).
  static const dark = DetikColors(
    bg: Color(0xFF0F1115),
    surface: Color(0xFF181B21),
    surfaceHigh: Color(0xFF222630),
    outline: Color(0xFF2E333F),
    textPrimary: Color(0xFFF2F4F8),
    textSecondary: Color(0xFF9AA3B2),
    accent: Color(0xFFFFB547),
    accentSoft: Color(0xFF3A2C14),
    danger: Color(0xFFFF6B5E),
    success: Color(0xFF5BD6A0),
  );

  /// Tema terang.
  static const light = DetikColors(
    bg: Color(0xFFFAF8F5),
    surface: Color(0xFFFFFFFF),
    surfaceHigh: Color(0xFFF1EDE6),
    outline: Color(0xFFE2DCD2),
    textPrimary: Color(0xFF17191F),
    textSecondary: Color(0xFF5E6676),
    accent: Color(0xFFE08A00),
    accentSoft: Color(0xFFFFE9C7),
    danger: Color(0xFFD8483B),
    success: Color(0xFF2E9E6B),
  );

  /// Palet malam (redup), tujuan transisi saat `nightFactor` = 1.
  static const night = DetikColors(
    bg: Color(0xFF07080B),
    surface: Color(0xFF0E1014),
    surfaceHigh: Color(0xFF151820),
    outline: Color(0xFF1C2029),
    textPrimary: Color(0xFFC9B8A0),
    textSecondary: Color(0xFF8A847B),
    accent: Color(0xFFB8741A),
    accentSoft: Color(0xFF241A0B),
    danger: Color(0xFFB5473E),
    success: Color(0xFF3F9B75),
  );

  @override
  DetikColors copyWith({
    Color? bg,
    Color? surface,
    Color? surfaceHigh,
    Color? outline,
    Color? textPrimary,
    Color? textSecondary,
    Color? accent,
    Color? accentSoft,
    Color? danger,
    Color? success,
  }) {
    return DetikColors(
      bg: bg ?? this.bg,
      surface: surface ?? this.surface,
      surfaceHigh: surfaceHigh ?? this.surfaceHigh,
      outline: outline ?? this.outline,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      accent: accent ?? this.accent,
      accentSoft: accentSoft ?? this.accentSoft,
      danger: danger ?? this.danger,
      success: success ?? this.success,
    );
  }

  @override
  DetikColors lerp(ThemeExtension<DetikColors>? other, double t) {
    if (other is! DetikColors) return this;
    return DetikColors(
      bg: Color.lerp(bg, other.bg, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceHigh: Color.lerp(surfaceHigh, other.surfaceHigh, t)!,
      outline: Color.lerp(outline, other.outline, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      accentSoft: Color.lerp(accentSoft, other.accentSoft, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      success: Color.lerp(success, other.success, t)!,
    );
  }
}

extension DetikColorsContext on BuildContext {
  DetikColors get colors => Theme.of(this).extension<DetikColors>()!;
}
