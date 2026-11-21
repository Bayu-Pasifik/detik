// Membuat ikon aplikasi (tata surya mini) ke assets/icon/.
//   dart run tool/gen_icon.dart
import 'dart:io';
import 'dart:math' as math;

import 'package:image/image.dart' as img;

const size = 1024;

void disc(img.Image im, double cx, double cy, double r, img.Color c) {
  img.fillCircle(im, x: cx.round(), y: cy.round(), radius: r.round(), color: c);
}

/// Elips orbit tipis (digambar sebagai titik-titik rapat).
void orbit(img.Image im, double cx, double cy, double rx, double ry,
    img.Color c, int thick) {
  for (var a = 0.0; a < math.pi * 2; a += 0.0015) {
    final x = cx + math.cos(a) * rx;
    final y = cy + math.sin(a) * ry;
    img.fillCircle(im, x: x.round(), y: y.round(), radius: thick, color: c);
  }
}

void main() {
  Directory('assets/icon').createSync(recursive: true);

  // Latar penuh (untuk ikon non-adaptif).
  final bg = img.Image(width: size, height: size, numChannels: 4);
  img.fill(bg, color: img.ColorRgba8(0x0F, 0x11, 0x15, 255));

  // Foreground adaptif: transparan, konten di zona aman (66% tengah).
  final fg = img.Image(width: size, height: size, numChannels: 4);
  img.fill(fg, color: img.ColorRgba8(0, 0, 0, 0));
  const c = size / 2;
  orbit(fg, c, c, 270, 170, img.ColorRgba8(0x6E, 0x6A, 0x62, 255), 4);
  orbit(fg, c, c, 190, 118, img.ColorRgba8(0x6E, 0x6A, 0x62, 255), 4);
  // Matahari beraksen amber.
  disc(fg, c, c, 62, img.ColorRgba8(0xFF, 0xB5, 0x47, 80));
  disc(fg, c, c, 44, img.ColorRgba8(0xFF, 0xB5, 0x47, 255));
  // Planet kecil di orbit dalam, Bumi (teal + halo amber) di orbit luar.
  disc(fg, c - 190 * math.cos(0.9), c - 118 * math.sin(0.9), 20,
      img.ColorRgba8(0xE8, 0xD2, 0xA6, 255));
  final ex = c + 270 * math.cos(-0.5), ey = c + 170 * math.sin(-0.5);
  disc(fg, ex, ey, 40, img.ColorRgba8(0xFF, 0xB5, 0x47, 255));
  disc(fg, ex, ey, 33, img.ColorRgba8(0x0F, 0x11, 0x15, 255));
  disc(fg, ex, ey, 28, img.ColorRgba8(0x4F, 0x9D, 0xA6, 255));

  // Ikon penuh = latar + foreground.
  final full = img.Image.from(bg);
  img.compositeImage(full, fg);

  File('assets/icon/icon.png').writeAsBytesSync(img.encodePng(full));
  File('assets/icon/icon_foreground.png').writeAsBytesSync(img.encodePng(fg));
}
