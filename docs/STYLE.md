# STYLE — Detik

Panduan visual dan gerak. Berlaku untuk Flutter dan aset Rive.

## 1. Arah desain

Tenang, hangat, sedikit playful. Dominan gelap (aplikasi jam sering dipakai malam hari), dengan satu warna aksen yang dipakai hemat. Animasi Rive jadi pusat perhatian; elemen UI lain diam dan bersih supaya animasi menonjol.

Kata kunci: lembut, bulat, jelas, hidup.

## 1b. Tema "Tata Surya"

**Flip clock** (Flutter, bukan Rive)
- Dua kartu per pasangan digit (HH, MM). Detik opsional, kecil, di bawah.
- Kartu: warna `surfaceHigh`, radius 16, garis engsel tipis di tengah, digit `textPrimary` dengan angka tabular tebal (Space Grotesk 700), tinggi digit ±96 dp di portrait.
- Animasi balik: bagian atas berputar `rotateX` 0 sampai -90°, lalu bagian bawah 90° sampai 0°, total ±450 ms, `easeInOut`, perspektif 0,002. Gradien bayangan tipis selama balik.
- Hanya kartu yang digitnya berubah yang membalik. Saat "kurangi animasi" aktif, ganti dengan pergantian langsung.

**Orbit planet** (Rive, di belakang flip clock)
- 4 planet asli di orbit elips berbeda: Merkurius (periode ±40 detik), Venus (±55), Bumi (±70), Mars (±90). Searah supaya tenang.
- Warna siang: Merkurius abu-abu, Venus krem, Bumi biru-hijau, Mars merah bata. Di mode malam semuanya meredup dan bergeser hangat.
- Planet berada di area luar kartu jam, dan saat melintas di belakangnya opasitas turun ke 60% agar digit tetap terbaca.
- Bumi sebagai planet utama, dengan cincin/halo tipis berwarna `accent`; planet lain tanpa halo. Bintang kecil berkedip pelan.
- Alarm berbunyi: orbit mempercepat 3x, planet berdenyut mengikuti irama bunyi, siklus ≤ 2 detik.

**Mode malam (redup, transisi halus)**
- Satu nilai `nightFactor` 0–1 menggerakkan semuanya. Warna Flutter di-lerp antara palet siang dan palet malam; input `night` Rive diisi `nightFactor × 100`.
- Durasi 1,5 detik, `easeInOutCubic`. Pada pemicu otomatis saat aplikasi sedang terbuka, transisi tetap 1,5 detik; saat aplikasi dibuka, langsung ke nilai yang benar tanpa animasi.
- Efek: latar hampir hitam, kartu dan planet meredup ±35%, aksen berubah ke amber hangat, bintang muncul pelan. Hindari putih murni dan biru.
- Jangan mengubah kecerahan layar sistem tanpa izin; peredup tambahan lewat overlay hitam (maks 40%) di mode nakas.

## 2. Warna

Tema gelap (utama):

| Token | Hex | Pakai untuk |
|---|---|---|
| `bg` | `#0F1115` | Latar layar |
| `surface` | `#181B21` | Kartu, daftar alarm |
| `surfaceHigh` | `#222630` | Sheet, picker |
| `outline` | `#2E333F` | Garis pemisah |
| `textPrimary` | `#F2F4F8` | Teks utama |
| `textSecondary` | `#9AA3B2` | Label, keterangan |
| `accent` | `#FFB547` | Aksi utama, alarm aktif, jarum detik |
| `accentSoft` | `#3A2C14` | Latar aksen redup |
| `danger` | `#FF6B5E` | Hapus, tombol matikan alarm |
| `success` | `#5BD6A0` | Timer selesai |

Tema terang:

| Token | Hex |
|---|---|
| `bg` | `#FAF8F5` |
| `surface` | `#FFFFFF` |
| `surfaceHigh` | `#F1EDE6` |
| `outline` | `#E2DCD2` |
| `textPrimary` | `#17191F` |
| `textSecondary` | `#5E6676` |
| `accent` | `#E08A00` |
| `danger` | `#D8483B` |

Palet malam (redup, tujuan transisi `nightFactor` = 1):

| Token | Hex |
|---|---|
| `bg` | `#07080B` |
| `surface` | `#0E1014` |
| `surfaceHigh` | `#151820` |
| `outline` | `#1C2029` |
| `textPrimary` | `#C9B8A0` |
| `textSecondary` | `#8A847B` |
| `accent` | `#B8741A` |
| `danger` | `#B5473E` |

