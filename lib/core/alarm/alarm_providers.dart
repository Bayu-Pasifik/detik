import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../db/database.dart';
import '../providers.dart';
import 'alarm_service.dart';

final alarmServiceProvider =
    Provider((ref) => AlarmService(ref.watch(databaseProvider)));

final alarmsProvider = StreamProvider<List<Alarm>>(
    (ref) => ref.watch(databaseProvider).watchAlarms());
