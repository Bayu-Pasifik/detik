import 'package:detik/core/theme/detik_colors.dart';
import 'package:detik/core/theme/detik_theme.dart';
import 'package:detik/core/widgets/flip_clock.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';

Widget host(DateTime t, {bool reduce = false}) => MaterialApp(
      theme: DetikTheme.dark(),
      home: Scaffold(body: Center(child: FlipClock(time: t, reduceMotion: reduce))),
    );

void main() {
  testWidgets('hanya digit yang berubah yang membalik', (tester) async {
    await tester.pumpWidget(host(DateTime(2026, 1, 1, 12, 34, 5)));
    await tester.pumpWidget(host(DateTime(2026, 1, 1, 12, 34, 6)));
    // Detik berubah tapi digit HH:MM sama -> tidak ada animasi berjalan.
    await tester.pump(const Duration(milliseconds: 100));
    expect(tester.hasRunningAnimations, isFalse);

    await tester.pumpWidget(host(DateTime(2026, 1, 1, 12, 35, 0)));
    await tester.pump(const Duration(milliseconds: 100));
    expect(tester.hasRunningAnimations, isTrue); // digit menit membalik
    await tester.pump(const Duration(milliseconds: 500));
    expect(tester.hasRunningAnimations, isFalse);
  });

  testWidgets('kurangi animasi: pergantian langsung', (tester) async {
    await tester.pumpWidget(host(DateTime(2026, 1, 1, 12, 34), reduce: true));
    await tester.pumpWidget(host(DateTime(2026, 1, 1, 12, 35), reduce: true));
    await tester.pump();
    expect(tester.hasRunningAnimations, isFalse);
  });

  testWidgets('format 12 jam dan label semantik', (tester) async {
    final handle = tester.ensureSemantics();
    await tester.pumpWidget(MaterialApp(
      theme: DetikTheme.dark(),
      home: Scaffold(
          body: FlipClock(time: DateTime(2026, 1, 1, 15, 5), use24h: false)),
    ));
    expect(find.text('PM'), findsOneWidget);
    expect(find.bySemanticsLabel('03:05 PM'), findsOneWidget);
    expect(DetikColors.dark.bg, isNotNull);
    handle.dispose();
  });
}