Aturan: aksen maksimal ±10% area layar. Kontras teks terhadap latar minimal 4.5:1. Palet yang sama dipakai di file Rive (lewat nilai warna tetap atau view model/Data Binding bila tersedia) agar tema gelap/terang konsisten.

## 3. Tipografi

- Angka waktu: **Space Grotesk** atau **Manrope** (tabular figures, `FontFeature.tabularFigures()` agar angka tidak bergoyang saat berubah).
- Teks UI: **Inter** atau **Manrope**.

| Gaya | Ukuran / berat | Pakai |
|---|---|---|
| `timeDisplay` | 72 / 300 | Jam digital Home |
| `timeLarge` | 40 / 400 | Waktu di kartu alarm |
| `titleLarge` | 22 / 600 | Judul layar |
| `titleMedium` | 16 / 600 | Label alarm |
| `body` | 14 / 400 | Isi |
| `caption` | 12 / 500 | Hari berulang, keterangan |

Hormati skala font sistem sampai 130%; layout tidak boleh patah.

## 4. Bentuk, jarak, elevasi

- Grid jarak 4 dp: 4, 8, 12, 16, 24, 32.
- Margin layar 20 dp.
- Radius: kartu 20, tombol 16, sheet atas 28, chip 999.
- Elevasi lewat perbedaan warna surface, bukan bayangan tebal. Bayangan hanya pada sheet (blur 24, opasitas 20%).
- Target sentuh minimal 48×48 dp.

## 5. Ikon

Satu set garis konsisten (Lucide atau Material Symbols Rounded, ketebalan 2). Ukuran 24 dp, 20 dp di chip. Ikon tidak berbeda gaya dengan ilustrasi Rive.

## 6. Komponen

- **Kartu alarm**: waktu besar kiri, label + hari berulang di bawahnya, toggle Rive kanan. Alarm nonaktif: teks 50% opasitas.
- **Toggle alarm** (Rive): bentuk pil, knob berupa matahari kecil/bulan; animasi pegas saat berpindah.
- **Tombol utama (FAB)**: bulat, warna `accent`, ikon plus, muncul dengan skala pegas.
- **Time picker** (Rive): roda jam/menit dengan snap, haptic ringan tiap langkah.
- **Bottom navigation**: 4 tab (Alarm, Jam, Timer, Stopwatch), indikator pil beranimasi, label selalu tampil.
- **Layar alarm berbunyi**: latar gelap penuh, orbit Rive berdenyut, flip clock besar, geser-untuk-matikan di bawah, tombol snooze sekunder.
- **Empty state**: ilustrasi Rive idle + satu kalimat + tombol buat alarm.

## 7. Gerak dan animasi

Prinsip: animasi punya tujuan (memberi umpan balik atau menjelaskan perubahan), tidak dekoratif berlebihan.

| Jenis | Durasi | Kurva |
|---|---|---|
| Umpan balik sentuh | 100–150 ms | `easeOut` |
| Transisi elemen | 200–300 ms | `easeOutCubic` |
| Transisi layar | 300–400 ms | `easeInOutCubic` |
| Pegas (toggle, FAB) | — | stiffness 400, damping 22 |
| Idle Rive (loop) | 3–6 s | linear/halus |

Aturan Rive:
- Pakai State Machine; semua perubahan lewat input, bukan memanggil animasi manual.
- Artboard persegi atau 4:3 sesuai tempat pakai; atur `Fit.contain` dan `Alignment.center`.
- Hindari mesh/bone berat; target < 150 KB per file.
- Animasi loop idle dijeda saat aplikasi di latar belakang dan saat layar mati.
- Mode "kurangi animasi" (`MediaQuery.disableAnimations`): tampilkan frame statis, hilangkan getar dan loop.
- Layar alarm boleh lebih ekspresif (getar, pulsa) tapi tetap ≤ 2 detik per siklus.

## 9. Haptik dan suara

- Haptic ringan pada snap picker dan toggle; haptic kuat pada alarm berbunyi (bila getar aktif).
- Suara UI tidak ada, kecuali alarm dan timer.

## 10. Aksesibilitas

- Semantics label pada jam analog ("Pukul 07.30"), toggle ("Alarm 07.30, aktif"), dan semua tombol.
- Jangan hanya memakai warna untuk status; sertakan ikon/teks.
- Alarm berbunyi dapat dimatikan tanpa geser (tombol besar alternatif) bila TalkBack aktif.

## 11. Penamaan aset

- Rive: `assets/rive/<nama>.riv`, artboard `Main`, state machine `SM`.
- Input: camelCase, sama persis dengan tabel di PRD bagian 5.
- Nada: `assets/audio/<nama>.mp3`.
