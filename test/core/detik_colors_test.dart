import 'package:detik/core/theme/detik_colors.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('lerp t=0 returns day palette, t=1 returns night palette', () {
    final a = DetikColors.dark.lerp(DetikColors.night, 0);
    final b = DetikColors.dark.lerp(DetikColors.night, 1);
    expect(a.bg, DetikColors.dark.bg);
    expect(b.bg, DetikColors.night.bg);
    expect(b.accent, DetikColors.night.accent);
  });

  test('lerp midpoint differs from both ends', () {
    final m = DetikColors.dark.lerp(DetikColors.night, 0.5);
    expect(m.bg, isNot(DetikColors.dark.bg));
    expect(m.bg, isNot(DetikColors.night.bg));
  });
}
