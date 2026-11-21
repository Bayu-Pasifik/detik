// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $AlarmsTable extends Alarms with TableInfo<$AlarmsTable, Alarm> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AlarmsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _hourMeta = const VerificationMeta('hour');
  @override
  late final GeneratedColumn<int> hour = GeneratedColumn<int>(
    'hour',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _minuteMeta = const VerificationMeta('minute');
  @override
  late final GeneratedColumn<int> minute = GeneratedColumn<int>(
    'minute',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _repeatDaysMeta = const VerificationMeta(
    'repeatDays',
  );
  @override
  late final GeneratedColumn<int> repeatDays = GeneratedColumn<int>(
    'repeat_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _enabledMeta = const VerificationMeta(
    'enabled',
  );
  @override
  late final GeneratedColumn<bool> enabled = GeneratedColumn<bool>(
    'enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _toneMeta = const VerificationMeta('tone');
  @override
  late final GeneratedColumn<String> tone = GeneratedColumn<String>(
    'tone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('assets/audio/pagi.wav'),
  );
  static const VerificationMeta _vibrateMeta = const VerificationMeta(
    'vibrate',
  );
  @override
  late final GeneratedColumn<bool> vibrate = GeneratedColumn<bool>(
    'vibrate',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("vibrate" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _snoozeMinutesMeta = const VerificationMeta(
    'snoozeMinutes',
  );
  @override
  late final GeneratedColumn<int> snoozeMinutes = GeneratedColumn<int>(
    'snooze_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(10),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    hour,
    minute,
    label,
    repeatDays,
    enabled,
    tone,
    vibrate,
    snoozeMinutes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'alarms';
  @override
  VerificationContext validateIntegrity(
    Insertable<Alarm> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('hour')) {
      context.handle(
        _hourMeta,
        hour.isAcceptableOrUnknown(data['hour']!, _hourMeta),
      );
    } else if (isInserting) {
      context.missing(_hourMeta);
    }
    if (data.containsKey('minute')) {
      context.handle(
        _minuteMeta,
        minute.isAcceptableOrUnknown(data['minute']!, _minuteMeta),
      );
    } else if (isInserting) {
      context.missing(_minuteMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    }
    if (data.containsKey('repeat_days')) {
      context.handle(
        _repeatDaysMeta,
        repeatDays.isAcceptableOrUnknown(data['repeat_days']!, _repeatDaysMeta),
      );
    }
    if (data.containsKey('enabled')) {
      context.handle(
        _enabledMeta,
        enabled.isAcceptableOrUnknown(data['enabled']!, _enabledMeta),
      );
    }
    if (data.containsKey('tone')) {
      context.handle(
        _toneMeta,
        tone.isAcceptableOrUnknown(data['tone']!, _toneMeta),
      );
    }
    if (data.containsKey('vibrate')) {
      context.handle(
        _vibrateMeta,
        vibrate.isAcceptableOrUnknown(data['vibrate']!, _vibrateMeta),
      );
    }
    if (data.containsKey('snooze_minutes')) {
      context.handle(
        _snoozeMinutesMeta,
        snoozeMinutes.isAcceptableOrUnknown(
          data['snooze_minutes']!,
          _snoozeMinutesMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Alarm map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Alarm(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      hour: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}hour'],
      )!,
      minute: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}minute'],
      )!,
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      )!,
      repeatDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}repeat_days'],
      )!,
      enabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enabled'],
      )!,
      tone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tone'],
      )!,
      vibrate: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}vibrate'],
      )!,
      snoozeMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}snooze_minutes'],
      )!,
    );
  }

  @override
  $AlarmsTable createAlias(String alias) {
    return $AlarmsTable(attachedDatabase, alias);
  }
}

