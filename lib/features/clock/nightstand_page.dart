import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../core/l10n.dart';
import '../../core/orbit/orbit_painter.dart';
import '../../core/providers.dart';
import '../../core/theme/detik_colors.dart';
import '../../core/widgets/flip_clock.dart';

/// Mode nakas: layar tetap menyala, navigasi disembunyikan, overlay peredup
/// (maks 40%). Ketuk dua kali untuk keluar.
class NightstandPage extends ConsumerStatefulWidget {
  const NightstandPage({super.key});

  @override
  ConsumerState<NightstandPage> createState() => _NightstandPageState();
}

class _NightstandPageState extends ConsumerState<NightstandPage> {
  @override
  void initState() {
    super.initState();
    WakelockPlus.enable();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    WakelockPlus.disable();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final l = context.l;
    final s = ref.watch(settingsValueProvider);
    final now = ref.watch(nowProvider);
    final night = ref.watch(nightFactorProvider);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onDoubleTap: () => context.pop(),
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            OrbitBackground(
              night: night,
              accent: c.accent,
              reduceMotion: s.reduceMotion,
              center: const Offset(0.5, 0.78),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FlipClock(
                  time: now,
                  use24h: s.use24h,
                  digitHeight: 110,
                  showSeconds: false,
                  reduceMotion: s.reduceMotion,
                ),
              ),
            ),
            Positioned(
              bottom: 24,
              left: 0,
              right: 0,
              child: Text(l.nightstandExit,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelSmall),
            ),
            // Peredup tambahan, maksimum 40%.
            IgnorePointer(
              child: ColoredBox(color: const Color(0xFF000000).withValues(alpha: 0.4)),
            ),
          ],
        ),
      ),
    );
  }
}
