import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

const _channel = MethodChannel('detik/system');

class PermState {
  const PermState({
    required this.notification,
    required this.exactAlarm,
    required this.fullScreen,
    required this.battery,
  });
  final bool notification;
  final bool exactAlarm;
  final bool fullScreen;
  final bool battery;

  bool get allCritical => notification && exactAlarm && fullScreen;
}

class PermissionService {
  Future<PermState> read() async {
    final n = await Permission.notification.isGranted;
    final e = await Permission.scheduleExactAlarm.isGranted;
    final b = await Permission.ignoreBatteryOptimizations.isGranted;
    var f = true;
    try {
      f = await _channel.invokeMethod<bool>('canUseFullScreenIntent') ?? true;
    } catch (_) {}
    return PermState(notification: n, exactAlarm: e, fullScreen: f, battery: b);
  }

  Future<void> requestNotification() => Permission.notification.request();
  Future<void> requestExactAlarm() => Permission.scheduleExactAlarm.request();
  Future<void> openFullScreenSettings() =>
      _channel.invokeMethod('openFullScreenIntentSettings');
  Future<void> openBatterySettings() =>
      _channel.invokeMethod('openBatterySettings');

  Future<String> manufacturer() async {
    try {
      return (await _channel.invokeMethod<String>('manufacturer') ?? '')
          .toLowerCase();
    } catch (_) {
      return '';
    }
  }
}

final permissionServiceProvider = Provider((_) => PermissionService());

/// Status izin; panggil `ref.invalidate` setelah pengguna kembali dari
/// pengaturan sistem.
final permissionStateProvider = FutureProvider.autoDispose<PermState>(
  (ref) => ref.read(permissionServiceProvider).read(),
);