class Alarm extends DataClass implements Insertable<Alarm> {
  final int id;
  final int hour;
  final int minute;
  final String label;
  final int repeatDays;
  final bool enabled;
  final String tone;
  final bool vibrate;
  final int snoozeMinutes;
  const Alarm({
    required this.id,
    required this.hour,
    required this.minute,
    required this.label,
    required this.repeatDays,
    required this.enabled,
    required this.tone,
    required this.vibrate,
    required this.snoozeMinutes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['hour'] = Variable<int>(hour);
    map['minute'] = Variable<int>(minute);
    map['label'] = Variable<String>(label);
    map['repeat_days'] = Variable<int>(repeatDays);
    map['enabled'] = Variable<bool>(enabled);
    map['tone'] = Variable<String>(tone);
    map['vibrate'] = Variable<bool>(vibrate);
    map['snooze_minutes'] = Variable<int>(snoozeMinutes);
    return map;
  }

  AlarmsCompanion toCompanion(bool nullToAbsent) {
    return AlarmsCompanion(
      id: Value(id),
      hour: Value(hour),
      minute: Value(minute),
      label: Value(label),
      repeatDays: Value(repeatDays),
      enabled: Value(enabled),
      tone: Value(tone),
      vibrate: Value(vibrate),
      snoozeMinutes: Value(snoozeMinutes),
    );
  }

  factory Alarm.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Alarm(
      id: serializer.fromJson<int>(json['id']),
      hour: serializer.fromJson<int>(json['hour']),
      minute: serializer.fromJson<int>(json['minute']),
      label: serializer.fromJson<String>(json['label']),
      repeatDays: serializer.fromJson<int>(json['repeatDays']),
      enabled: serializer.fromJson<bool>(json['enabled']),
      tone: serializer.fromJson<String>(json['tone']),
      vibrate: serializer.fromJson<bool>(json['vibrate']),
      snoozeMinutes: serializer.fromJson<int>(json['snoozeMinutes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'hour': serializer.toJson<int>(hour),
      'minute': serializer.toJson<int>(minute),
      'label': serializer.toJson<String>(label),
      'repeatDays': serializer.toJson<int>(repeatDays),
      'enabled': serializer.toJson<bool>(enabled),
      'tone': serializer.toJson<String>(tone),
      'vibrate': serializer.toJson<bool>(vibrate),
      'snoozeMinutes': serializer.toJson<int>(snoozeMinutes),
    };
  }

  Alarm copyWith({
    int? id,
    int? hour,
    int? minute,
    String? label,
    int? repeatDays,
    bool? enabled,
    String? tone,
    bool? vibrate,
    int? snoozeMinutes,
  }) => Alarm(
    id: id ?? this.id,
    hour: hour ?? this.hour,
    minute: minute ?? this.minute,
    label: label ?? this.label,
    repeatDays: repeatDays ?? this.repeatDays,
    enabled: enabled ?? this.enabled,
    tone: tone ?? this.tone,
    vibrate: vibrate ?? this.vibrate,
    snoozeMinutes: snoozeMinutes ?? this.snoozeMinutes,
  );
  Alarm copyWithCompanion(AlarmsCompanion data) {
    return Alarm(
      id: data.id.present ? data.id.value : this.id,
      hour: data.hour.present ? data.hour.value : this.hour,
      minute: data.minute.present ? data.minute.value : this.minute,
      label: data.label.present ? data.label.value : this.label,
      repeatDays: data.repeatDays.present
          ? data.repeatDays.value
          : this.repeatDays,
      enabled: data.enabled.present ? data.enabled.value : this.enabled,
      tone: data.tone.present ? data.tone.value : this.tone,
      vibrate: data.vibrate.present ? data.vibrate.value : this.vibrate,
      snoozeMinutes: data.snoozeMinutes.present
          ? data.snoozeMinutes.value
          : this.snoozeMinutes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Alarm(')
          ..write('id: $id, ')
          ..write('hour: $hour, ')
          ..write('minute: $minute, ')
          ..write('label: $label, ')
          ..write('repeatDays: $repeatDays, ')
          ..write('enabled: $enabled, ')
          ..write('tone: $tone, ')
          ..write('vibrate: $vibrate, ')
          ..write('snoozeMinutes: $snoozeMinutes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    hour,
    minute,
    label,
    repeatDays,
    enabled,
    tone,
    vibrate,
    snoozeMinutes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Alarm &&
          other.id == this.id &&
          other.hour == this.hour &&
          other.minute == this.minute &&
          other.label == this.label &&
          other.repeatDays == this.repeatDays &&
          other.enabled == this.enabled &&
          other.tone == this.tone &&
          other.vibrate == this.vibrate &&
          other.snoozeMinutes == this.snoozeMinutes);
}

class AlarmsCompanion extends UpdateCompanion<Alarm> {
  final Value<int> id;
  final Value<int> hour;
  final Value<int> minute;
  final Value<String> label;
  final Value<int> repeatDays;
  final Value<bool> enabled;
  final Value<String> tone;
  final Value<bool> vibrate;
  final Value<int> snoozeMinutes;
  const AlarmsCompanion({
    this.id = const Value.absent(),
    this.hour = const Value.absent(),
    this.minute = const Value.absent(),
    this.label = const Value.absent(),
    this.repeatDays = const Value.absent(),
    this.enabled = const Value.absent(),
    this.tone = const Value.absent(),
    this.vibrate = const Value.absent(),
    this.snoozeMinutes = const Value.absent(),
  });
  AlarmsCompanion.insert({
    this.id = const Value.absent(),
    required int hour,
    required int minute,
    this.label = const Value.absent(),
    this.repeatDays = const Value.absent(),
    this.enabled = const Value.absent(),
    this.tone = const Value.absent(),
    this.vibrate = const Value.absent(),
    this.snoozeMinutes = const Value.absent(),
  }) : hour = Value(hour),
       minute = Value(minute);
  static Insertable<Alarm> custom({
    Expression<int>? id,
    Expression<int>? hour,
    Expression<int>? minute,
    Expression<String>? label,
    Expression<int>? repeatDays,
    Expression<bool>? enabled,
    Expression<String>? tone,
    Expression<bool>? vibrate,
    Expression<int>? snoozeMinutes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (hour != null) 'hour': hour,
      if (minute != null) 'minute': minute,
      if (label != null) 'label': label,
      if (repeatDays != null) 'repeat_days': repeatDays,
      if (enabled != null) 'enabled': enabled,
      if (tone != null) 'tone': tone,
      if (vibrate != null) 'vibrate': vibrate,
      if (snoozeMinutes != null) 'snooze_minutes': snoozeMinutes,
    });
  }

  AlarmsCompanion copyWith({
    Value<int>? id,
    Value<int>? hour,
    Value<int>? minute,
    Value<String>? label,
    Value<int>? repeatDays,
    Value<bool>? enabled,
    Value<String>? tone,
    Value<bool>? vibrate,
    Value<int>? snoozeMinutes,
  }) {
    return AlarmsCompanion(
      id: id ?? this.id,
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
      label: label ?? this.label,
      repeatDays: repeatDays ?? this.repeatDays,
      enabled: enabled ?? this.enabled,
      tone: tone ?? this.tone,
      vibrate: vibrate ?? this.vibrate,
      snoozeMinutes: snoozeMinutes ?? this.snoozeMinutes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (hour.present) {
      map['hour'] = Variable<int>(hour.value);
    }
    if (minute.present) {
      map['minute'] = Variable<int>(minute.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (repeatDays.present) {
      map['repeat_days'] = Variable<int>(repeatDays.value);
    }
    if (enabled.present) {
      map['enabled'] = Variable<bool>(enabled.value);
    }
    if (tone.present) {
      map['tone'] = Variable<String>(tone.value);
    }
    if (vibrate.present) {
      map['vibrate'] = Variable<bool>(vibrate.value);
    }
    if (snoozeMinutes.present) {
      map['snooze_minutes'] = Variable<int>(snoozeMinutes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AlarmsCompanion(')
          ..write('id: $id, ')
          ..write('hour: $hour, ')
          ..write('minute: $minute, ')
          ..write('label: $label, ')
          ..write('repeatDays: $repeatDays, ')
          ..write('enabled: $enabled, ')
          ..write('tone: $tone, ')
          ..write('vibrate: $vibrate, ')
          ..write('snoozeMinutes: $snoozeMinutes')
          ..write(')'))
        .toString();
  }
}

class $TimersTable extends Timers with TableInfo<$TimersTable, TimerRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TimersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _durationMsMeta = const VerificationMeta(
    'durationMs',
  );
  @override
  late final GeneratedColumn<int> durationMs = GeneratedColumn<int>(
    'duration_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endsAtMsMeta = const VerificationMeta(
    'endsAtMs',
  );
  @override
  late final GeneratedColumn<int> endsAtMs = GeneratedColumn<int>(
    'ends_at_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _remainingMsMeta = const VerificationMeta(
    'remainingMs',
  );
  @override
  late final GeneratedColumn<int> remainingMs = GeneratedColumn<int>(
    'remaining_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    label,
    durationMs,
    endsAtMs,
    remainingMs,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'timers';
  @override
  VerificationContext validateIntegrity(
    Insertable<TimerRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    }
    if (data.containsKey('duration_ms')) {
      context.handle(
        _durationMsMeta,
        durationMs.isAcceptableOrUnknown(data['duration_ms']!, _durationMsMeta),
      );
    } else if (isInserting) {
      context.missing(_durationMsMeta);
    }
    if (data.containsKey('ends_at_ms')) {
      context.handle(
        _endsAtMsMeta,
        endsAtMs.isAcceptableOrUnknown(data['ends_at_ms']!, _endsAtMsMeta),
      );
    }
    if (data.containsKey('remaining_ms')) {
      context.handle(
        _remainingMsMeta,
        remainingMs.isAcceptableOrUnknown(
          data['remaining_ms']!,
          _remainingMsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TimerRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TimerRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      )!,
      durationMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_ms'],
      )!,
      endsAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ends_at_ms'],
      ),
      remainingMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}remaining_ms'],
      ),
    );
  }

  @override
  $TimersTable createAlias(String alias) {
    return $TimersTable(attachedDatabase, alias);
  }
}

class TimerRow extends DataClass implements Insertable<TimerRow> {
  final int id;
  final String label;
  final int durationMs;
  final int? endsAtMs;
  final int? remainingMs;
  const TimerRow({
    required this.id,
    required this.label,
    required this.durationMs,
    this.endsAtMs,
    this.remainingMs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['label'] = Variable<String>(label);
    map['duration_ms'] = Variable<int>(durationMs);
    if (!nullToAbsent || endsAtMs != null) {
      map['ends_at_ms'] = Variable<int>(endsAtMs);
    }
    if (!nullToAbsent || remainingMs != null) {
      map['remaining_ms'] = Variable<int>(remainingMs);
    }
    return map;
  }

  TimersCompanion toCompanion(bool nullToAbsent) {
    return TimersCompanion(
      id: Value(id),
      label: Value(label),
      durationMs: Value(durationMs),
      endsAtMs: endsAtMs == null && nullToAbsent
          ? const Value.absent()
          : Value(endsAtMs),
      remainingMs: remainingMs == null && nullToAbsent
          ? const Value.absent()
          : Value(remainingMs),
    );
  }

  factory TimerRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TimerRow(
      id: serializer.fromJson<int>(json['id']),
      label: serializer.fromJson<String>(json['label']),
      durationMs: serializer.fromJson<int>(json['durationMs']),
      endsAtMs: serializer.fromJson<int?>(json['endsAtMs']),
      remainingMs: serializer.fromJson<int?>(json['remainingMs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'label': serializer.toJson<String>(label),
      'durationMs': serializer.toJson<int>(durationMs),
      'endsAtMs': serializer.toJson<int?>(endsAtMs),
      'remainingMs': serializer.toJson<int?>(remainingMs),
    };
  }

  TimerRow copyWith({
    int? id,
    String? label,
    int? durationMs,
    Value<int?> endsAtMs = const Value.absent(),
    Value<int?> remainingMs = const Value.absent(),
  }) => TimerRow(
    id: id ?? this.id,
    label: label ?? this.label,
    durationMs: durationMs ?? this.durationMs,
    endsAtMs: endsAtMs.present ? endsAtMs.value : this.endsAtMs,
    remainingMs: remainingMs.present ? remainingMs.value : this.remainingMs,
  );
  TimerRow copyWithCompanion(TimersCompanion data) {
    return TimerRow(
      id: data.id.present ? data.id.value : this.id,
      label: data.label.present ? data.label.value : this.label,
      durationMs: data.durationMs.present
          ? data.durationMs.value
          : this.durationMs,
      endsAtMs: data.endsAtMs.present ? data.endsAtMs.value : this.endsAtMs,
      remainingMs: data.remainingMs.present
          ? data.remainingMs.value
          : this.remainingMs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TimerRow(')
          ..write('id: $id, ')
          ..write('label: $label, ')
          ..write('durationMs: $durationMs, ')
          ..write('endsAtMs: $endsAtMs, ')
          ..write('remainingMs: $remainingMs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, label, durationMs, endsAtMs, remainingMs);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TimerRow &&
          other.id == this.id &&
          other.label == this.label &&
          other.durationMs == this.durationMs &&
          other.endsAtMs == this.endsAtMs &&
          other.remainingMs == this.remainingMs);
}

class TimersCompanion extends UpdateCompanion<TimerRow> {
  final Value<int> id;
  final Value<String> label;
  final Value<int> durationMs;
  final Value<int?> endsAtMs;
  final Value<int?> remainingMs;
  const TimersCompanion({
    this.id = const Value.absent(),
    this.label = const Value.absent(),
    this.durationMs = const Value.absent(),
    this.endsAtMs = const Value.absent(),
    this.remainingMs = const Value.absent(),
  });
  TimersCompanion.insert({
    this.id = const Value.absent(),
    this.label = const Value.absent(),
    required int durationMs,
    this.endsAtMs = const Value.absent(),
    this.remainingMs = const Value.absent(),
  }) : durationMs = Value(durationMs);
  static Insertable<TimerRow> custom({
    Expression<int>? id,
    Expression<String>? label,
    Expression<int>? durationMs,
    Expression<int>? endsAtMs,
    Expression<int>? remainingMs,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (label != null) 'label': label,
      if (durationMs != null) 'duration_ms': durationMs,
      if (endsAtMs != null) 'ends_at_ms': endsAtMs,
      if (remainingMs != null) 'remaining_ms': remainingMs,
    });
  }

  TimersCompanion copyWith({
    Value<int>? id,
    Value<String>? label,
    Value<int>? durationMs,
    Value<int?>? endsAtMs,
    Value<int?>? remainingMs,
  }) {
    return TimersCompanion(
      id: id ?? this.id,
      label: label ?? this.label,
      durationMs: durationMs ?? this.durationMs,
      endsAtMs: endsAtMs ?? this.endsAtMs,
      remainingMs: remainingMs ?? this.remainingMs,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (durationMs.present) {
      map['duration_ms'] = Variable<int>(durationMs.value);
    }
    if (endsAtMs.present) {
      map['ends_at_ms'] = Variable<int>(endsAtMs.value);
    }
    if (remainingMs.present) {
      map['remaining_ms'] = Variable<int>(remainingMs.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TimersCompanion(')
          ..write('id: $id, ')
          ..write('label: $label, ')
          ..write('durationMs: $durationMs, ')
          ..write('endsAtMs: $endsAtMs, ')
          ..write('remainingMs: $remainingMs')
          ..write(')'))
        .toString();
  }
}

class $WorldClocksTable extends WorldClocks
    with TableInfo<$WorldClocksTable, WorldClock> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorldClocksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
    'city',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tzNameMeta = const VerificationMeta('tzName');
  @override
  late final GeneratedColumn<String> tzName = GeneratedColumn<String>(
    'tz_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, city, tzName];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'world_clocks';
  @override
  VerificationContext validateIntegrity(
    Insertable<WorldClock> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('city')) {
      context.handle(
        _cityMeta,
        city.isAcceptableOrUnknown(data['city']!, _cityMeta),
      );
    } else if (isInserting) {
      context.missing(_cityMeta);
    }
    if (data.containsKey('tz_name')) {
      context.handle(
        _tzNameMeta,
        tzName.isAcceptableOrUnknown(data['tz_name']!, _tzNameMeta),
      );
    } else if (isInserting) {
      context.missing(_tzNameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorldClock map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorldClock(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      city: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}city'],
      )!,
      tzName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tz_name'],
      )!,
    );
  }

  @override
  $WorldClocksTable createAlias(String alias) {
    return $WorldClocksTable(attachedDatabase, alias);
  }
}

class WorldClock extends DataClass implements Insertable<WorldClock> {
  final int id;
  final String city;
  final String tzName;
  const WorldClock({
    required this.id,
    required this.city,
    required this.tzName,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['city'] = Variable<String>(city);
    map['tz_name'] = Variable<String>(tzName);
    return map;
  }

  WorldClocksCompanion toCompanion(bool nullToAbsent) {
    return WorldClocksCompanion(
      id: Value(id),
      city: Value(city),
      tzName: Value(tzName),
    );
  }

  factory WorldClock.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorldClock(
      id: serializer.fromJson<int>(json['id']),
      city: serializer.fromJson<String>(json['city']),
      tzName: serializer.fromJson<String>(json['tzName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'city': serializer.toJson<String>(city),
      'tzName': serializer.toJson<String>(tzName),
    };
  }

  WorldClock copyWith({int? id, String? city, String? tzName}) => WorldClock(
    id: id ?? this.id,
    city: city ?? this.city,
    tzName: tzName ?? this.tzName,
  );
  WorldClock copyWithCompanion(WorldClocksCompanion data) {
    return WorldClock(
      id: data.id.present ? data.id.value : this.id,
      city: data.city.present ? data.city.value : this.city,
      tzName: data.tzName.present ? data.tzName.value : this.tzName,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorldClock(')
          ..write('id: $id, ')
          ..write('city: $city, ')
          ..write('tzName: $tzName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, city, tzName);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorldClock &&
          other.id == this.id &&
          other.city == this.city &&
          other.tzName == this.tzName);
}

class WorldClocksCompanion extends UpdateCompanion<WorldClock> {
  final Value<int> id;
  final Value<String> city;
  final Value<String> tzName;
  const WorldClocksCompanion({
    this.id = const Value.absent(),
    this.city = const Value.absent(),
    this.tzName = const Value.absent(),
  });
  WorldClocksCompanion.insert({
    this.id = const Value.absent(),
    required String city,
    required String tzName,
  }) : city = Value(city),
       tzName = Value(tzName);
  static Insertable<WorldClock> custom({
    Expression<int>? id,
    Expression<String>? city,
    Expression<String>? tzName,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (city != null) 'city': city,
      if (tzName != null) 'tz_name': tzName,
    });
  }

  WorldClocksCompanion copyWith({
    Value<int>? id,
    Value<String>? city,
    Value<String>? tzName,
  }) {
    return WorldClocksCompanion(
      id: id ?? this.id,
      city: city ?? this.city,
      tzName: tzName ?? this.tzName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (tzName.present) {
      map['tz_name'] = Variable<String>(tzName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorldClocksCompanion(')
          ..write('id: $id, ')
          ..write('city: $city, ')
          ..write('tzName: $tzName')
          ..write(')'))
        .toString();
  }
}

class $SettingsTable extends Settings with TableInfo<$SettingsTable, Setting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<Setting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  Setting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Setting(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  $SettingsTable createAlias(String alias) {
    return $SettingsTable(attachedDatabase, alias);
  }
}

class Setting extends DataClass implements Insertable<Setting> {
  final String key;
  final String value;
  const Setting({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  SettingsCompanion toCompanion(bool nullToAbsent) {
    return SettingsCompanion(key: Value(key), value: Value(value));
  }

  factory Setting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Setting(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  Setting copyWith({String? key, String? value}) =>
      Setting(key: key ?? this.key, value: value ?? this.value);
  Setting copyWithCompanion(SettingsCompanion data) {
    return Setting(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Setting(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Setting && other.key == this.key && other.value == this.value);
}

class SettingsCompanion extends UpdateCompanion<Setting> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const SettingsCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SettingsCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<Setting> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SettingsCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<int>? rowid,
  }) {
    return SettingsCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $AlarmsTable alarms = $AlarmsTable(this);
  late final $TimersTable timers = $TimersTable(this);
  late final $WorldClocksTable worldClocks = $WorldClocksTable(this);
  late final $SettingsTable settings = $SettingsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    alarms,
    timers,
    worldClocks,
    settings,
  ];
}

typedef $$AlarmsTableCreateCompanionBuilder = AlarmsCompanion Function({
  Value<int> id,
  required int hour,
  required int minute,
  Value<String> label,
  Value<int> repeatDays,
  Value<bool> enabled,
  Value<String> tone,
  Value<bool> vibrate,
  Value<int> snoozeMinutes,
});
typedef $$AlarmsTableUpdateCompanionBuilder = AlarmsCompanion Function({
  Value<int> id,
  Value<int> hour,
  Value<int> minute,
  Value<String> label,
  Value<int> repeatDays,
  Value<bool> enabled,
  Value<String> tone,
  Value<bool> vibrate,
  Value<int> snoozeMinutes,
});

class $$AlarmsTableFilterComposer
    extends Composer<_$AppDatabase, $AlarmsTable> {
  $$AlarmsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get hour => $composableBuilder(
    column: $table.hour,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get minute => $composableBuilder(
    column: $table.minute,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get repeatDays => $composableBuilder(
    column: $table.repeatDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tone => $composableBuilder(
    column: $table.tone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get vibrate => $composableBuilder(
    column: $table.vibrate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get snoozeMinutes => $composableBuilder(
    column: $table.snoozeMinutes,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AlarmsTableOrderingComposer
    extends Composer<_$AppDatabase, $AlarmsTable> {
  $$AlarmsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get hour => $composableBuilder(
    column: $table.hour,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get minute => $composableBuilder(
    column: $table.minute,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get repeatDays => $composableBuilder(
    column: $table.repeatDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tone => $composableBuilder(
    column: $table.tone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get vibrate => $composableBuilder(
    column: $table.vibrate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get snoozeMinutes => $composableBuilder(
    column: $table.snoozeMinutes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AlarmsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AlarmsTable> {
  $$AlarmsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get hour =>
      $composableBuilder(column: $table.hour, builder: (column) => column);

  GeneratedColumn<int> get minute =>
      $composableBuilder(column: $table.minute, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<int> get repeatDays => $composableBuilder(
    column: $table.repeatDays,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get enabled =>
      $composableBuilder(column: $table.enabled, builder: (column) => column);

  GeneratedColumn<String> get tone =>
      $composableBuilder(column: $table.tone, builder: (column) => column);

  GeneratedColumn<bool> get vibrate =>
      $composableBuilder(column: $table.vibrate, builder: (column) => column);

  GeneratedColumn<int> get snoozeMinutes => $composableBuilder(
    column: $table.snoozeMinutes,
    builder: (column) => column,
  );
}

class $$AlarmsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AlarmsTable,
          Alarm,
          $$AlarmsTableFilterComposer,
          $$AlarmsTableOrderingComposer,
          $$AlarmsTableAnnotationComposer,
          $$AlarmsTableCreateCompanionBuilder,
          $$AlarmsTableUpdateCompanionBuilder,
          (Alarm, BaseReferences<_$AppDatabase, $AlarmsTable, Alarm>),
          Alarm,
          PrefetchHooks Function()
        > {
  $$AlarmsTableTableManager(_$AppDatabase db, $AlarmsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AlarmsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AlarmsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AlarmsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> hour = const Value.absent(),
                Value<int> minute = const Value.absent(),
                Value<String> label = const Value.absent(),
                Value<int> repeatDays = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                Value<String> tone = const Value.absent(),
                Value<bool> vibrate = const Value.absent(),
                Value<int> snoozeMinutes = const Value.absent(),
              }) => AlarmsCompanion(
                id: id,
                hour: hour,
                minute: minute,
                label: label,
                repeatDays: repeatDays,
                enabled: enabled,
                tone: tone,
                vibrate: vibrate,
                snoozeMinutes: snoozeMinutes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int hour,
                required int minute,
                Value<String> label = const Value.absent(),
                Value<int> repeatDays = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                Value<String> tone = const Value.absent(),
                Value<bool> vibrate = const Value.absent(),
                Value<int> snoozeMinutes = const Value.absent(),
              }) => AlarmsCompanion.insert(
                id: id,
                hour: hour,
                minute: minute,
                label: label,
                repeatDays: repeatDays,
                enabled: enabled,
                tone: tone,
                vibrate: vibrate,
                snoozeMinutes: snoozeMinutes,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AlarmsTable, Alarm>(table),
                  BaseReferences<_$AppDatabase, $AlarmsTable, Alarm>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AlarmsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AlarmsTable,
      Alarm,
      $$AlarmsTableFilterComposer,
      $$AlarmsTableOrderingComposer,
      $$AlarmsTableAnnotationComposer,
      $$AlarmsTableCreateCompanionBuilder,
      $$AlarmsTableUpdateCompanionBuilder,
      (Alarm, BaseReferences<_$AppDatabase, $AlarmsTable, Alarm>),
      Alarm,
      PrefetchHooks Function()
    >;
typedef $$TimersTableCreateCompanionBuilder = TimersCompanion Function({
  Value<int> id,
  Value<String> label,
  required int durationMs,
  Value<int?> endsAtMs,
  Value<int?> remainingMs,
});
typedef $$TimersTableUpdateCompanionBuilder = TimersCompanion Function({
  Value<int> id,
  Value<String> label,
  Value<int> durationMs,
  Value<int?> endsAtMs,
  Value<int?> remainingMs,
});

class $$TimersTableFilterComposer
    extends Composer<_$AppDatabase, $TimersTable> {
  $$TimersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get endsAtMs => $composableBuilder(
    column: $table.endsAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get remainingMs => $composableBuilder(
    column: $table.remainingMs,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TimersTableOrderingComposer
    extends Composer<_$AppDatabase, $TimersTable> {
  $$TimersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get endsAtMs => $composableBuilder(
    column: $table.endsAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get remainingMs => $composableBuilder(
    column: $table.remainingMs,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TimersTableAnnotationComposer
    extends Composer<_$AppDatabase, $TimersTable> {
  $$TimersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<int> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get endsAtMs =>
      $composableBuilder(column: $table.endsAtMs, builder: (column) => column);

  GeneratedColumn<int> get remainingMs => $composableBuilder(
    column: $table.remainingMs,
    builder: (column) => column,
  );
}

class $$TimersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TimersTable,
          TimerRow,
          $$TimersTableFilterComposer,
          $$TimersTableOrderingComposer,
          $$TimersTableAnnotationComposer,
          $$TimersTableCreateCompanionBuilder,
          $$TimersTableUpdateCompanionBuilder,
          (TimerRow, BaseReferences<_$AppDatabase, $TimersTable, TimerRow>),
          TimerRow,
          PrefetchHooks Function()
        > {
  $$TimersTableTableManager(_$AppDatabase db, $TimersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TimersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TimersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TimersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> label = const Value.absent(),
                Value<int> durationMs = const Value.absent(),
                Value<int?> endsAtMs = const Value.absent(),
                Value<int?> remainingMs = const Value.absent(),
              }) => TimersCompanion(
                id: id,
                label: label,
                durationMs: durationMs,
                endsAtMs: endsAtMs,
                remainingMs: remainingMs,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> label = const Value.absent(),
                required int durationMs,
                Value<int?> endsAtMs = const Value.absent(),
                Value<int?> remainingMs = const Value.absent(),
              }) => TimersCompanion.insert(
                id: id,
                label: label,
                durationMs: durationMs,
                endsAtMs: endsAtMs,
                remainingMs: remainingMs,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TimersTable, TimerRow>(table),
                  BaseReferences<_$AppDatabase, $TimersTable, TimerRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TimersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TimersTable,
      TimerRow,
      $$TimersTableFilterComposer,
      $$TimersTableOrderingComposer,
      $$TimersTableAnnotationComposer,
      $$TimersTableCreateCompanionBuilder,
      $$TimersTableUpdateCompanionBuilder,
      (TimerRow, BaseReferences<_$AppDatabase, $TimersTable, TimerRow>),
      TimerRow,
      PrefetchHooks Function()
    >;
typedef $$WorldClocksTableCreateCompanionBuilder =
    WorldClocksCompanion Function({
      Value<int> id,
      required String city,
      required String tzName,
    });
typedef $$WorldClocksTableUpdateCompanionBuilder =
    WorldClocksCompanion Function({
      Value<int> id,
      Value<String> city,
      Value<String> tzName,
    });

class $$WorldClocksTableFilterComposer
    extends Composer<_$AppDatabase, $WorldClocksTable> {
  $$WorldClocksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tzName => $composableBuilder(
    column: $table.tzName,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WorldClocksTableOrderingComposer
    extends Composer<_$AppDatabase, $WorldClocksTable> {
  $$WorldClocksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tzName => $composableBuilder(
    column: $table.tzName,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WorldClocksTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorldClocksTable> {
  $$WorldClocksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get city =>
      $composableBuilder(column: $table.city, builder: (column) => column);

  GeneratedColumn<String> get tzName =>
      $composableBuilder(column: $table.tzName, builder: (column) => column);
}

class $$WorldClocksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WorldClocksTable,
          WorldClock,
          $$WorldClocksTableFilterComposer,
          $$WorldClocksTableOrderingComposer,
          $$WorldClocksTableAnnotationComposer,
          $$WorldClocksTableCreateCompanionBuilder,
          $$WorldClocksTableUpdateCompanionBuilder,
          (
            WorldClock,
            BaseReferences<_$AppDatabase, $WorldClocksTable, WorldClock>,
          ),
          WorldClock,
          PrefetchHooks Function()
        > {
  $$WorldClocksTableTableManager(_$AppDatabase db, $WorldClocksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorldClocksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorldClocksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorldClocksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> city = const Value.absent(),
            Value<String> tzName = const Value.absent(),
          }) => WorldClocksCompanion(id: id, city: city, tzName: tzName),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String city,
            required String tzName,
          }) => WorldClocksCompanion.insert(id: id, city: city, tzName: tzName),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$WorldClocksTable, WorldClock>(table),
                  BaseReferences<_$AppDatabase, $WorldClocksTable, WorldClock>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WorldClocksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WorldClocksTable,
      WorldClock,
      $$WorldClocksTableFilterComposer,
      $$WorldClocksTableOrderingComposer,
      $$WorldClocksTableAnnotationComposer,
      $$WorldClocksTableCreateCompanionBuilder,
      $$WorldClocksTableUpdateCompanionBuilder,
      (
        WorldClock,
        BaseReferences<_$AppDatabase, $WorldClocksTable, WorldClock>,
      ),
      WorldClock,
      PrefetchHooks Function()
    >;
typedef $$SettingsTableCreateCompanionBuilder = SettingsCompanion Function({
  required String key,
  required String value,
  Value<int> rowid,
});
typedef $$SettingsTableUpdateCompanionBuilder = SettingsCompanion Function({
  Value<String> key,
  Value<String> value,
  Value<int> rowid,
});

class $$SettingsTableFilterComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$SettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SettingsTable,
          Setting,
          $$SettingsTableFilterComposer,
          $$SettingsTableOrderingComposer,
          $$SettingsTableAnnotationComposer,
          $$SettingsTableCreateCompanionBuilder,
          $$SettingsTableUpdateCompanionBuilder,
          (Setting, BaseReferences<_$AppDatabase, $SettingsTable, Setting>),
          Setting,
          PrefetchHooks Function()
        > {
  $$SettingsTableTableManager(_$AppDatabase db, $SettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> key = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) => SettingsCompanion(key: key, value: value, rowid: rowid),
          createCompanionCallback: ({
            required String key,
            required String value,
            Value<int> rowid = const Value.absent(),
          }) => SettingsCompanion.insert(key: key, value: value, rowid: rowid),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SettingsTable, Setting>(table),
                  BaseReferences<_$AppDatabase, $SettingsTable, Setting>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SettingsTable,
      Setting,
      $$SettingsTableFilterComposer,
      $$SettingsTableOrderingComposer,
      $$SettingsTableAnnotationComposer,
      $$SettingsTableCreateCompanionBuilder,
      $$SettingsTableUpdateCompanionBuilder,
      (Setting, BaseReferences<_$AppDatabase, $SettingsTable, Setting>),
      Setting,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AlarmsTableTableManager get alarms =>
      $$AlarmsTableTableManager(_db, _db.alarms);
  $$TimersTableTableManager get timers =>
      $$TimersTableTableManager(_db, _db.timers);
  $$WorldClocksTableTableManager get worldClocks =>
      $$WorldClocksTableTableManager(_db, _db.worldClocks);
  $$SettingsTableTableManager get settings =>
      $$SettingsTableTableManager(_db, _db.settings);
}
