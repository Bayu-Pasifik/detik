# PRD — Detik (Aplikasi Jam & Alarm)

Nama kerja: **Detik**. Versi dokumen: 0.1 (2026-11-21). Status: draf untuk ditinjau.

## 1. Ringkasan

Detik adalah aplikasi jam dan alarm Android yang dibangun dengan Flutter. Tema visualnya "Tata Surya": jam berbentuk flip clock, planet mengorbit pelan di latar, dan mode malam yang meredup dengan transisi halus. Elemen interaktif (toggle alarm, orbit, layar alarm berbunyi, timer, stopwatch) memakai animasi Rive yang responsif terhadap state, bukan animasi statis. Flip clock dibuat langsung di Flutter agar presisi.

## 2. Tujuan dan non-tujuan

Tujuan:
- Alarm yang andal: bunyi tepat waktu, tetap jalan setelah reboot, tidak dibunuh sistem.
- Animasi Rive yang terasa hidup dan ringan (target 60 fps di perangkat menengah).
- Antarmuka sederhana, bisa dipakai satu tangan, cepat membuat alarm (maks 3 ketukan).
- Offline penuh, tanpa akun.

Non-tujuan (v1):
- Sinkronisasi cloud, akun, iOS, widget layar utama, wearable, alarm berbasis lokasi/tidur pintar.

## 3. Target pengguna

- Pengguna umum Android (Indonesia) yang ingin alarm cantik tapi tetap andal.
- Pelajar/pekerja yang butuh beberapa alarm dengan label dan pengulangan hari.

## 4. Fitur dan kebutuhan

### 4.1 Jam (Home)
- Flip clock besar (Flutter native): kartu jam dan menit, hanya digit yang berubah yang membalik; detik opsional dalam ukuran kecil. Sinkron dengan waktu sistem.
- Latar orbit planet (Rive): 4 planet asli (Merkurius, Venus, Bumi, Mars) mengorbit pelan di belakang jam tanpa menutupi digit.
- Tanggal, hari, zona waktu lokal.
- World clock: tambah/hapus kota, selisih jam, status siang/malam per kota lewat ikon.

### 4.1b Mode malam
- Dua mode: Siang (tema terang/gelap dari pengaturan) dan Malam (redup, hangat, minim cahaya biru).
- Perpindahan memakai satu nilai `nightFactor` 0–1 yang dianimasikan, sehingga warna Flutter dan animasi Rive berubah bersamaan dengan halus (±1,5 detik).
- Pemicu: otomatis menurut jadwal (default 19:00–05:30, bisa diatur), manual lewat tombol, atau mengikuti mode gelap sistem.
- Efek malam: latar hampir hitam, kartu dan planet meredup, aksen lebih hangat, bintang muncul pelan.
- Mode nakas (masuk v1): layar tetap menyala, overlay peredup tambahan, navigasi disembunyikan.

### 4.2 Alarm
- Daftar alarm: jam, label, hari berulang, toggle aktif.
- Buat/ubah/hapus alarm; pemilih waktu custom (bukan dialog bawaan) dengan animasi Rive.
- Pengulangan: sekali, harian, hari tertentu.
- Nada: beberapa nada bawaan + pilih dari perangkat; volume naik bertahap; getar on/off.
- Snooze (5/10/15 menit, bisa diatur) dan batas jumlah snooze.
- Layar alarm berbunyi (full-screen, tampil di atas kunci layar): flip clock tetap tampil, planet mempercepat orbit dan berdenyut, geser untuk matikan, tombol snooze.
- Teks "alarm berikutnya dalam X jam Y menit" saat alarm dibuat atau diaktifkan.
- Alarm tetap aktif setelah reboot dan setelah aplikasi dimatikan paksa dari recent apps.

### 4.3 Timer
- Pengaturan durasi, mulai/jeda/reset, beberapa timer paralel (maks 5).
- Animasi Rive: pasir/lingkaran progres yang berkurang sesuai sisa waktu.
- Notifikasi persisten dan bunyi saat selesai, walau aplikasi di latar belakang.

### 4.4 Stopwatch
- Mulai/jeda/reset, lap dengan selisih, animasi Rive pada tombol dan lingkaran detik.

### 4.5 Pengaturan
- Format 12/24 jam, hari pertama minggu, tema (terang/gelap/sistem), durasi snooze default, nada default, getar default.
- Panduan izin (notifikasi, alarm tepat waktu, full-screen intent, abaikan optimasi baterai).

## 5. Animasi Rive

