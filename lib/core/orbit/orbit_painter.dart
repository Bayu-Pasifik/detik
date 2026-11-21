import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:material_ui/material_ui.dart';

/// Satu planet: periode orbit (detik), jari-jari relatif, warna siang.
class _Planet {
  const _Planet(this.name, this.period, this.rx, this.ry, this.radius,
      this.color, this.phase);
  final String name;
  final double period;
  final double rx; // fraksi lebar layar
  final double ry; // fraksi sisi terpendek layar
  final double radius; // dp
  final Color color;
  final double phase; // fase awal 0..1
}

const _planets = <_Planet>[
  _Planet('Merkurius', 40, 0.34, 0.20, 5, Color(0xFF9A9A9A), 0.10),
  _Planet('Venus', 55, 0.50, 0.30, 8, Color(0xFFE8D2A6), 0.45),
  _Planet('Bumi', 70, 0.68, 0.40, 9, Color(0xFF4F9DA6), 0.75),
  _Planet('Mars', 90, 0.86, 0.50, 7, Color(0xFFB5523B), 0.25),
];

/// Latar tata surya: matahari, 4 planet asli di orbit elips, bintang.
///
/// Gerak dihitung dari [clock] (detik terakumulasi, sudah memasukkan
/// kecepatan), jadi kecepatan bisa berubah mulus tanpa loncatan fase.
class OrbitPainter extends CustomPainter {
  OrbitPainter({
    required this.clock,
    required this.night,
    required this.pulse,
    required this.accent,
    this.avoid,
    this.center = const Offset(0.5, 0.5),
  }) : super(repaint: Listenable.merge([clock, night, pulse]));

  /// Detik animasi terakumulasi.
  final ValueListenable<double> clock;

  /// 0 = siang, 1 = malam.
  final ValueListenable<double> night;

  /// 0..1 kekuatan denyut (alarm berbunyi).
  final ValueListenable<double> pulse;
  final Color accent;

  /// Area jam; planet yang lewat di belakangnya turun ke 60% opasitas.
  final Rect? avoid;
  final Offset center;

  static const _warm = Color(0xFFFFB066);

  @override
  void paint(Canvas canvas, Size size) {
    final t = clock.value;
    final n = night.value;
    final p = pulse.value;
    final c = Offset(size.width * center.dx, size.height * center.dy);
    final dim = 1 - 0.35 * n; // meredup 35% saat malam
    final base = math.min(size.width, size.height);

    _stars(canvas, size, t, n);

    final orbitPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = const Color(0xFFFFFFFF).withValues(alpha: 0.07 * dim);
    for (final pl in _planets) {
      canvas.drawOval(
        Rect.fromCenter(
            center: c,
            width: size.width * pl.rx * 0.95,
            height: base * pl.ry * 0.95),
        orbitPaint,
      );
    }

    // Matahari.
    final sunColor = Color.lerp(const Color(0xFFFFD27A), _warm, n)!;
    final glowR = 30 + 6 * p;
    canvas.drawCircle(
      c,
      glowR,
      Paint()
        ..shader = RadialGradient(colors: [
          sunColor.withValues(alpha: 0.55 * dim),
          sunColor.withValues(alpha: 0),
        ]).createShader(Rect.fromCircle(center: c, radius: glowR)),
    );
    canvas.drawCircle(c, 9, Paint()..color = sunColor.withValues(alpha: dim));

    for (final pl in _planets) {
      final ang = 2 * math.pi * ((t / pl.period) + pl.phase);
      final pos = c +
          Offset(math.cos(ang) * size.width * pl.rx * 0.475,
              math.sin(ang) * base * pl.ry * 0.475);
      var alpha = dim;
      if (avoid != null && avoid!.inflate(pl.radius).contains(pos)) {
        alpha *= 0.6;
      }
      final r = pl.radius * (1 + 0.25 * p * math.sin(t * 2 * math.pi / 1.6));
      final col = Color.lerp(pl.color, _warm, 0.35 * n)!;
      if (pl.name == 'Bumi') {
        // Halo tipis berwarna aksen untuk planet utama.
        canvas.drawCircle(
          pos,
          r + 5,
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.5
            ..color = accent.withValues(alpha: 0.7 * alpha),
        );
      }
      canvas.drawCircle(pos, r, Paint()..color = col.withValues(alpha: alpha));
    }
  }

  void _stars(Canvas canvas, Size size, double t, double n) {
    final rnd = math.Random(7);
    final paint = Paint();
    for (var i = 0; i < 46; i++) {
      final x = rnd.nextDouble() * size.width;
      final y = rnd.nextDouble() * size.height;
      final ph = rnd.nextDouble() * 6.28;
      final r = 0.8 + rnd.nextDouble() * 0.8;
      final tw = 0.5 + 0.5 * math.sin(t * 0.8 + ph);
      // Bintang muncul pelan saat malam, redup saat siang.
      final a = (0.15 + 0.5 * n) * (0.4 + 0.6 * tw);
      paint.color = const Color(0xFFEFE6D5).withValues(alpha: a);
      canvas.drawCircle(Offset(x, y), r, paint);
    }
  }

  @override
  bool shouldRepaint(OrbitPainter old) =>
      old.avoid != avoid || old.accent != accent || old.center != center;
}

/// Widget latar orbit: menjalankan Ticker dan mengintegrasikan kecepatan.
class OrbitBackground extends StatefulWidget {
  const OrbitBackground({
    super.key,
    required this.night,
    required this.accent,
    this.avoid,
    this.fast = false,
    this.reduceMotion = false,
    this.center = const Offset(0.5, 0.5),
  });

  final ValueListenable<double> night;
  final Color accent;
  final Rect? avoid;
  final bool fast; // alarm berbunyi: 3x + denyut
  final bool reduceMotion;
  final Offset center;

  @override
  State<OrbitBackground> createState() => _OrbitBackgroundState();
}

class _OrbitBackgroundState extends State<OrbitBackground>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker;
  final _clock = ValueNotifier<double>(0);
  final _pulse = ValueNotifier<double>(0);
  Duration _last = Duration.zero;
  double _speed = 1;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_tick)..start();
  }

  void _tick(Duration elapsed) {
    final dt = (elapsed - _last).inMicroseconds / 1e6;
    _last = elapsed;
    if (widget.reduceMotion) return;
    final target = widget.fast ? 3.0 : 1.0;
    _speed += (target - _speed) * math.min(1, dt * 2); // percepatan halus
    _clock.value += dt * _speed;
    _pulse.value +=
        ((widget.fast ? 1.0 : 0.0) - _pulse.value) * math.min(1, dt * 4);
  }

  @override
  void dispose() {
    _ticker.dispose();
    _clock.dispose();
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(
        size: Size.infinite,
        painter: OrbitPainter(
          clock: _clock,
          night: widget.night,
          pulse: _pulse,
          accent: widget.accent,
          avoid: widget.avoid,
          center: widget.center,
        ),
      ),
    );
  }
}
