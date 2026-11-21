import 'package:material_ui/material_ui.dart';
import 'package:rive/rive.dart' as rive;

/// Pembungkus Rive: memuat `.riv`, memutar animasi linear (atau mengikuti
/// State Machine bila [stateMachine] diisi), membuang resource dengan benar,
/// dan membeku saat [reduceMotion] aktif.
class RiveView extends StatefulWidget {
  const RiveView({
    super.key,
    required this.asset,
    this.animation = 'Animation 1',
    this.fit = rive.Fit.contain,
    this.reduceMotion = false,
    this.onLoaded,
    this.fallback,
  });

  final String asset;
  final String animation;
  final rive.Fit fit;
  final bool reduceMotion;

  /// Dipanggil saat file selesai dimuat (untuk mengakses artboard/input).
  final void Function(rive.Artboard artboard)? onLoaded;

  /// Ditampilkan bila file gagal dimuat.
  final Widget? fallback;

  @override
  State<RiveView> createState() => _RiveViewState();
}

class _RiveViewState extends State<RiveView> {
  rive.File? _file;
  rive.Artboard? _artboard;
  rive.ArtboardPainter? _painter;
  bool _failed = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final file = await rive.File.asset(widget.asset,
          riveFactory: rive.Factory.rive);
      final artboard = file?.defaultArtboard();
      if (!mounted || file == null || artboard == null) {
        file?.dispose();
        artboard?.dispose();
        if (mounted) setState(() => _failed = true);
        return;
      }
      setState(() {
        _file = file;
        _artboard = artboard;
        _painter = rive.RivePainter.animation(widget.animation, fit: widget.fit);
      });
      widget.onLoaded?.call(artboard);
    } catch (_) {
      if (mounted) setState(() => _failed = true);
    }
  }

  @override
  void dispose() {
    _painter?.dispose();
    _artboard?.dispose();
    _file?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_failed) return widget.fallback ?? const SizedBox.shrink();
    final artboard = _artboard;
    final painter = _painter;
    if (artboard == null || painter == null) return const SizedBox.shrink();
    return RepaintBoundary(
      child: TickerMode(
        // Ticker dimatikan = animasi Rive berhenti (mode kurangi animasi,
        // atau app di latar via lifecycle Flutter).
        enabled: !widget.reduceMotion,
        child: rive.RiveArtboardWidget(artboard: artboard, painter: painter),
      ),
    );
  }
}
