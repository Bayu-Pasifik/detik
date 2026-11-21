import 'package:alarm/alarm.dart';
import 'package:material_ui/material_ui.dart';
import 'package:permission_handler/permission_handler.dart';

// Spike T0.6: jadwalkan alarm 1 menit ke depan.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Alarm.init();
  runApp(const MaterialApp(home: Spike()));
}

class Spike extends StatefulWidget {
  const Spike({super.key});
  @override
  State<Spike> createState() => _SpikeState();
}

class _SpikeState extends State<Spike> {
  String log = 'siap';
  @override
  void initState() {
    super.initState();
    Alarm.ringStream.stream.listen((a) => setState(() => log = 'RING ${a.id}'));
  }

  Future<void> _go() async {
    await Permission.notification.request();
    await Permission.scheduleExactAlarm.request();
    final t = DateTime.now().add(const Duration(minutes: 1));
    final ok = await Alarm.set(
      alarmSettings: AlarmSettings(
        id: 42,
        dateTime: t,
        assetAudioPath: 'assets/audio/pagi.wav',
        notificationSettings: const NotificationSettings(
            title: 'Detik', body: 'Alarm uji', stopButton: 'Matikan'),
      ),
    );
    setState(() => log = 'set=$ok pada $t');
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text(log),
            FilledButton(onPressed: _go, child: const Text('Alarm 1 menit')),
          ]),
        ),
      );
}
