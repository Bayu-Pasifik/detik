# Detik

Aplikasi jam dan alarm Android (Flutter) bertema "Tata Surya": flip clock, planet mengorbit di latar, dan mode malam yang meredup dengan transisi halus. Animasi memakai Rive.

Status: tahap awal. Baru ada dokumen perencanaan dan aplikasi uji kecil yang memutar orbit planet di emulator. Fitur jam, alarm, timer, dan stopwatch belum dibuat.

## Dokumen

- [docs/PRD.md](docs/PRD.md): kebutuhan produk dan fitur
- [docs/STYLE.md](docs/STYLE.md): panduan visual dan gerak
- [docs/TASKS.md](docs/TASKS.md): daftar tugas per fase

## Menjalankan

```bash
flutter pub get
flutter run -d <id-perangkat>
```

Catatan build: `android/gradle.properties` mematikan `kotlin.incremental` karena plugin `rive_native` gagal di cache inkremental Kotlin saat proyek dan cache pub berada di drive berbeda (Windows).

## Aset dan kredit

Aset Rive dan lisensinya dicatat di [assets/rive/CREDITS.md](assets/rive/CREDITS.md).
