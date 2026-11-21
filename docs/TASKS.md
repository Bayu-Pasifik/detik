# TASKS — Detik

Centang `[x]` saat selesai. Urutan = urutan pengerjaan. Estimasi: S ≤ 0,5 hari, M ≈ 1 hari, L ≈ 2–3 hari.

## Fase 0 — Persiapan
- [x] T0.1 (S) Buat proyek Flutter `detik` (Android, `com.detik`). Sisa: ikon sementara dan min SDK 26 belum diatur.
- [x] T0.2 (S) Dependensi: `drift`, `drift_flutter`, `go_router`, `alarm`, `flutter_local_notifications`, `permission_handler`, `timezone`, `flutter_timezone`, `shared_preferences`, `drift_dev`, `build_runner`. minSdk 26, compileSdk 37, desugaring aktif, izin alarm/notifikasi di manifest.
- [x] T0.3 (S) Susun struktur folder `lib/features/*` dan `lib/core/*` (folder sudah ada, masih kosong); atur lint dan `flutter analyze` bersih (bersih: impor diganti ke `material_ui`).
- [x] T0.4 (S) Siapkan tema dari STYLE.md (token warna, tipografi, terang/gelap) di `lib/core/theme`. Selesai: `DetikColors` (ThemeExtension + lerp siang/malam), `DetikTheme`, test lerp.
- [x] T0.5 (M) Aset Rive v0.1 — Keputusan: orbit `CustomPainter` (planet asli); nada alarm sintetis buatan sendiri. `orbit_system.riv` dipakai sebagai ilustrasi empty state. Belum ada file Rive `alarm_toggle`/`stopwatch`/`timer_progress` (diganti widget Flutter).
- [x] T0.6 (S) Spike alarm 1 menit: di emulator (API 37) alarm bunyi dengan app di latar (foreground service + notifikasi). Perangkat nyata: belum diuji (butuh Anda). Force-stop membatalkan alarm (perilaku Android).

## Fase 1 — Fondasi
- [x] T1.1 (M) Wrapper Rive `core/rive`: widget yang memuat `.riv`, menyediakan akses input, dispose benar, dukung "kurangi animasi" — `lib/core/rive/rive_view.dart`: memuat `.riv`, dispose benar, beku saat "kurangi animasi". Teruji di empty state (emulator). Akses input State Machine belum ada karena belum ada aset yang butuh.
- [x] T1.2 (M) Skema DB: tabel `alarms`, `timers`, `world_clocks`, `settings`; repository + test — drift: tabel `alarms`, `timers`, `world_clocks`, `settings`; test `test/core/db_test.dart`.
- [x] T1.3 (S) Navigasi: bottom nav 4 tab dengan go_router, transisi sesuai STYLE.md — go_router + bottom nav 4 tab, transisi fade/slide. Teruji di emulator.
- [x] T1.4 (S) Lokalisasi ID/EN (ARB) dan format waktu 12/24 jam — ARB ID/EN (`tool/gen_arb.dart` ke `lib/l10n`), format 12/24 jam. ID teruji di emulator.
- [x] T1.5 (M) Layanan izin: notifikasi, alarm tepat waktu, full-screen intent, optimasi baterai; layar panduan — Layar izin: notifikasi, alarm tepat waktu, layar penuh (Android 14+), baterai + panduan Xiaomi/Samsung/Oppo; banner di tab Alarm. Teruji di emulator.

