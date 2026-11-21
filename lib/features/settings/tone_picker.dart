import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:material_ui/material_ui.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../core/l10n.dart';
import '../../core/theme/detik_colors.dart';
import '../../l10n/app_localizations.dart';

const bundledTones = <String>[
  'assets/audio/pagi.wav',
  'assets/audio/bintang.wav',
  'assets/audio/komet.wav',
];

String toneName(AppLocalizations l, String path) {
  switch (path) {
    case 'assets/audio/pagi.wav':
      return l.tonePagi;
    case 'assets/audio/bintang.wav':
      return l.toneBintang;
    case 'assets/audio/komet.wav':
      return l.toneKomet;
    default:
      return p.basename(path);
  }
}

/// Menampilkan pemilih nada; mengembalikan path terpilih atau null bila batal.
Future<String?> pickTone(BuildContext context, String current) {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (_) => _TonePickerSheet(current: current),
  );
}

class _TonePickerSheet extends StatefulWidget {
  const _TonePickerSheet({required this.current});
  final String current;

  @override
  State<_TonePickerSheet> createState() => _TonePickerSheetState();
}

class _TonePickerSheetState extends State<_TonePickerSheet> {
  final _player = AudioPlayer();
  late String _selected = widget.current;
  String? _playing;

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Future<void> _preview(String path) async {
    await _player.stop();
    if (_playing == path) {
      setState(() => _playing = null);
      return;
    }
    setState(() => _playing = path);
    await _player.play(path.startsWith('assets/')
        ? AssetSource(path.substring('assets/'.length))
        : DeviceFileSource(path));
    _player.onPlayerComplete.first.then((_) {
      if (mounted) setState(() => _playing = null);
    });
  }

  Future<void> _pickFile() async {
    final res = await FilePicker.pickFiles(type: FileType.audio);
    final src = res.isEmpty ? null : res.first.path;
    if (src == null) return;
    // Salin ke penyimpanan internal supaya tetap bisa dibaca saat alarm.
    final dir = await getApplicationSupportDirectory();
    final dest = File(p.join(dir.path, 'tones', p.basename(src)));
    await dest.parent.create(recursive: true);
    await File(src).copy(dest.path);
    if (mounted) setState(() => _selected = dest.path);
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final c = context.colors;
    final all = [
      ...bundledTones,
      if (!bundledTones.contains(_selected)) _selected,
    ];
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 20, 8, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(l.alarmTone, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          for (final t in all)
            ListTile(
              leading: Icon(
                _selected == t
                    ? Icons.radio_button_checked
                    : Icons.radio_button_off,
                color: _selected == t ? c.accent : c.textSecondary,
              ),
              title: Text(toneName(l, t)),
              trailing: IconButton(
                tooltip: l.tonePreview,
                icon: Icon(_playing == t ? Icons.stop : Icons.play_arrow),
                onPressed: () => _preview(t),
              ),
              onTap: () => setState(() => _selected = t),
            ),
          ListTile(
            leading: const Icon(Icons.folder_open),
            title: Text(l.tonePick),
            onTap: _pickFile,
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => Navigator.of(context).pop(_selected),
                child: Text(l.save),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
