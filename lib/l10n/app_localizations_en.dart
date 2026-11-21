// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Detik';

  @override
  String get tabAlarm => 'Alarm';

  @override
  String get tabClock => 'Clock';

  @override
  String get tabTimer => 'Timer';

  @override
  String get tabStopwatch => 'Stopwatch';

  @override
  String get settings => 'Settings';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get add => 'Add';

  @override
  String get close => 'Close';

  @override
  String get undo => 'Undo';

  @override
  String get alarmEmptyTitle => 'No alarms yet';

  @override
  String get alarmEmptyBody =>
      'Create your first alarm and let the planets keep you on time.';

  @override
  String get alarmCreate => 'Create alarm';

  @override
  String get alarmNew => 'New alarm';

  @override
  String get alarmEdit => 'Edit alarm';

  @override
  String get alarmLabel => 'Label';

  @override
  String get alarmRepeat => 'Repeat';

  @override
  String get alarmOnce => 'Once';

  @override
  String get alarmEveryDay => 'Every day';

  @override
  String get alarmWeekdays => 'Weekdays';

  @override
  String get alarmTone => 'Tone';

  @override
  String get alarmVibrate => 'Vibrate';

  @override
  String get alarmSnooze => 'Snooze';

  @override
  String alarmSnoozeMinutes(String n) {
    return '$n min';
  }

  @override
  String get alarmDeleted => 'Alarm deleted';

  @override
  String alarmNextIn(String t) {
    return 'Next alarm in $t';
  }

  @override
  String get alarmNoneActive => 'No active alarms';

  @override
  String alarmSetIn(String t) {
    return 'Alarm rings in $t';
  }

  @override
  String get alarmRinging => 'Alarm ringing';

  @override
  String get alarmSlideStop => 'Slide to stop';

  @override
  String get alarmStop => 'Stop';

  @override
  String alarmSnoozeFor(String n) {
    return 'Snooze $n min';
  }

  @override
  String get timerRinging => 'Timer finished';

  @override
  String durationDays(String d) {
    return '$d d';
  }

  @override
  String durationHours(String h) {
    return '$h h';
  }

  @override
  String durationMinutes(String m) {
    return '$m min';
  }

  @override
  String get dayMon => 'Mon';

  @override
  String get dayTue => 'Tue';

  @override
  String get dayWed => 'Wed';

  @override
  String get dayThu => 'Thu';

  @override
  String get dayFri => 'Fri';

  @override
  String get daySat => 'Sat';

  @override
  String get daySun => 'Sun';

  @override
  String get clockAddCity => 'Add city';

  @override
  String get clockSearchCity => 'Search city';

  @override
  String get clockNoCities => 'Add a city to see world clocks';

  @override
  String clockHoursAhead(String h) {
    return '$h h ahead';
  }

  @override
  String clockHoursBehind(String h) {
    return '$h h behind';
  }

  @override
  String get clockSameTime => 'Same time';

  @override
  String get clockDay => 'Day';

  @override
  String get clockNight => 'Night';

  @override
  String get nightstand => 'Nightstand mode';

  @override
  String get nightstandExit => 'Double tap to exit';

  @override
  String get timerNew => 'New timer';

  @override
  String get timerStart => 'Start';

  @override
  String get timerPause => 'Pause';

  @override
  String get timerResume => 'Resume';

  @override
  String get timerReset => 'Reset';

  @override
  String get timerEmpty => 'No timers yet';

  @override
  String get timerLabelHint => 'Label (optional)';

  @override
  String get timerHours => 'Hours';

  @override
  String get timerMinutes => 'Minutes';

  @override
  String get timerSeconds => 'Seconds';

  @override
  String get timerRunningNotif => 'Timer running';

  @override
  String get timerDoneNotif => 'Timer finished';

  @override
  String get stopwatchLap => 'Lap';

  @override
  String stopwatchLapN(String n) {
    return 'Lap $n';
  }

  @override
  String get stopwatchNoLaps => 'No laps yet';

  @override
  String get settingsAppearance => 'Appearance';

  @override
  String get settingsTheme => 'Theme';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeLight => 'Light';

  @override
  String get themeSystem => 'Follow system';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get languageSystem => 'Follow system';

  @override
  String get settingsTimeFormat => '24-hour format';

  @override
  String get settingsReduceMotion => 'Reduce motion';

  @override
  String get settingsNight => 'Night mode';

  @override
  String get nightAuto => 'Automatic (schedule)';

  @override
  String get nightOn => 'Always night';

  @override
  String get nightOff => 'Off';

  @override
  String get nightSystem => 'Follow system dark mode';

  @override
  String get nightStart => 'Night starts';

  @override
  String get nightEnd => 'Night ends';

  @override
  String get settingsAlarmDefaults => 'Alarm defaults';

  @override
  String get settingsDefaultSnooze => 'Default snooze';

  @override
  String get settingsDefaultTone => 'Default tone';

  @override
  String get settingsDefaultVibrate => 'Default vibrate';

  @override
  String get settingsPermissions => 'Permissions and reliability';

  @override
  String get tonePagi => 'Morning';

  @override
  String get toneBintang => 'Star';

  @override
  String get toneKomet => 'Comet';

  @override
  String get toneCustom => 'From device';

  @override
  String get tonePick => 'Pick from device';

  @override
  String get tonePreview => 'Preview';

  @override
  String get permTitle => 'So alarms always ring';

  @override
  String get permIntro =>
      'Android may block alarms unless the following permissions are granted.';

  @override
  String get permNotification => 'Notifications';

  @override
  String get permNotificationBody => 'Shows the alarm and stop button.';

  @override
  String get permExact => 'Exact alarms';

  @override
  String get permExactBody => 'So alarms ring exactly on time.';

  @override
  String get permFullScreen => 'Full screen over lock screen';

  @override
  String get permFullScreenBody =>
      'Shows the alarm screen when the phone is locked.';

  @override
  String get permBattery => 'Ignore battery optimization';

  @override
  String get permBatteryBody =>
      'Stops the system delaying alarms. Important on Xiaomi, Oppo, Samsung.';

  @override
  String get permGranted => 'On';

  @override
  String get permGrant => 'Allow';

  @override
  String get permOpenSettings => 'Open settings';

  @override
  String get permBanner => 'Some alarm permissions are off';

  @override
  String get permFix => 'Fix';

  @override
  String get permVendorXiaomi =>
      'Xiaomi/Redmi/POCO: Settings > Apps > Detik > Battery saver > No restrictions, then enable Autostart.';

  @override
  String get permVendorSamsung =>
      'Samsung: Settings > Battery > Background usage limits > remove Detik from sleeping apps.';

  @override
  String get permVendorOppo =>
      'Oppo/Realme/OnePlus: Settings > Battery > Detik > Allow background activity and Autostart.';

  @override
  String get permVendorOther =>
      'Make sure Detik is not battery-restricted in app settings.';

  @override
  String get permVendorTitle => 'Guide for your device';
}
