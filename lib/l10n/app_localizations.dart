import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_id.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('id'),
  ];

  /// No description provided for @appName.
  ///
  /// In id, this message translates to:
  /// **'Detik'**
  String get appName;

  /// No description provided for @tabAlarm.
  ///
  /// In id, this message translates to:
  /// **'Alarm'**
  String get tabAlarm;

  /// No description provided for @tabClock.
  ///
  /// In id, this message translates to:
  /// **'Jam'**
  String get tabClock;

  /// No description provided for @tabTimer.
  ///
  /// In id, this message translates to:
  /// **'Timer'**
  String get tabTimer;

  /// No description provided for @tabStopwatch.
  ///
  /// In id, this message translates to:
  /// **'Stopwatch'**
  String get tabStopwatch;

  /// No description provided for @settings.
  ///
  /// In id, this message translates to:
  /// **'Pengaturan'**
  String get settings;

  /// No description provided for @save.
  ///
  /// In id, this message translates to:
  /// **'Simpan'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In id, this message translates to:
  /// **'Batal'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In id, this message translates to:
  /// **'Hapus'**
  String get delete;

  /// No description provided for @add.
  ///
  /// In id, this message translates to:
  /// **'Tambah'**
  String get add;

  /// No description provided for @close.
  ///
  /// In id, this message translates to:
  /// **'Tutup'**
  String get close;

  /// No description provided for @undo.
  ///
  /// In id, this message translates to:
  /// **'Urungkan'**
  String get undo;

  /// No description provided for @alarmEmptyTitle.
  ///
  /// In id, this message translates to:
  /// **'Belum ada alarm'**
  String get alarmEmptyTitle;

  /// No description provided for @alarmEmptyBody.
  ///
  /// In id, this message translates to:
  /// **'Buat alarm pertamamu dan biarkan planet menjagamu tetap tepat waktu.'**
  String get alarmEmptyBody;

  /// No description provided for @alarmCreate.
  ///
  /// In id, this message translates to:
  /// **'Buat alarm'**
  String get alarmCreate;

  /// No description provided for @alarmNew.
  ///
  /// In id, this message translates to:
  /// **'Alarm baru'**
  String get alarmNew;

  /// No description provided for @alarmEdit.
  ///
  /// In id, this message translates to:
  /// **'Ubah alarm'**
  String get alarmEdit;

  /// No description provided for @alarmLabel.
  ///
  /// In id, this message translates to:
  /// **'Label'**
  String get alarmLabel;

  /// No description provided for @alarmRepeat.
  ///
  /// In id, this message translates to:
  /// **'Ulangi'**
  String get alarmRepeat;

  /// No description provided for @alarmOnce.
  ///
  /// In id, this message translates to:
  /// **'Sekali'**
  String get alarmOnce;

  /// No description provided for @alarmEveryDay.
  ///
  /// In id, this message translates to:
  /// **'Setiap hari'**
  String get alarmEveryDay;

  /// No description provided for @alarmWeekdays.
  ///
  /// In id, this message translates to:
  /// **'Hari kerja'**
  String get alarmWeekdays;

  /// No description provided for @alarmTone.
  ///
  /// In id, this message translates to:
  /// **'Nada'**
  String get alarmTone;

  /// No description provided for @alarmVibrate.
  ///
  /// In id, this message translates to:
  /// **'Getar'**
  String get alarmVibrate;

  /// No description provided for @alarmSnooze.
  ///
  /// In id, this message translates to:
  /// **'Tunda'**
  String get alarmSnooze;

  /// No description provided for @alarmSnoozeMinutes.
  ///
  /// In id, this message translates to:
  /// **'{n} menit'**
  String alarmSnoozeMinutes(String n);

  /// No description provided for @alarmDeleted.
  ///
  /// In id, this message translates to:
  /// **'Alarm dihapus'**
  String get alarmDeleted;

  /// No description provided for @alarmNextIn.
  ///
  /// In id, this message translates to:
  /// **'Alarm berikutnya dalam {t}'**
  String alarmNextIn(String t);

  /// No description provided for @alarmNoneActive.
  ///
  /// In id, this message translates to:
  /// **'Tidak ada alarm aktif'**
  String get alarmNoneActive;

  /// No description provided for @alarmSetIn.
  ///
  /// In id, this message translates to:
  /// **'Alarm berbunyi dalam {t}'**
  String alarmSetIn(String t);

  /// No description provided for @alarmRinging.
  ///
  /// In id, this message translates to:
  /// **'Alarm berbunyi'**
  String get alarmRinging;

  /// No description provided for @alarmSlideStop.
  ///
  /// In id, this message translates to:
  /// **'Geser untuk mematikan'**
  String get alarmSlideStop;

  /// No description provided for @alarmStop.
  ///
  /// In id, this message translates to:
  /// **'Matikan'**
  String get alarmStop;

  /// No description provided for @alarmSnoozeFor.
  ///
  /// In id, this message translates to:
  /// **'Tunda {n} menit'**
  String alarmSnoozeFor(String n);

  /// No description provided for @timerRinging.
  ///
  /// In id, this message translates to:
  /// **'Timer selesai'**
  String get timerRinging;

  /// No description provided for @durationDays.
  ///
  /// In id, this message translates to:
  /// **'{d} hari'**
  String durationDays(String d);

  /// No description provided for @durationHours.
  ///
  /// In id, this message translates to:
  /// **'{h} jam'**
  String durationHours(String h);

  /// No description provided for @durationMinutes.
  ///
  /// In id, this message translates to:
  /// **'{m} menit'**
  String durationMinutes(String m);

  /// No description provided for @dayMon.
  ///
  /// In id, this message translates to:
  /// **'Sen'**
  String get dayMon;

  /// No description provided for @dayTue.
  ///
  /// In id, this message translates to:
  /// **'Sel'**
  String get dayTue;

  /// No description provided for @dayWed.
  ///
  /// In id, this message translates to:
  /// **'Rab'**
  String get dayWed;

  /// No description provided for @dayThu.
  ///
  /// In id, this message translates to:
  /// **'Kam'**
  String get dayThu;

  /// No description provided for @dayFri.
  ///
  /// In id, this message translates to:
  /// **'Jum'**
  String get dayFri;

  /// No description provided for @daySat.
  ///
  /// In id, this message translates to:
  /// **'Sab'**
  String get daySat;

  /// No description provided for @daySun.
  ///
  /// In id, this message translates to:
  /// **'Min'**
  String get daySun;

  /// No description provided for @clockAddCity.
  ///
  /// In id, this message translates to:
  /// **'Tambah kota'**
  String get clockAddCity;

  /// No description provided for @clockSearchCity.
  ///
  /// In id, this message translates to:
  /// **'Cari kota'**
  String get clockSearchCity;

  /// No description provided for @clockNoCities.
  ///
  /// In id, this message translates to:
  /// **'Tambahkan kota untuk melihat jam dunia'**
  String get clockNoCities;

  /// No description provided for @clockHoursAhead.
  ///
  /// In id, this message translates to:
  /// **'{h} jam lebih awal'**
  String clockHoursAhead(String h);

  /// No description provided for @clockHoursBehind.
  ///
  /// In id, this message translates to:
  /// **'{h} jam lebih lambat'**
  String clockHoursBehind(String h);

  /// No description provided for @clockSameTime.
  ///
  /// In id, this message translates to:
  /// **'Waktu sama'**
  String get clockSameTime;

  /// No description provided for @clockDay.
  ///
  /// In id, this message translates to:
  /// **'Siang'**
  String get clockDay;

  /// No description provided for @clockNight.
  ///
  /// In id, this message translates to:
  /// **'Malam'**
  String get clockNight;

  /// No description provided for @nightstand.
  ///
  /// In id, this message translates to:
  /// **'Mode nakas'**
  String get nightstand;

  /// No description provided for @nightstandExit.
  ///
  /// In id, this message translates to:
  /// **'Ketuk dua kali untuk keluar'**
  String get nightstandExit;

  /// No description provided for @timerNew.
  ///
  /// In id, this message translates to:
  /// **'Timer baru'**
  String get timerNew;

  /// No description provided for @timerStart.
  ///
  /// In id, this message translates to:
  /// **'Mulai'**
  String get timerStart;

  /// No description provided for @timerPause.
  ///
  /// In id, this message translates to:
  /// **'Jeda'**
  String get timerPause;

  /// No description provided for @timerResume.
  ///
  /// In id, this message translates to:
  /// **'Lanjut'**
  String get timerResume;

  /// No description provided for @timerReset.
  ///
  /// In id, this message translates to:
  /// **'Atur ulang'**
  String get timerReset;

  /// No description provided for @timerEmpty.
  ///
  /// In id, this message translates to:
  /// **'Belum ada timer'**
  String get timerEmpty;

  /// No description provided for @timerLabelHint.
  ///
  /// In id, this message translates to:
  /// **'Label (opsional)'**
  String get timerLabelHint;

  /// No description provided for @timerHours.
  ///
  /// In id, this message translates to:
  /// **'Jam'**
  String get timerHours;

  /// No description provided for @timerMinutes.
  ///
  /// In id, this message translates to:
  /// **'Menit'**
  String get timerMinutes;

  /// No description provided for @timerSeconds.
  ///
  /// In id, this message translates to:
  /// **'Detik'**
  String get timerSeconds;

  /// No description provided for @timerRunningNotif.
  ///
  /// In id, this message translates to:
  /// **'Timer berjalan'**
  String get timerRunningNotif;

  /// No description provided for @timerDoneNotif.
  ///
  /// In id, this message translates to:
  /// **'Timer selesai'**
  String get timerDoneNotif;

  /// No description provided for @stopwatchLap.
  ///
  /// In id, this message translates to:
  /// **'Lap'**
  String get stopwatchLap;

  /// No description provided for @stopwatchLapN.
  ///
  /// In id, this message translates to:
  /// **'Lap {n}'**
  String stopwatchLapN(String n);

  /// No description provided for @stopwatchNoLaps.
  ///
  /// In id, this message translates to:
  /// **'Belum ada lap'**
  String get stopwatchNoLaps;

  /// No description provided for @settingsAppearance.
  ///
  /// In id, this message translates to:
  /// **'Tampilan'**
  String get settingsAppearance;

  /// No description provided for @settingsTheme.
  ///
  /// In id, this message translates to:
  /// **'Tema'**
  String get settingsTheme;

  /// No description provided for @themeDark.
  ///
  /// In id, this message translates to:
  /// **'Gelap'**
  String get themeDark;

  /// No description provided for @themeLight.
  ///
  /// In id, this message translates to:
  /// **'Terang'**
  String get themeLight;

  /// No description provided for @themeSystem.
  ///
  /// In id, this message translates to:
  /// **'Ikuti sistem'**
  String get themeSystem;

  /// No description provided for @settingsLanguage.
  ///
  /// In id, this message translates to:
  /// **'Bahasa'**
  String get settingsLanguage;

  /// No description provided for @languageSystem.
  ///
  /// In id, this message translates to:
  /// **'Ikuti sistem'**
  String get languageSystem;

  /// No description provided for @settingsTimeFormat.
  ///
  /// In id, this message translates to:
  /// **'Format 24 jam'**
  String get settingsTimeFormat;

  /// No description provided for @settingsReduceMotion.
  ///
  /// In id, this message translates to:
  /// **'Kurangi animasi'**
  String get settingsReduceMotion;

  /// No description provided for @settingsNight.
  ///
  /// In id, this message translates to:
  /// **'Mode malam'**
  String get settingsNight;

  /// No description provided for @nightAuto.
  ///
  /// In id, this message translates to:
  /// **'Otomatis (jadwal)'**
  String get nightAuto;

  /// No description provided for @nightOn.
  ///
  /// In id, this message translates to:
  /// **'Selalu malam'**
  String get nightOn;

  /// No description provided for @nightOff.
  ///
  /// In id, this message translates to:
  /// **'Mati'**
  String get nightOff;

  /// No description provided for @nightSystem.
  ///
  /// In id, this message translates to:
  /// **'Ikuti mode gelap sistem'**
  String get nightSystem;

  /// No description provided for @nightStart.
  ///
  /// In id, this message translates to:
  /// **'Mulai malam'**
  String get nightStart;

  /// No description provided for @nightEnd.
  ///
  /// In id, this message translates to:
  /// **'Selesai malam'**
  String get nightEnd;

  /// No description provided for @settingsAlarmDefaults.
  ///
  /// In id, this message translates to:
  /// **'Bawaan alarm'**
  String get settingsAlarmDefaults;

  /// No description provided for @settingsDefaultSnooze.
  ///
  /// In id, this message translates to:
  /// **'Tunda bawaan'**
  String get settingsDefaultSnooze;

  /// No description provided for @settingsDefaultTone.
  ///
  /// In id, this message translates to:
  /// **'Nada bawaan'**
  String get settingsDefaultTone;

  /// No description provided for @settingsDefaultVibrate.
  ///
  /// In id, this message translates to:
  /// **'Getar bawaan'**
  String get settingsDefaultVibrate;

  /// No description provided for @settingsPermissions.
  ///
  /// In id, this message translates to:
  /// **'Izin dan keandalan'**
  String get settingsPermissions;

  /// No description provided for @tonePagi.
  ///
  /// In id, this message translates to:
  /// **'Pagi'**
  String get tonePagi;

  /// No description provided for @toneBintang.
  ///
  /// In id, this message translates to:
  /// **'Bintang'**
  String get toneBintang;

  /// No description provided for @toneKomet.
  ///
  /// In id, this message translates to:
  /// **'Komet'**
  String get toneKomet;

  /// No description provided for @toneCustom.
  ///
  /// In id, this message translates to:
  /// **'Dari perangkat'**
  String get toneCustom;

  /// No description provided for @tonePick.
  ///
  /// In id, this message translates to:
  /// **'Pilih dari perangkat'**
  String get tonePick;

  /// No description provided for @tonePreview.
  ///
  /// In id, this message translates to:
  /// **'Pratinjau'**
  String get tonePreview;

  /// No description provided for @permTitle.
  ///
  /// In id, this message translates to:
  /// **'Agar alarm selalu berbunyi'**
  String get permTitle;

  /// No description provided for @permIntro.
  ///
  /// In id, this message translates to:
  /// **'Android bisa menghentikan alarm bila izin berikut belum diberikan.'**
  String get permIntro;

  /// No description provided for @permNotification.
  ///
  /// In id, this message translates to:
  /// **'Notifikasi'**
  String get permNotification;

  /// No description provided for @permNotificationBody.
  ///
  /// In id, this message translates to:
  /// **'Menampilkan alarm dan tombol matikan.'**
  String get permNotificationBody;

  /// No description provided for @permExact.
  ///
  /// In id, this message translates to:
  /// **'Alarm tepat waktu'**
  String get permExact;

  /// No description provided for @permExactBody.
  ///
  /// In id, this message translates to:
  /// **'Supaya alarm berbunyi tepat pada menitnya.'**
  String get permExactBody;

  /// No description provided for @permFullScreen.
  ///
  /// In id, this message translates to:
  /// **'Layar penuh di atas kunci layar'**
  String get permFullScreen;

  /// No description provided for @permFullScreenBody.
  ///
  /// In id, this message translates to:
  /// **'Menampilkan layar alarm saat ponsel terkunci.'**
  String get permFullScreenBody;

  /// No description provided for @permBattery.
  ///
  /// In id, this message translates to:
  /// **'Abaikan optimasi baterai'**
  String get permBattery;

  /// No description provided for @permBatteryBody.
  ///
  /// In id, this message translates to:
  /// **'Mencegah sistem menunda alarm. Penting di Xiaomi, Oppo, Samsung.'**
  String get permBatteryBody;

  /// No description provided for @permGranted.
  ///
  /// In id, this message translates to:
  /// **'Aktif'**
  String get permGranted;

  /// No description provided for @permGrant.
  ///
  /// In id, this message translates to:
  /// **'Izinkan'**
  String get permGrant;

  /// No description provided for @permOpenSettings.
  ///
  /// In id, this message translates to:
  /// **'Buka pengaturan'**
  String get permOpenSettings;

  /// No description provided for @permBanner.
  ///
  /// In id, this message translates to:
  /// **'Beberapa izin alarm belum aktif'**
  String get permBanner;

  /// No description provided for @permFix.
  ///
  /// In id, this message translates to:
  /// **'Perbaiki'**
  String get permFix;

  /// No description provided for @permVendorXiaomi.
  ///
  /// In id, this message translates to:
  /// **'Xiaomi/Redmi/POCO: Pengaturan > Aplikasi > Detik > Hemat baterai > Tanpa batasan, lalu aktifkan Mulai otomatis.'**
  String get permVendorXiaomi;

  /// No description provided for @permVendorSamsung.
  ///
  /// In id, this message translates to:
  /// **'Samsung: Pengaturan > Baterai > Batas penggunaan di latar > hapus Detik dari aplikasi tidur.'**
  String get permVendorSamsung;

  /// No description provided for @permVendorOppo.
  ///
  /// In id, this message translates to:
  /// **'Oppo/Realme/OnePlus: Pengaturan > Baterai > Detik > Izinkan aktivitas latar dan Mulai otomatis.'**
  String get permVendorOppo;

  /// No description provided for @permVendorOther.
  ///
  /// In id, this message translates to:
  /// **'Pastikan Detik tidak dibatasi baterai di pengaturan aplikasi.'**
  String get permVendorOther;

  /// No description provided for @permVendorTitle.
  ///
  /// In id, this message translates to:
  /// **'Panduan perangkat Anda'**
  String get permVendorTitle;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'id'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'id':
      return AppLocalizationsId();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
