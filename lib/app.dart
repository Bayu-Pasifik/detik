import 'package:alarm/alarm.dart' as plugin;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'core/alarm/alarm_providers.dart';
import 'core/night/night_logic.dart';
import 'core/providers.dart';
import 'core/theme/detik_colors.dart';
import 'core/theme/detik_theme.dart';
import 'features/router.dart';
import 'l10n/app_localizations.dart';

class DetikApp extends ConsumerStatefulWidget {
  const DetikApp({super.key});

  @override
  ConsumerState<DetikApp> createState() => _DetikAppState();
}

class _DetikAppState extends ConsumerState<DetikApp>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late final AnimationController _anim;
  late final ValueNotifier<double> _night;
  double _from = 0;
  double _to = 0;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _night = ref.read(nightFactorProvider);
    _anim = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500))
      ..addListener(() {
        final t = Curves.easeInOutCubic.transform(_anim.value);
        _night.value = _from + (_to - _from) * t;
      });
    plugin.Alarm.ringStream.stream.listen(_onRing);
    // Alarm yang sedang berbunyi saat app dibuka (mis. lewat layar penuh).
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.read(alarmServiceProvider).syncAll();
      for (final a in await plugin.Alarm.getAlarms()) {
        if (await plugin.Alarm.isRinging(a.id)) _onRing(a);
      }
    });
  }

  void _onRing(plugin.AlarmSettings a) {
    ref.read(ringingProvider.notifier).set(true);
    final router = ref.read(routerProvider);
    final uri = router.routeInformationProvider.value.uri;
    if (uri.path != '/ring') router.go('/ring?id=${a.id}');
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Saat aplikasi dibuka langsung ke nilai yang benar, tanpa animasi.
      _jump();
      ref.read(alarmServiceProvider).syncAll();
    }
  }

  @override
  void didChangePlatformBrightness() => setState(() {});

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _anim.dispose();
    super.dispose();
  }

  bool _targetNight() {
    final s = ref.read(settingsValueProvider);
    return isNightNow(
      now: DateTime.now(),
      mode: s.nightMode,
      startMin: s.nightStartMin,
      endMin: s.nightEndMin,
      systemDark: WidgetsBinding.instance.platformDispatcher.platformBrightness ==
          Brightness.dark,
    );
  }

  void _jump() {
    _anim.stop();
    _from = _to = _targetNight() ? 1 : 0;
    _night.value = _to;
  }

  void _sync() {
    final target = _targetNight() ? 1.0 : 0.0;
    if (!_initialized) {
      _initialized = true;
      _from = _to = target;
      _night.value = target;
      return;
    }
    if (target != _to) {
      _from = _night.value;
      _to = target;
      _anim.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsValueProvider);
    ref.watch(nowProvider); // evaluasi jadwal malam tiap detik
    final loaded = ref.watch(settingsProvider).hasValue;
    if (loaded) _sync();
    final router = ref.watch(routerProvider);
    final platformDark = MediaQuery.platformBrightnessOf(context) == Brightness.dark;

    final isLight = settings.themeMode == 'light' ||
        (settings.themeMode == 'system' && !platformDark);
    final dayPalette = isLight ? DetikColors.light : DetikColors.dark;

    return ValueListenableBuilder<double>(
      valueListenable: _night,
      builder: (context, n, _) {
        final colors = dayPalette.lerp(DetikColors.night, n);
        // Teks/ikon sistem mengikuti terang-gelap hasil lerp.
        final brightness =
            ThemeData.estimateBrightnessForColor(colors.bg);
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: router,
          theme: DetikTheme.fromColors(colors, brightness: brightness),
          locale: settings.locale == 'system' ? null : Locale(settings.locale),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
          ],
        );
      },
    );
  }
}
