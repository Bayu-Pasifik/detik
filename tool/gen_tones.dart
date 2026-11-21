// Membuat nada alarm sintetis (domain publik, dibuat sendiri) ke assets/audio.
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

void writeWav(String path, List<double> s, int rate) {
  final data = ByteData(44 + s.length * 2);
  void str(int o, String t) {
    for (var i = 0; i < t.length; i++) {
      data.setUint8(o + i, t.codeUnitAt(i));
    }
  }
  str(0, 'RIFF');
  data.setUint32(4, 36 + s.length * 2, Endian.little);
  str(8, 'WAVEfmt ');
  data.setUint32(16, 16, Endian.little);
  data.setUint16(20, 1, Endian.little);
  data.setUint16(22, 1, Endian.little);
  data.setUint32(24, rate, Endian.little);
  data.setUint32(28, rate * 2, Endian.little);
  data.setUint16(32, 2, Endian.little);
  data.setUint16(34, 16, Endian.little);
  str(36, 'data');
  data.setUint32(40, s.length * 2, Endian.little);
  for (var i = 0; i < s.length; i++) {
    data.setInt16(44 + i * 2, (s[i].clamp(-1.0, 1.0) * 32000).round(), Endian.little);
  }
  File(path).writeAsBytesSync(data.buffer.asUint8List());
}

List<double> melody(List<double> freqs, double noteLen, double total, int rate) {
  final out = List<double>.filled((total * rate).round(), 0);
  var t0 = 0.0;
  var i = 0;
  while (t0 < total) {
    final f = freqs[i % freqs.length];
    final n = (noteLen * rate).round();
    for (var k = 0; k < n; k++) {
      final idx = (t0 * rate).round() + k;
      if (idx >= out.length) break;
      final t = k / rate;
      final env = min(1.0, k / (rate * 0.01)) * exp(-3 * t / noteLen);
      out[idx] += env * (0.6 * sin(2 * pi * f * t) + 0.25 * sin(4 * pi * f * t));
    }
    t0 += noteLen;
    i++;
  }
  return out;
}

void main() {
  const r = 22050;
  writeWav('assets/audio/pagi.wav', melody([523.25, 659.25, 783.99, 1046.5], 0.35, 4.2, r), r);
  writeWav('assets/audio/bintang.wav', melody([880, 660, 880, 990, 660, 770], 0.25, 3.0, r), r);
  writeWav('assets/audio/komet.wav', melody([1318.5, 0.0001, 1318.5, 0.0001], 0.18, 1.44, r), r);
}
