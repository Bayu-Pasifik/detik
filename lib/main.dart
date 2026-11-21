import 'package:material_ui/material_ui.dart';
import 'package:rive/rive.dart';

// Aplikasi uji sementara: memutar assets/rive/orbit_system.riv di belakang jam.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await RiveNative.init();
  runApp(const OrbitTestApp());
}

class OrbitTestApp extends StatelessWidget {
  const OrbitTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const OrbitTestPage(),
    );
  }
}

class OrbitTestPage extends StatefulWidget {
  const OrbitTestPage({super.key});

  @override
  State<OrbitTestPage> createState() => _OrbitTestPageState();
}

class _OrbitTestPageState extends State<OrbitTestPage> {
  File? _file;
  Artboard? _artboard;
  final _painter = RivePainter.animation('Animation 1', fit: Fit.cover);
  String _info = 'memuat...';
  double _night = 0;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final file = await File.asset(
        'assets/rive/orbit_system.riv',
        riveFactory: Factory.rive,
      );
      if (file == null) {
        setState(() => _info = 'file null');
        return;
      }
      // File tidak punya State Machine, jadi putar animasi linear langsung.
      final artboard = file.defaultArtboard();
      if (artboard == null) {
        setState(() => _info = 'artboard null');
        return;
      }
      setState(() {
        _file = file;
        _artboard = artboard;
        _info = 'artboard=${artboard.name} (animasi linear "Animation 1")';
      });
    } catch (e) {
      setState(() => _info = 'error: $e');
    }
  }

  @override
  void dispose() {
    _painter.dispose();
    _artboard?.dispose();
    _file?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final artboard = _artboard;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          if (artboard != null)
            RiveArtboardWidget(artboard: artboard, painter: _painter),
          // Peredup malam uji dari Flutter.
          IgnorePointer(
            child: ColoredBox(
              color: Colors.black.withValues(alpha: 0.6 * _night),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                // Jam di sepertiga atas supaya matahari (pusat orbit) tidak
                // menimpa digit.
                const Spacer(flex: 1),
                const Text(
                  '07:30',
                  style: TextStyle(fontSize: 96, fontWeight: FontWeight.w700),
                ),
                const Spacer(flex: 3),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(_info, textAlign: TextAlign.center),
                ),
                Slider(
                  value: _night,
                  onChanged: (v) => setState(() => _night = v),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