## Fase 2 — Jam (Home)
- [x] T2.1 (M) Provider waktu (tick per detik, hemat baterai) dan jam digital dengan angka tabular — `clockProvider` berdetak tepat per detik; teruji.
- [x] T2.2 (L) Flip clock Flutter: kartu atas/bawah, animasi `rotateX` ±450 ms, hanya digit berubah yang membalik, angka tabular, mode "kurangi animasi", test widget/golden — `FlipClock`: rotateX 450 ms, hanya digit berubah, mode kurangi animasi, test widget. Golden belum.
- [x] T2.3 (M) Orbit planet Rive di latar Home (Merkurius, Venus, Bumi, Mars; cari file yang planetnya terpisah agar bisa diatur): pasang `orbit_system`, atur `speed`, jaga kontras digit saat planet lewat di belakang jam; fallback `CustomPainter` bila aset belum ada — `OrbitPainter` (CustomPainter): Merkurius/Venus/Bumi/Mars periode 40/55/70/90 s, planet turun ke 60% opasitas di belakang jam, 3x + denyut saat alarm. Teruji di emulator.
- [x] T2.4 (M) World clock: tambah/hapus kota, daftar zona waktu, selisih jam, ikon siang/malam — Tambah/hapus kota (40 kota), selisih jam, ikon siang/malam. Tambah teruji di emulator.
- [x] T2.5 (M) `NightController`: nilai `nightFactor` 0–1 teranimasi (1,5 detik, `easeInOutCubic`), pemicu jadwal otomatis, manual, dan ikut mode gelap sistem; langsung ke nilai benar saat aplikasi dibuka — Animasi 1,5 dtk `easeInOutCubic` di `DetikApp`; mode auto/on/off/sistem; langsung ke nilai benar saat dibuka. Transisi malam ke siang teruji di emulator.
- [x] T2.6 (M) Tema siang ke malam: `ThemeExtension` dengan `lerp` antar palet (STYLE.md), semua layar membaca warna dari sana — `DetikColors.lerp` antara palet siang dan malam; semua layar membaca dari tema.
- [x] T2.7 (S) Sinkron `nightFactor` ke input `night` Rive; fallback peredup Flutter bila aset tidak punya input malam — Karena orbit `CustomPainter`, `nightFactor` dibaca langsung oleh painter (tidak ada input Rive).
- [x] T2.8 (M) Mode nakas (v1): layar tetap menyala, overlay peredup maks 40%, sembunyikan navigasi — Mode nakas: layar menyala (wakelock), immersive, overlay 40%, keluar dengan ketuk dua kali. Teruji di emulator.
- [x] T2.9 (S) Test unit `NightController` (jadwal lintas tengah malam, perubahan zona waktu) dan transisi tema — Test `night_logic_test.dart` (lintas tengah malam, ganti zona waktu) dan lerp tema.

## Fase 3 — Alarm inti
- [x] T3.1 (M) Daftar alarm: kartu, toggle Rive, empty state Rive, hapus geser — Daftar alarm, toggle matahari/bulan (Flutter, bukan Rive), empty state Rive, geser hapus + urungkan. Teruji.
- [x] T3.2 (L) Buat/ubah alarm: time picker Rive, label, hari berulang, nada, getar, snooze — Editor: roda jam/menit (Flutter, haptik), label, hari, nada, getar, tunda. Teruji. Bukan Rive.
- [x] T3.3 (L) Penjadwal: hitung pemicu berikutnya (sekali/harian/hari tertentu), jadwalkan dengan alarm tepat waktu, batalkan saat dinonaktifkan/dihapus — Jadwal 7 pemicu ke depan per alarm berulang (`AlarmService`); sekali/harian/hari tertentu; batal saat nonaktif/hapus. Bunyi teruji di emulator.
- [ ] T3.4 (M) Jadwal ulang saat reboot, ganti zona waktu, ganti jam sistem **(sebagian)** — Sinkron ulang saat app dibuka/dilanjutkan (zona waktu/jam). Reboot mengandalkan plugin `alarm`; BELUM diuji reboot nyata.
- [x] T3.5 (L) Layar alarm berbunyi: full-screen di atas kunci layar, orbit Rive dengan input `ringing`, flip clock, geser matikan, snooze, volume naik bertahap, getar — Layar bunyi: orbit 3x, flip clock, geser matikan, snooze, volume naik 15 dtk, getar. Teruji di emulator. Tampil di atas kunci layar belum diuji.
- [x] T3.6 (S) Teks "alarm berikutnya dalam…" di snackbar dan di header daftar — Snackbar "alarm berbunyi dalam ..." dan header daftar. Teruji.
- [ ] T3.7 (M) Notifikasi alarm (heads-up) sebagai cadangan saat full-screen diblokir; aksi snooze/matikan dari notifikasi **(sebagian)** — Notifikasi heads-up dengan tombol Matikan dari plugin; tombol Tunda di notifikasi belum ada.
- [ ] T3.8 (M) Test unit penghitung pemicu (lintas hari, DST tidak berlaku, ganti zona) dan test widget daftar alarm **(sebagian)** — Test penghitung pemicu lengkap (`trigger_test.dart`); test widget daftar alarm belum.

