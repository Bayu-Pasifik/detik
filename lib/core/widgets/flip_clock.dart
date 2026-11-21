import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';

import '../theme/detik_colors.dart';
import '../theme/detik_theme.dart';

/// Satu kartu flip untuk satu digit. Hanya kartu yang digitnya berubah
/// yang membalik (~450 ms). Dengan [reduceMotion] pergantian langsung.
class FlipDigit extends StatefulWidget {
  const FlipDigit({
    super.key,
    required this.digit,
    this.height = 120,
    this.reduceMotion = false,
  });

  final int digit;
  final double height;
  final bool reduceMotion;

  @override
  State<FlipDigit> createState() => _FlipDigitState();
}

class _FlipDigitState extends State<FlipDigit>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late int _old;

  @override
  void initState() {
    super.initState();
    _old = widget.digit;
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));
  }

  @override
  void didUpdateWidget(FlipDigit old) {
    super.didUpdateWidget(old);
    if (old.digit != widget.digit) {
      _old = old.digit;
      if (widget.reduceMotion) {
        _ctrl.value = 1;
      } else {
        _ctrl.forward(from: 0);
      }
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Widget _card(BuildContext context, int d, {required bool top}) {
    final c = context.colors;
    final h = widget.height;
    final w = h * 0.68;
    final radius = Radius.circular(DetikRadius.flipCard);
    return ClipRect(
      child: Align(
        alignment: top ? Alignment.topCenter : Alignment.bottomCenter,
        heightFactor: 0.5,
        child: Container(
          width: w,
          height: h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: c.surfaceHigh,
            borderRadius: top
                ? BorderRadius.vertical(top: radius)
                : BorderRadius.vertical(bottom: radius),
          ),
          child: Text(
            '$d',
            style: TextStyle(
              fontSize: h * 0.8,
              height: 1,
              fontWeight: FontWeight.w700,
              color: c.textPrimary,
              fontFeatures: DetikTheme.tabular,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final h = widget.height;
    final w = h * 0.68;
    final newD = widget.digit;

    return Semantics(
      label: '$newD',
      excludeSemantics: true,
      child: SizedBox(
        width: w,
        height: h,
        child: AnimatedBuilder(
          animation: _ctrl,
          builder: (context, _) {
            final v = _ctrl.value;
            final animating = _ctrl.isAnimating;
            // Paruh pertama (0..0.5): atas lama berputar 0 -> -90.
            // Paruh kedua (0.5..1): bawah baru berputar 90 -> 0.
            final first = animating && v < 0.5;
            final second = animating && v >= 0.5;
            final topShown = animating ? (first ? _old : newD) : newD;
            final bottomShown = animating ? (second ? newD : _old) : newD;
            Widget flipping = const SizedBox.shrink();
            if (first) {
              final a = -math.pi / 2 * Curves.easeIn.transform(v / 0.5);
              flipping = Positioned(
                top: 0,
                child: _rotated(_card(context, _old, top: true), a,
                    Alignment.bottomCenter, shade: v / 0.5),
              );
            } else if (second) {
              final a =
                  math.pi / 2 * (1 - Curves.easeOut.transform((v - 0.5) / 0.5));
              flipping = Positioned(
                bottom: 0,
                child: _rotated(_card(context, newD, top: false), a,
                    Alignment.topCenter,
                    shade: 1 - (v - 0.5) / 0.5),
              );
            }
            return Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(top: 0, child: _card(context, topShown, top: true)),
                Positioned(
                    bottom: 0,
                    child: _card(context, bottomShown, top: false)),
                flipping,
                // Garis engsel tengah.
                Positioned(
                  top: h / 2 - 1,
                  left: 0,
                  right: 0,
                  child: Container(height: 2, color: c.bg.withValues(alpha: 0.9)),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _rotated(Widget child, double angle, Alignment align,
      {required double shade}) {
    return Transform(
      alignment: align,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.002)
        ..rotateX(angle),
      child: Stack(
        children: [
          child,
          // Bayangan tipis selama membalik.
          Positioned.fill(
            child: ClipRect(
              child: Align(
                alignment: align == Alignment.bottomCenter
                    ? Alignment.topCenter
                    : Alignment.bottomCenter,
                heightFactor: 0.5,
                child: ColoredBox(
                  color: const Color(0xFF000000)
                      .withValues(alpha: 0.35 * shade.clamp(0.0, 1.0)),
                  child: SizedBox(
                      width: widget.height * 0.68, height: widget.height),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Dua pasang digit HH:MM (+ detik kecil opsional di bawah).
class FlipClock extends StatelessWidget {
  const FlipClock({
    super.key,
    required this.time,
    this.use24h = true,
    this.showSeconds = true,
    this.digitHeight = 96,
    this.reduceMotion = false,
  });

  final DateTime time;
  final bool use24h;
  final bool showSeconds;
  final double digitHeight;
  final bool reduceMotion;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    var hour = time.hour;
    String? suffix;
    if (!use24h) {
      suffix = hour >= 12 ? 'PM' : 'AM';
      hour = hour % 12;
      if (hour == 0) hour = 12;
    }
    final h = hour.toString().padLeft(2, '0');
    final m = time.minute.toString().padLeft(2, '0');
    final s = time.second.toString().padLeft(2, '0');
    final gap = SizedBox(width: digitHeight * 0.06);

    Widget pair(String t) => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FlipDigit(
                digit: int.parse(t[0]),
                height: digitHeight,
                reduceMotion: reduceMotion),
            gap,
            FlipDigit(
                digit: int.parse(t[1]),
                height: digitHeight,
                reduceMotion: reduceMotion),
          ],
        );

    return Semantics(
      label: '$h:$m${suffix == null ? '' : ' $suffix'}',
      container: true,
      excludeSemantics: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                pair(h),
                SizedBox(
                  width: digitHeight * 0.3,
                  child: Center(
                    child: Text(':',
                        style: TextStyle(
                            fontSize: digitHeight * 0.6,
                            fontWeight: FontWeight.w700,
                            color: c.accent)),
                  ),
                ),
                pair(m),
                if (suffix != null)
                  Padding(
                    padding: EdgeInsets.only(left: digitHeight * 0.12),
                    child: Text(suffix,
                        style: TextStyle(
                            fontSize: digitHeight * 0.2,
                            fontWeight: FontWeight.w600,
                            color: c.textSecondary)),
                  ),
              ],
            ),
          ),
          if (showSeconds)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                s,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: c.accent,
                  fontFeatures: DetikTheme.tabular,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
