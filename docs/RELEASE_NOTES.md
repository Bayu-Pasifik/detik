# Detik 1.0.0-rc.1

Aplikasi alarm dan jam Android bertema tata surya.

## Fitur
- **Alarm**: sekali, harian, atau hari tertentu; label, nada, getar, tunda (5–30 menit); volume naik bertahap; layar bunyi penuh dengan geser untuk mematikan.
- **Jam**: flip clock, 4 planet asli (Merkurius, Venus, Bumi, Mars) mengorbit di latar, jam dunia (40 kota), mode nakas.
- **Mode malam**: transisi redup 1,5 detik, otomatis lewat jadwal, manual, atau mengikuti mode gelap sistem.
- **Timer** (beberapa timer, notifikasi berjalan, tahan app ditutup) dan **Stopwatch** (presisi 10 ms, lap).
- Bahasa Indonesia dan Inggris, format 12/24 jam, mode kurangi animasi.
- Panduan izin dan baterai per pabrikan agar alarm tidak dihentikan sistem.

## Pasang
Unduh APK sesuai perangkat: `arm64-v8a` untuk hampir semua ponsel modern, `armeabi-v7a` untuk ponsel lama 32-bit, `x86_64` untuk emulator.

## Batasan yang diketahui (rc)
- Belum diuji di perangkat nyata (hanya emulator Android 17). Mohon uji alarm semalam penuh dan setelah reboot sebelum diandalkan.
- Jika aplikasi dihentikan paksa (force-stop), Android membatalkan semua alarm.
- Tombol Tunda belum ada di notifikasi alarm (hanya Matikan).
- Toggle alarm, picker waktu, dan progres timer memakai widget Flutter, bukan animasi Rive (aset Rive belum tersedia).
- Alarm pada perangkat Xiaomi/Oppo/Samsung perlu izin baterai dan mulai otomatis diaktifkan manual.

## Lisensi aset
Lihat `assets/rive/CREDITS.md` (animasi orbit CC BY). Nada alarm dibuat sendiri.
