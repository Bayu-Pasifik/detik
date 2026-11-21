import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/l10n.dart';
import '../../core/providers.dart';
import '../../core/theme/detik_colors.dart';
import 'cities.dart';

Future<void> showAddCitySheet(BuildContext context, WidgetRef ref) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (_) => const _AddCitySheet(),
  );
}

class _AddCitySheet extends ConsumerStatefulWidget {
  const _AddCitySheet();

  @override
  ConsumerState<_AddCitySheet> createState() => _AddCitySheetState();
}

class _AddCitySheetState extends ConsumerState<_AddCitySheet> {
  String _q = '';

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final c = context.colors;
    final list = kCities
        .where((e) =>
            e.$1.toLowerCase().contains(_q.toLowerCase()) ||
            e.$2.toLowerCase().contains(_q.toLowerCase()))
        .toList();
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.7,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
              child: TextField(
                autofocus: false,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: l.clockSearchCity,
                  filled: true,
                  fillColor: c.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (v) => setState(() => _q = v),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, i) {
                  final e = list[i];
                  return ListTile(
                    title: Text(e.$1),
                    subtitle: Text(e.$2),
                    onTap: () async {
                      await ref.read(databaseProvider).addWorldClock(e.$1, e.$2);
                      if (context.mounted) Navigator.of(context).pop();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