| Aset (.riv) | Dipakai di | State machine / input |
|---|---|---|
| `orbit_system.riv` | Latar Home dan layar alarm | `night` (number 0–100), `ringing` (bool), `speed` (number) |
| `alarm_toggle.riv` | Daftar alarm | `isOn` (bool), trigger `tap` |
| `time_picker.riv` | Buat alarm | `hour`, `minute` (number), `isAm` (bool) |
| `timer_progress.riv` | Timer | `progress` (number 0–100), `running` (bool), trigger `done` |
| `stopwatch.riv` | Stopwatch | `running` (bool), trigger `lap`, `reset` |
| `empty_state.riv` | Daftar alarm kosong | loop idle |

Aturan:
- Semua aset memakai State Machine dengan input bernama (tidak mengandalkan timeline linear).
- Satu file `.riv` ≤ 150 KB; total aset ≤ 1 MB.
- Hormati pengaturan aksesibilitas "kurangi animasi": tampilkan pose statis/frame akhir.
- Aset diambil dari Rive Community; kode menyesuaikan nama input file, dan tabel di atas diperbarui mengikuti file yang dipilih. Sumber dan lisensi dicatat di `assets/rive/CREDITS.md`.
- Input `night` pada semua aset Rive diisi dari `nightFactor` yang sama dengan tema Flutter. Bila file komunitas tidak punya input malam, redupkan dari Flutter (ColorFiltered/opacity).
- Jika tidak ada file orbit yang cocok, pakai orbit `CustomPainter` sementara dan ganti ke Rive belakangan.

## 6. Kebutuhan non-fungsional

- Keandalan: alarm bunyi dalam toleransi ≤ 1 detik dari waktu terjadwal pada Android 8–15.
- Performa: cold start < 2 detik; animasi tidak jatuh di bawah 55 fps di perangkat kelas menengah.
- Baterai: tidak ada wake lock tanpa alarm aktif.
- Privasi: tidak ada pengumpulan data, tidak ada jaringan.
- Aksesibilitas: target sentuh ≥ 48 dp, kontras WCAG AA, label semantik pada semua kontrol, dukungan skala font sistem.
- Lokalisasi: Bahasa Indonesia dan Inggris (string via ARB).

## 5b. Batasan platform Android (risiko utama)

- Android 12+ perlu izin `SCHEDULE_EXACT_ALARM` / `USE_EXACT_ALARM`; Android 13+ perlu `POST_NOTIFICATIONS`; Android 14+ membatasi `USE_FULL_SCREEN_INTENT`.
- Pabrikan tertentu (Xiaomi, Oppo, Vivo, Samsung) mematikan proses latar; butuh panduan whitelist baterai.
- Alarm harus dijadwal ulang saat `BOOT_COMPLETED`, perubahan zona waktu, dan perubahan jam sistem.

## 7. Arsitektur singkat

- Flutter + Dart, state management Riverpod.
- Penyimpanan lokal: Drift (SQLite) atau Isar untuk alarm, timer, kota.
- Penjadwalan: `AlarmManager.setAlarmClock` lewat plugin (mis. paket `alarm`) atau kanal platform sendiri; layar alarm via full-screen intent.
- Rive: paket `rive`, satu controller per aset, input state machine diset dari state aplikasi.
- Struktur folder: `lib/features/{clock,alarm,timer,stopwatch,settings}`, `lib/core/{theme,rive,db,notifications}`.

## 8. Metrik keberhasilan

- 99% alarm uji berbunyi tepat waktu pada matriks 6 perangkat/OS.
- Alarm dibuat dalam ≤ 3 ketukan dari Home.
- Tidak ada crash pada uji 24 jam alarm berulang.
- Ukuran APK rilis < 40 MB.

## 9. Rilis

- v0.1: Flip clock + orbit planet + mode malam + alarm dasar + aset Rive orbit dan toggle.
- v0.5: Timer, stopwatch, world clock, pengaturan.
- v1.0: Poles, aksesibilitas, lokalisasi, uji perangkat nyata, rilis GitHub (APK bertanda tangan).

## 10. Pertanyaan terbuka

Sudah diputuskan:
- Aset Rive dari Rive Community (periksa lisensi, catat di `CREDITS.md`).
- Android saja untuk v1; pilih plugin alarm yang mendukung iOS agar pintu tetap terbuka.
- Nada alarm bebas royalti (Freesound CC0, Pixabay, Mixkit), sekitar 5 nada bawaan.

- Jadwal malam default 19:00–05:30.
- Mode nakas masuk v1.
- Planet asli, 4 planet dalam (Merkurius, Venus, Bumi, Mars); Bumi sebagai planet aksen.

Masih terbuka:
1. Perlu tambahan Jupiter/Saturnus sebagai opsi pengaturan? (default tetap 4 planet)