## Fase 4 — Timer dan stopwatch
- [x] T4.1 (M) Mesin timer berbasis waktu absolut (bukan hitung mundur per tick), tahan app di latar — Timer berbasis `endsAtMs`; teruji.
- [x] T4.2 (L) UI timer: pengaturan durasi, beberapa timer, Rive `timer_progress`, notifikasi persisten, bunyi selesai — Beberapa timer, cincin progres (Flutter), notifikasi persisten chronometer, bunyi selesai lewat layar bunyi. Teruji di emulator.
- [x] T4.3 (M) Stopwatch: mulai/jeda/reset/lap, Rive `stopwatch`, presisi per 10 ms, tahan rotasi layar — Stopwatch 10 ms, lap, tahan rotasi. Teruji di emulator.
- [x] T4.4 (S) Test unit mesin timer dan stopwatch — `timer_engine_test.dart`.

## Fase 5 — Pengaturan dan poles
- [x] T5.1 (M) Layar pengaturan: tema, format jam, snooze default, nada default, getar default — Tema, bahasa, 24 jam, kurangi animasi, mode malam, bawaan alarm. Teruji, tersimpan setelah restart.
- [ ] T5.2 (M) Pemilih nada: bawaan + dari perangkat, pratinjau, simpan URI **(sebagian)** — Pemilih nada: 3 bawaan + dari perangkat + pratinjau. Belum diuji di emulator.
- [ ] T5.3 (M) Aksesibilitas: Semantics, TalkBack, skala font 130%, mode kurangi animasi, alternatif geser **(sebagian)** — Semantics pada flip clock/roda/geser matikan; ketuk sebagai alternatif geser. Belum diuji dengan TalkBack/skala font 130%.
- [ ] T5.4 (M) Performa: profil animasi di perangkat menengah, jeda Rive saat latar belakang, cek ukuran aset. **(sebagian)** — Ticker Flutter berhenti otomatis saat app di latar; aset kecil (orbit .riv 1,2 KB, 3 nada WAV 380 KB); APK arm64 29,6 MB. Profil di perangkat menengah BELUM dilakukan.
- [x] T5.5 (S) Haptik pada picker/toggle — Haptik pada roda, chip, toggle, navigasi.

## Fase 6 — Uji dan rilis
- [ ] T6.1 (L) Uji matriks perangkat: Android 8, 10, 12, 13, 14, 15 termasuk Xiaomi/Samsung/Oppo; catat kegagalan alarm. **(sebagian)** — BELUM bisa: hanya ada emulator Android 17 (API 37). Matriks Android 8-15 dan Xiaomi/Samsung/Oppo butuh perangkat nyata (tugas pemilik).
- [ ] T6.2 (M) Uji 24 jam alarm berulang dan uji reboot/force-stop/mode hemat baterai. **(sebagian)** — BELUM: uji 24 jam, reboot, force-stop, dan mode hemat baterai butuh perangkat nyata. Diketahui: force-stop Android membatalkan alarm.
- [x] T6.3 (S) Panduan whitelist baterai per pabrikan di dalam aplikasi. — Panduan baterai per pabrikan (Xiaomi, Samsung, Oppo/Realme/OnePlus, lainnya) di layar Izin; teruji di emulator.
- [x] T6.4 (S) Ikon adaptif, splash, nama aplikasi, deskripsi. — Ikon adaptif tata surya (`tool/gen_icon.dart`), splash warna `#0F1115`, nama "Detik", deskripsi di pubspec. Teruji di emulator.
- [x] T6.5 (M) Konfigurasi rilis: keystore, ProGuard/R8, `flutter build apk --release`, verifikasi tanda tangan dan versi. — Keystore lokal (`android/detik-release.jks`, TIDAK di-commit), R8 + shrink resources, `flutter build apk --release --split-per-abi`; tanda tangan v2 terverifikasi (`apksigner verify`), versi 1.0.0+1. Build release diuji bunyi alarm di emulator.
- [x] T6.6 (S) Catatan rilis (ID), tag git, rilis GitHub dengan APK terlampir. — Catatan rilis `docs/RELEASE_NOTES.md`; tag `v1.0.0-rc.1`; pra-rilis GitHub dengan APK terlampir (rc karena T6.1/T6.2 belum dijalankan).

## Backlog (pasca v1.0)
- [ ] Widget layar utama, tantangan matikan alarm (hitung/QR), iOS, ekspor/impor alarm, tema tambahan.
