# TASKS — Detik

Centang `[x]` saat selesai. Urutan = urutan pengerjaan. Estimasi: S ≤ 0,5 hari, M ≈ 1 hari, L ≈ 2–3 hari.

## Fase 0 — Persiapan
- [x] T0.1 (S) Buat proyek Flutter `detik` (Android, `com.detik`). Sisa: ikon sementara dan min SDK 26 belum diatur.
- [ ] T0.2 (S) Tambah dependensi. Sudah: `rive`, `flutter_riverpod`, `intl`. Sisa: `drift`/`isar`, `go_router`, paket alarm/notifikasi, `permission_handler`.
- [x] T0.3 (S) Susun struktur folder `lib/features/*` dan `lib/core/*` (folder sudah ada, masih kosong); atur lint dan `flutter analyze` bersih (bersih: impor diganti ke `material_ui`).
- [x] T0.4 (S) Siapkan tema dari STYLE.md (token warna, tipografi, terang/gelap) di `lib/core/theme`. Selesai: `DetikColors` (ThemeExtension + lerp siang/malam), `DetikTheme`, test lerp.
- [ ] T0.5 (M) Aset Rive v0.1. Sudah: `orbit_system.riv` (abigailpaulette, CC BY) diunduh, dicatat di `CREDITS.md`, dan terbukti berjalan di emulator. Temuan: file hanya punya animasi linear "Animation 1" (tanpa State Machine/input), diputar lewat `RivePainter.animation` + `RiveArtboardWidget`; planet bukan planet asli; matahari di tengah perlu dijauhkan dari flip clock. Sisa: pilih `alarm_toggle` dan `empty_state`; putuskan orbit pakai file ini (redup dari Flutter) atau `CustomPainter` untuk planet asli.
- [ ] T0.6 (S) Spike teknis: jadwalkan satu alarm 1 menit ke depan, bunyi saat app dimatikan, di emulator dan 1 perangkat nyata.

## Fase 1 — Fondasi
- [ ] T1.1 (M) Wrapper Rive `core/rive`: widget yang memuat `.riv`, menyediakan akses input, dispose benar, dukung "kurangi animasi".
- [ ] T1.2 (M) Skema DB: tabel `alarms`, `timers`, `world_clocks`, `settings`; repository + test.
- [ ] T1.3 (S) Navigasi: bottom nav 4 tab dengan go_router, transisi sesuai STYLE.md.
- [ ] T1.4 (S) Lokalisasi ID/EN (ARB) dan format waktu 12/24 jam.
- [ ] T1.5 (M) Layanan izin: notifikasi, alarm tepat waktu, full-screen intent, optimasi baterai; layar panduan.

## Fase 2 — Jam (Home)
- [ ] T2.1 (M) Provider waktu (tick per detik, hemat baterai) dan jam digital dengan angka tabular.
- [ ] T2.2 (L) Flip clock Flutter: kartu atas/bawah, animasi `rotateX` ±450 ms, hanya digit berubah yang membalik, angka tabular, mode "kurangi animasi", test widget/golden.
- [ ] T2.3 (M) Orbit planet Rive di latar Home (Merkurius, Venus, Bumi, Mars; cari file yang planetnya terpisah agar bisa diatur): pasang `orbit_system`, atur `speed`, jaga kontras digit saat planet lewat di belakang jam; fallback `CustomPainter` bila aset belum ada.
- [ ] T2.4 (M) World clock: tambah/hapus kota, daftar zona waktu, selisih jam, ikon siang/malam.
- [ ] T2.5 (M) `NightController`: nilai `nightFactor` 0–1 teranimasi (1,5 detik, `easeInOutCubic`), pemicu jadwal otomatis, manual, dan ikut mode gelap sistem; langsung ke nilai benar saat aplikasi dibuka.
- [ ] T2.6 (M) Tema siang ke malam: `ThemeExtension` dengan `lerp` antar palet (STYLE.md), semua layar membaca warna dari sana.
- [ ] T2.7 (S) Sinkron `nightFactor` ke input `night` Rive; fallback peredup Flutter bila aset tidak punya input malam.
- [ ] T2.8 (M) Mode nakas (v1): layar tetap menyala, overlay peredup maks 40%, sembunyikan navigasi.
- [ ] T2.9 (S) Test unit `NightController` (jadwal lintas tengah malam, perubahan zona waktu) dan transisi tema.

