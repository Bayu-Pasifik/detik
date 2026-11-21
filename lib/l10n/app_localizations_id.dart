// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appName => 'Detik';

  @override
  String get tabAlarm => 'Alarm';

  @override
  String get tabClock => 'Jam';

  @override
  String get tabTimer => 'Timer';

  @override
  String get tabStopwatch => 'Stopwatch';

  @override
  String get settings => 'Pengaturan';

  @override
  String get save => 'Simpan';

  @override
  String get cancel => 'Batal';

  @override
  String get delete => 'Hapus';

  @override
  String get add => 'Tambah';

  @override
  String get close => 'Tutup';

  @override
  String get undo => 'Urungkan';

  @override
  String get alarmEmptyTitle => 'Belum ada alarm';

  @override
  String get alarmEmptyBody =>
      'Buat alarm pertamamu dan biarkan planet menjagamu tetap tepat waktu.';

  @override
  String get alarmCreate => 'Buat alarm';

  @override
  String get alarmNew => 'Alarm baru';

  @override
  String get alarmEdit => 'Ubah alarm';

  @override
  String get alarmLabel => 'Label';

  @override
  String get alarmRepeat => 'Ulangi';

  @override
  String get alarmOnce => 'Sekali';

  @override
  String get alarmEveryDay => 'Setiap hari';

  @override
  String get alarmWeekdays => 'Hari kerja';

  @override
  String get alarmTone => 'Nada';

  @override
  String get alarmVibrate => 'Getar';

  @override
  String get alarmSnooze => 'Tunda';

  @override
  String alarmSnoozeMinutes(String n) {
    return '$n menit';
  }

  @override
  String get alarmDeleted => 'Alarm dihapus';

  @override
  String alarmNextIn(String t) {
    return 'Alarm berikutnya dalam $t';
  }

  @override
  String get alarmNoneActive => 'Tidak ada alarm aktif';

  @override
  String alarmSetIn(String t) {
    return 'Alarm berbunyi dalam $t';
  }

  @override
  String get alarmRinging => 'Alarm berbunyi';

  @override
  String get alarmSlideStop => 'Geser untuk mematikan';

  @override
  String get alarmStop => 'Matikan';

  @override
  String alarmSnoozeFor(String n) {
    return 'Tunda $n menit';
  }

  @override
  String get timerRinging => 'Timer selesai';

  @override
  String durationDays(String d) {
    return '$d hari';
  }

  @override
  String durationHours(String h) {
    return '$h jam';
  }

  @override
  String durationMinutes(String m) {
    return '$m menit';
  }

  @override
  String get dayMon => 'Sen';

  @override
  String get dayTue => 'Sel';

  @override
  String get dayWed => 'Rab';

  @override
  String get dayThu => 'Kam';

  @override
  String get dayFri => 'Jum';

  @override
  String get daySat => 'Sab';

  @override
  String get daySun => 'Min';

  @override
  String get clockAddCity => 'Tambah kota';

  @override
  String get clockSearchCity => 'Cari kota';

  @override
  String get clockNoCities => 'Tambahkan kota untuk melihat jam dunia';

  @override
  String clockHoursAhead(String h) {
    return '$h jam lebih awal';
  }

  @override
  String clockHoursBehind(String h) {
    return '$h jam lebih lambat';
  }

  @override
  String get clockSameTime => 'Waktu sama';

  @override
  String get clockDay => 'Siang';

  @override
  String get clockNight => 'Malam';

  @override
  String get nightstand => 'Mode nakas';

  @override
  String get nightstandExit => 'Ketuk dua kali untuk keluar';

  @override
  String get timerNew => 'Timer baru';

  @override
  String get timerStart => 'Mulai';

  @override
  String get timerPause => 'Jeda';

  @override
  String get timerResume => 'Lanjut';

  @override
  String get timerReset => 'Atur ulang';

  @override
  String get timerEmpty => 'Belum ada timer';

  @override
  String get timerLabelHint => 'Label (opsional)';

  @override
  String get timerHours => 'Jam';

  @override
  String get timerMinutes => 'Menit';

  @override
  String get timerSeconds => 'Detik';

  @override
  String get timerRunningNotif => 'Timer berjalan';

  @override
  String get timerDoneNotif => 'Timer selesai';

  @override
  String get stopwatchLap => 'Lap';

  @override
  String stopwatchLapN(String n) {
    return 'Lap $n';
  }

  @override
  String get stopwatchNoLaps => 'Belum ada lap';

  @override
  String get settingsAppearance => 'Tampilan';

  @override
  String get settingsTheme => 'Tema';

  @override
  String get themeDark => 'Gelap';

  @override
  String get themeLight => 'Terang';

  @override
  String get themeSystem => 'Ikuti sistem';

  @override
  String get settingsLanguage => 'Bahasa';

  @override
  String get languageSystem => 'Ikuti sistem';

  @override
  String get settingsTimeFormat => 'Format 24 jam';

  @override
  String get settingsReduceMotion => 'Kurangi animasi';

  @override
  String get settingsNight => 'Mode malam';

  @override
  String get nightAuto => 'Otomatis (jadwal)';

  @override
  String get nightOn => 'Selalu malam';

  @override
  String get nightOff => 'Mati';

  @override
  String get nightSystem => 'Ikuti mode gelap sistem';

  @override
  String get nightStart => 'Mulai malam';

  @override
  String get nightEnd => 'Selesai malam';

  @override
  String get settingsAlarmDefaults => 'Bawaan alarm';

  @override
  String get settingsDefaultSnooze => 'Tunda bawaan';

  @override
  String get settingsDefaultTone => 'Nada bawaan';

  @override
  String get settingsDefaultVibrate => 'Getar bawaan';

  @override
  String get settingsPermissions => 'Izin dan keandalan';

  @override
  String get tonePagi => 'Pagi';

  @override
  String get toneBintang => 'Bintang';

  @override
  String get toneKomet => 'Komet';

  @override
  String get toneCustom => 'Dari perangkat';

  @override
  String get tonePick => 'Pilih dari perangkat';

  @override
  String get tonePreview => 'Pratinjau';

  @override
  String get permTitle => 'Agar alarm selalu berbunyi';

  @override
  String get permIntro =>
      'Android bisa menghentikan alarm bila izin berikut belum diberikan.';

  @override
  String get permNotification => 'Notifikasi';

  @override
  String get permNotificationBody => 'Menampilkan alarm dan tombol matikan.';

  @override
  String get permExact => 'Alarm tepat waktu';

  @override
  String get permExactBody => 'Supaya alarm berbunyi tepat pada menitnya.';

  @override
  String get permFullScreen => 'Layar penuh di atas kunci layar';

  @override
  String get permFullScreenBody =>
      'Menampilkan layar alarm saat ponsel terkunci.';

  @override
  String get permBattery => 'Abaikan optimasi baterai';

  @override
  String get permBatteryBody =>
      'Mencegah sistem menunda alarm. Penting di Xiaomi, Oppo, Samsung.';

  @override
  String get permGranted => 'Aktif';

  @override
  String get permGrant => 'Izinkan';

  @override
  String get permOpenSettings => 'Buka pengaturan';

  @override
  String get permBanner => 'Beberapa izin alarm belum aktif';

  @override
  String get permFix => 'Perbaiki';

  @override
  String get permVendorXiaomi =>
      'Xiaomi/Redmi/POCO: Pengaturan > Aplikasi > Detik > Hemat baterai > Tanpa batasan, lalu aktifkan Mulai otomatis.';

  @override
  String get permVendorSamsung =>
      'Samsung: Pengaturan > Baterai > Batas penggunaan di latar > hapus Detik dari aplikasi tidur.';

  @override
  String get permVendorOppo =>
      'Oppo/Realme/OnePlus: Pengaturan > Baterai > Detik > Izinkan aktivitas latar dan Mulai otomatis.';

  @override
  String get permVendorOther =>
      'Pastikan Detik tidak dibatasi baterai di pengaturan aplikasi.';

  @override
  String get permVendorTitle => 'Panduan perangkat Anda';
}
