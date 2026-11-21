import 'package:material_ui/material_ui.dart';

import 'detik_colors.dart';

/// Skala jarak (grid 4 dp) dan radius dari docs/STYLE.md bagian 4.
abstract final class DetikSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
  static const double screenMargin = 20;
}

abstract final class DetikRadius {
  static const double card = 20;
  static const double button = 16;
  static const double flipCard = 16;
  static const double sheet = 28;
  static const double chip = 999;
}

abstract final class DetikTheme {
  /// Fitur angka tabular agar digit waktu tidak bergoyang.
  static const tabular = [FontFeature.tabularFigures()];

  static ThemeData light() => _build(DetikColors.light, Brightness.light);
  static ThemeData dark() => _build(DetikColors.dark, Brightness.dark);

  /// Tema dengan palet sembarang, mis. hasil `lerp` siang ke malam.
  static ThemeData fromColors(DetikColors c, {required Brightness brightness}) =>
      _build(c, brightness);

  static ThemeData _build(DetikColors c, Brightness brightness) {
    final scheme = ColorScheme(
      brightness: brightness,
      primary: c.accent,
      onPrimary: c.bg,
      secondary: c.accent,
      onSecondary: c.bg,
      error: c.danger,
      onError: c.bg,
      surface: c.surface,
      onSurface: c.textPrimary,
      outline: c.outline,
    );

    final base = ThemeData(
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: c.bg,
      useMaterial3: true,
      extensions: [c],
    );

    return base.copyWith(
      dividerColor: c.outline,
      textTheme: base.textTheme.apply(
        bodyColor: c.textPrimary,
        displayColor: c.textPrimary,
      ).copyWith(
        // timeDisplay 72/300, timeLarge 40/400, titleLarge 22/600,
        // titleMedium 16/600, body 14/400, caption 12/500.
        displayLarge: TextStyle(
          fontSize: 72,
          fontWeight: FontWeight.w300,
          fontFeatures: tabular,
          color: c.textPrimary,
        ),
        displayMedium: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.w400,
          fontFeatures: tabular,
          color: c.textPrimary,
        ),
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: c.textPrimary,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: c.textPrimary,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: c.textPrimary,
        ),
        labelSmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: c.textSecondary,
        ),
      ),
      cardTheme: CardThemeData(
        color: c.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DetikRadius.card),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: c.accent,
        foregroundColor: c.bg,
        shape: const CircleBorder(),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: c.surfaceHigh,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(DetikRadius.sheet),
          ),
        ),
      ),
    );
  }
}