## Fase 3 — Alarm inti
- [ ] T3.1 (M) Daftar alarm: kartu, toggle Rive, empty state Rive, hapus geser.
- [ ] T3.2 (L) Buat/ubah alarm: time picker Rive, label, hari berulang, nada, getar, snooze.
- [ ] T3.3 (L) Penjadwal: hitung pemicu berikutnya (sekali/harian/hari tertentu), jadwalkan dengan alarm tepat waktu, batalkan saat dinonaktifkan/dihapus.
- [ ] T3.4 (M) Jadwal ulang saat reboot, ganti zona waktu, ganti jam sistem.
- [ ] T3.5 (L) Layar alarm berbunyi: full-screen di atas kunci layar, orbit Rive dengan input `ringing`, flip clock, geser matikan, snooze, volume naik bertahap, getar.
- [ ] T3.6 (S) Teks "alarm berikutnya dalam…" di snackbar dan di header daftar.
- [ ] T3.7 (M) Notifikasi alarm (heads-up) sebagai cadangan saat full-screen diblokir; aksi snooze/matikan dari notifikasi.
- [ ] T3.8 (M) Test unit penghitung pemicu (lintas hari, DST tidak berlaku, ganti zona) dan test widget daftar alarm.

## Fase 4 — Timer dan stopwatch
- [ ] T4.1 (M) Mesin timer berbasis waktu absolut (bukan hitung mundur per tick), tahan app di latar.
- [ ] T4.2 (L) UI timer: pengaturan durasi, beberapa timer, Rive `timer_progress`, notifikasi persisten, bunyi selesai.
- [ ] T4.3 (M) Stopwatch: mulai/jeda/reset/lap, Rive `stopwatch`, presisi per 10 ms, tahan rotasi layar.
- [ ] T4.4 (S) Test unit mesin timer dan stopwatch.

## Fase 5 — Pengaturan dan poles
- [ ] T5.1 (M) Layar pengaturan: tema, format jam, snooze default, nada default, getar default.
- [ ] T5.2 (M) Pemilih nada: bawaan + dari perangkat, pratinjau, simpan URI.
- [ ] T5.3 (M) Aksesibilitas: Semantics, TalkBack, skala font 130%, mode kurangi animasi, alternatif geser.
- [ ] T5.4 (M) Performa: profil animasi di perangkat menengah, jeda Rive saat latar belakang, cek ukuran aset.
- [ ] T5.5 (S) Haptik pada picker/toggle.

## Fase 6 — Uji dan rilis
- [ ] T6.1 (L) Uji matriks perangkat: Android 8, 10, 12, 13, 14, 15 termasuk Xiaomi/Samsung/Oppo; catat kegagalan alarm.
- [ ] T6.2 (M) Uji 24 jam alarm berulang dan uji reboot/force-stop/mode hemat baterai.
- [ ] T6.3 (S) Panduan whitelist baterai per pabrikan di dalam aplikasi.
- [ ] T6.4 (S) Ikon adaptif, splash, nama aplikasi, deskripsi.
- [ ] T6.5 (M) Konfigurasi rilis: keystore, ProGuard/R8, `flutter build apk --release`, verifikasi tanda tangan dan versi.
- [ ] T6.6 (S) Catatan rilis (ID), tag git, rilis GitHub dengan APK terlampir.

## Backlog (pasca v1.0)
- [ ] Widget layar utama, tantangan matikan alarm (hitung/QR), iOS, ekspor/impor alarm, tema tambahan.
