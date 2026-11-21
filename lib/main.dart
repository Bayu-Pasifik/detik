import 'package:flutter/widgets.dart';
import 'package:alarm/alarm.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rive/rive.dart' show RiveNative;
import 'package:timezone/data/latest.dart' as tzdata;

import 'app.dart';
import 'core/db/database.dart' show AppDatabase;
import 'features/timer/timer_providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tzdata.initializeTimeZones();
  await RiveNative.init();
  await Alarm.init();
  await TimerService.initNotifications();
  TimerService(AppDatabase()).reconcile();
  runApp(const ProviderScope(child: DetikApp()));
}
