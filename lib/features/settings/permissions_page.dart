import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/l10n.dart';
import '../../core/permissions/permission_service.dart';
import '../../core/theme/detik_colors.dart';

/// Panduan izin: notifikasi, alarm tepat waktu, layar penuh, abaikan
/// optimasi baterai, plus petunjuk per pabrikan.
class PermissionsPage extends ConsumerStatefulWidget {
  const PermissionsPage({super.key});

  @override
  ConsumerState<PermissionsPage> createState() => _PermissionsPageState();
}

class _PermissionsPageState extends ConsumerState<PermissionsPage>
    with WidgetsBindingObserver {
  String _maker = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    ref.read(permissionServiceProvider).manufacturer().then((m) {
      if (mounted) setState(() => _maker = m);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // Segarkan status setelah pengguna kembali dari pengaturan sistem.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      ref.invalidate(permissionStateProvider);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final c = context.colors;
    final svc = ref.read(permissionServiceProvider);
    final st = ref.watch(permissionStateProvider).value;

    Widget item(String title, String body, bool ok, Future<void> Function() act) {
      return ListTile(
        leading: Icon(ok ? Icons.check_circle : Icons.error_outline,
            color: ok ? c.success : c.accent),
        title: Text(title),
        subtitle: Text(body),
        trailing: ok
            ? Text(l.permGranted, style: Theme.of(context).textTheme.labelSmall)
            : FilledButton.tonal(
                onPressed: () async {
                  await act();
                  ref.invalidate(permissionStateProvider);
                },
                child: Text(l.permGrant),
              ),
      );
    }

    String vendor() {
      if (_maker.contains('xiaomi') || _maker.contains('redmi') || _maker.contains('poco')) {
        return l.permVendorXiaomi;
      }
      if (_maker.contains('samsung')) return l.permVendorSamsung;
      if (_maker.contains('oppo') || _maker.contains('realme') || _maker.contains('oneplus')) {
        return l.permVendorOppo;
      }
      return l.permVendorOther;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l.permTitle),
        leading: BackButton(onPressed: () => context.pop()),
      ),
      body: st == null
          ? const SizedBox.shrink()
          : ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
                  child: Text(l.permIntro,
                      style: Theme.of(context).textTheme.bodyMedium),
                ),
                item(l.permNotification, l.permNotificationBody, st.notification,
                    svc.requestNotification),
                item(l.permExact, l.permExactBody, st.exactAlarm,
                    svc.requestExactAlarm),
                item(l.permFullScreen, l.permFullScreenBody, st.fullScreen,
                    svc.openFullScreenSettings),
                item(l.permBattery, l.permBatteryBody, st.battery,
                    svc.openBatterySettings),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
                  child: Text(l.permVendorTitle,
                      style: Theme.of(context).textTheme.titleMedium),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(vendor(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: c.textSecondary)),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: OutlinedButton(
                    onPressed: svc.openBatterySettings,
                    child: Text(l.permOpenSettings),
                  ),
                ),
              ],
            ),
    );
  }
}
