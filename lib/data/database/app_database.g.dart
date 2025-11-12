// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $WorkoutSessionsTable extends WorkoutSessions
    with TableInfo<$WorkoutSessionsTable, WorkoutSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<BigInt> timestamp = GeneratedColumn<BigInt>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.bigInt,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modeMeta = const VerificationMeta('mode');
  @override
  late final GeneratedColumn<String> mode = GeneratedColumn<String>(
    'mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _repsMeta = const VerificationMeta('reps');
  @override
  late final GeneratedColumn<int> reps = GeneratedColumn<int>(
    'reps',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weightPerCableKgMeta = const VerificationMeta(
    'weightPerCableKg',
  );
  @override
  late final GeneratedColumn<double> weightPerCableKg = GeneratedColumn<double>(
    'weight_per_cable_kg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _progressionKgMeta = const VerificationMeta(
    'progressionKg',
  );
  @override
  late final GeneratedColumn<double> progressionKg = GeneratedColumn<double>(
    'progression_kg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationMeta = const VerificationMeta(
    'duration',
  );
  @override
  late final GeneratedColumn<int> duration = GeneratedColumn<int>(
    'duration',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalRepsMeta = const VerificationMeta(
    'totalReps',
  );
  @override
  late final GeneratedColumn<int> totalReps = GeneratedColumn<int>(
    'total_reps',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _warmupRepsMeta = const VerificationMeta(
    'warmupReps',
  );
  @override
  late final GeneratedColumn<int> warmupReps = GeneratedColumn<int>(
    'warmup_reps',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _workingRepsMeta = const VerificationMeta(
    'workingReps',
  );
  @override
  late final GeneratedColumn<int> workingReps = GeneratedColumn<int>(
    'working_reps',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isJustLiftMeta = const VerificationMeta(
    'isJustLift',
  );
  @override
  late final GeneratedColumn<bool> isJustLift = GeneratedColumn<bool>(
    'is_just_lift',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_just_lift" IN (0, 1))',
    ),
  );
  static const VerificationMeta _stopAtTopMeta = const VerificationMeta(
    'stopAtTop',
  );
  @override
  late final GeneratedColumn<bool> stopAtTop = GeneratedColumn<bool>(
    'stop_at_top',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("stop_at_top" IN (0, 1))',
    ),
  );
  static const VerificationMeta _eccentricLoadMeta = const VerificationMeta(
    'eccentricLoad',
  );
  @override
  late final GeneratedColumn<int> eccentricLoad = GeneratedColumn<int>(
    'eccentric_load',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _echoLevelMeta = const VerificationMeta(
    'echoLevel',
  );
  @override
  late final GeneratedColumn<int> echoLevel = GeneratedColumn<int>(
    'echo_level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _exerciseIdMeta = const VerificationMeta(
    'exerciseId',
  );
  @override
  late final GeneratedColumn<String> exerciseId = GeneratedColumn<String>(
    'exercise_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    timestamp,
    mode,
    reps,
    weightPerCableKg,
    progressionKg,
    duration,
    totalReps,
    warmupReps,
    workingReps,
    isJustLift,
    stopAtTop,
    eccentricLoad,
    echoLevel,
    exerciseId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workout_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<WorkoutSession> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('mode')) {
      context.handle(
        _modeMeta,
        mode.isAcceptableOrUnknown(data['mode']!, _modeMeta),
      );
    } else if (isInserting) {
      context.missing(_modeMeta);
    }
    if (data.containsKey('reps')) {
      context.handle(
        _repsMeta,
        reps.isAcceptableOrUnknown(data['reps']!, _repsMeta),
      );
    } else if (isInserting) {
      context.missing(_repsMeta);
    }
    if (data.containsKey('weight_per_cable_kg')) {
      context.handle(
        _weightPerCableKgMeta,
        weightPerCableKg.isAcceptableOrUnknown(
          data['weight_per_cable_kg']!,
          _weightPerCableKgMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_weightPerCableKgMeta);
    }
    if (data.containsKey('progression_kg')) {
      context.handle(
        _progressionKgMeta,
        progressionKg.isAcceptableOrUnknown(
          data['progression_kg']!,
          _progressionKgMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_progressionKgMeta);
    }
    if (data.containsKey('duration')) {
      context.handle(
        _durationMeta,
        duration.isAcceptableOrUnknown(data['duration']!, _durationMeta),
      );
    } else if (isInserting) {
      context.missing(_durationMeta);
    }
    if (data.containsKey('total_reps')) {
      context.handle(
        _totalRepsMeta,
        totalReps.isAcceptableOrUnknown(data['total_reps']!, _totalRepsMeta),
      );
    } else if (isInserting) {
      context.missing(_totalRepsMeta);
    }
    if (data.containsKey('warmup_reps')) {
      context.handle(
        _warmupRepsMeta,
        warmupReps.isAcceptableOrUnknown(data['warmup_reps']!, _warmupRepsMeta),
      );
    } else if (isInserting) {
      context.missing(_warmupRepsMeta);
    }
    if (data.containsKey('working_reps')) {
      context.handle(
        _workingRepsMeta,
        workingReps.isAcceptableOrUnknown(
          data['working_reps']!,
          _workingRepsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_workingRepsMeta);
    }
    if (data.containsKey('is_just_lift')) {
      context.handle(
        _isJustLiftMeta,
        isJustLift.isAcceptableOrUnknown(
          data['is_just_lift']!,
          _isJustLiftMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_isJustLiftMeta);
    }
    if (data.containsKey('stop_at_top')) {
      context.handle(
        _stopAtTopMeta,
        stopAtTop.isAcceptableOrUnknown(data['stop_at_top']!, _stopAtTopMeta),
      );
    } else if (isInserting) {
      context.missing(_stopAtTopMeta);
    }
    if (data.containsKey('eccentric_load')) {
      context.handle(
        _eccentricLoadMeta,
        eccentricLoad.isAcceptableOrUnknown(
          data['eccentric_load']!,
          _eccentricLoadMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_eccentricLoadMeta);
    }
    if (data.containsKey('echo_level')) {
      context.handle(
        _echoLevelMeta,
        echoLevel.isAcceptableOrUnknown(data['echo_level']!, _echoLevelMeta),
      );
    } else if (isInserting) {
      context.missing(_echoLevelMeta);
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
        _exerciseIdMeta,
        exerciseId.isAcceptableOrUnknown(data['exercise_id']!, _exerciseIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkoutSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkoutSession(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.bigInt,
        data['${effectivePrefix}timestamp'],
      )!,
      mode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mode'],
      )!,
      reps: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reps'],
      )!,
      weightPerCableKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight_per_cable_kg'],
      )!,
      progressionKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}progression_kg'],
      )!,
      duration: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration'],
      )!,
      totalReps: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_reps'],
      )!,
      warmupReps: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}warmup_reps'],
      )!,
      workingReps: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}working_reps'],
      )!,
      isJustLift: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_just_lift'],
      )!,
      stopAtTop: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}stop_at_top'],
      )!,
      eccentricLoad: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}eccentric_load'],
      )!,
      echoLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}echo_level'],
      )!,
      exerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exercise_id'],
      ),
    );
  }

  @override
  $WorkoutSessionsTable createAlias(String alias) {
    return $WorkoutSessionsTable(attachedDatabase, alias);
  }
}

class WorkoutSession extends DataClass implements Insertable<WorkoutSession> {
  final String id;
  final BigInt timestamp;
  final String mode;
  final int reps;
  final double weightPerCableKg;
  final double progressionKg;
  final int duration;
  final int totalReps;
  final int warmupReps;
  final int workingReps;
  final bool isJustLift;
  final bool stopAtTop;
  final int eccentricLoad;
  final int echoLevel;
  final String? exerciseId;
  const WorkoutSession({
    required this.id,
    required this.timestamp,
    required this.mode,
    required this.reps,
    required this.weightPerCableKg,
    required this.progressionKg,
    required this.duration,
    required this.totalReps,
    required this.warmupReps,
    required this.workingReps,
    required this.isJustLift,
    required this.stopAtTop,
    required this.eccentricLoad,
    required this.echoLevel,
    this.exerciseId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['timestamp'] = Variable<BigInt>(timestamp);
    map['mode'] = Variable<String>(mode);
    map['reps'] = Variable<int>(reps);
    map['weight_per_cable_kg'] = Variable<double>(weightPerCableKg);
    map['progression_kg'] = Variable<double>(progressionKg);
    map['duration'] = Variable<int>(duration);
    map['total_reps'] = Variable<int>(totalReps);
    map['warmup_reps'] = Variable<int>(warmupReps);
    map['working_reps'] = Variable<int>(workingReps);
    map['is_just_lift'] = Variable<bool>(isJustLift);
    map['stop_at_top'] = Variable<bool>(stopAtTop);
    map['eccentric_load'] = Variable<int>(eccentricLoad);
    map['echo_level'] = Variable<int>(echoLevel);
    if (!nullToAbsent || exerciseId != null) {
      map['exercise_id'] = Variable<String>(exerciseId);
    }
    return map;
  }

  WorkoutSessionsCompanion toCompanion(bool nullToAbsent) {
    return WorkoutSessionsCompanion(
      id: Value(id),
      timestamp: Value(timestamp),
      mode: Value(mode),
      reps: Value(reps),
      weightPerCableKg: Value(weightPerCableKg),
      progressionKg: Value(progressionKg),
      duration: Value(duration),
      totalReps: Value(totalReps),
      warmupReps: Value(warmupReps),
      workingReps: Value(workingReps),
      isJustLift: Value(isJustLift),
      stopAtTop: Value(stopAtTop),
      eccentricLoad: Value(eccentricLoad),
      echoLevel: Value(echoLevel),
      exerciseId: exerciseId == null && nullToAbsent
          ? const Value.absent()
          : Value(exerciseId),
    );
  }

  factory WorkoutSession.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkoutSession(
      id: serializer.fromJson<String>(json['id']),
      timestamp: serializer.fromJson<BigInt>(json['timestamp']),
      mode: serializer.fromJson<String>(json['mode']),
      reps: serializer.fromJson<int>(json['reps']),
      weightPerCableKg: serializer.fromJson<double>(json['weightPerCableKg']),
      progressionKg: serializer.fromJson<double>(json['progressionKg']),
      duration: serializer.fromJson<int>(json['duration']),
      totalReps: serializer.fromJson<int>(json['totalReps']),
      warmupReps: serializer.fromJson<int>(json['warmupReps']),
      workingReps: serializer.fromJson<int>(json['workingReps']),
      isJustLift: serializer.fromJson<bool>(json['isJustLift']),
      stopAtTop: serializer.fromJson<bool>(json['stopAtTop']),
      eccentricLoad: serializer.fromJson<int>(json['eccentricLoad']),
      echoLevel: serializer.fromJson<int>(json['echoLevel']),
      exerciseId: serializer.fromJson<String?>(json['exerciseId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'timestamp': serializer.toJson<BigInt>(timestamp),
      'mode': serializer.toJson<String>(mode),
      'reps': serializer.toJson<int>(reps),
      'weightPerCableKg': serializer.toJson<double>(weightPerCableKg),
      'progressionKg': serializer.toJson<double>(progressionKg),
      'duration': serializer.toJson<int>(duration),
      'totalReps': serializer.toJson<int>(totalReps),
      'warmupReps': serializer.toJson<int>(warmupReps),
      'workingReps': serializer.toJson<int>(workingReps),
      'isJustLift': serializer.toJson<bool>(isJustLift),
      'stopAtTop': serializer.toJson<bool>(stopAtTop),
      'eccentricLoad': serializer.toJson<int>(eccentricLoad),
      'echoLevel': serializer.toJson<int>(echoLevel),
      'exerciseId': serializer.toJson<String?>(exerciseId),
    };
  }

  WorkoutSession copyWith({
    String? id,
    BigInt? timestamp,
    String? mode,
    int? reps,
    double? weightPerCableKg,
    double? progressionKg,
    int? duration,
    int? totalReps,
    int? warmupReps,
    int? workingReps,
    bool? isJustLift,
    bool? stopAtTop,
    int? eccentricLoad,
    int? echoLevel,
    Value<String?> exerciseId = const Value.absent(),
  }) => WorkoutSession(
    id: id ?? this.id,
    timestamp: timestamp ?? this.timestamp,
    mode: mode ?? this.mode,
    reps: reps ?? this.reps,
    weightPerCableKg: weightPerCableKg ?? this.weightPerCableKg,
    progressionKg: progressionKg ?? this.progressionKg,
    duration: duration ?? this.duration,
    totalReps: totalReps ?? this.totalReps,
    warmupReps: warmupReps ?? this.warmupReps,
    workingReps: workingReps ?? this.workingReps,
    isJustLift: isJustLift ?? this.isJustLift,
    stopAtTop: stopAtTop ?? this.stopAtTop,
    eccentricLoad: eccentricLoad ?? this.eccentricLoad,
    echoLevel: echoLevel ?? this.echoLevel,
    exerciseId: exerciseId.present ? exerciseId.value : this.exerciseId,
  );
  WorkoutSession copyWithCompanion(WorkoutSessionsCompanion data) {
    return WorkoutSession(
      id: data.id.present ? data.id.value : this.id,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      mode: data.mode.present ? data.mode.value : this.mode,
      reps: data.reps.present ? data.reps.value : this.reps,
      weightPerCableKg: data.weightPerCableKg.present
          ? data.weightPerCableKg.value
          : this.weightPerCableKg,
      progressionKg: data.progressionKg.present
          ? data.progressionKg.value
          : this.progressionKg,
      duration: data.duration.present ? data.duration.value : this.duration,
      totalReps: data.totalReps.present ? data.totalReps.value : this.totalReps,
      warmupReps: data.warmupReps.present
          ? data.warmupReps.value
          : this.warmupReps,
      workingReps: data.workingReps.present
          ? data.workingReps.value
          : this.workingReps,
      isJustLift: data.isJustLift.present
          ? data.isJustLift.value
          : this.isJustLift,
      stopAtTop: data.stopAtTop.present ? data.stopAtTop.value : this.stopAtTop,
      eccentricLoad: data.eccentricLoad.present
          ? data.eccentricLoad.value
          : this.eccentricLoad,
      echoLevel: data.echoLevel.present ? data.echoLevel.value : this.echoLevel,
      exerciseId: data.exerciseId.present
          ? data.exerciseId.value
          : this.exerciseId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutSession(')
          ..write('id: $id, ')
          ..write('timestamp: $timestamp, ')
          ..write('mode: $mode, ')
          ..write('reps: $reps, ')
          ..write('weightPerCableKg: $weightPerCableKg, ')
          ..write('progressionKg: $progressionKg, ')
          ..write('duration: $duration, ')
          ..write('totalReps: $totalReps, ')
          ..write('warmupReps: $warmupReps, ')
          ..write('workingReps: $workingReps, ')
          ..write('isJustLift: $isJustLift, ')
          ..write('stopAtTop: $stopAtTop, ')
          ..write('eccentricLoad: $eccentricLoad, ')
          ..write('echoLevel: $echoLevel, ')
          ..write('exerciseId: $exerciseId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    timestamp,
    mode,
    reps,
    weightPerCableKg,
    progressionKg,
    duration,
    totalReps,
    warmupReps,
    workingReps,
    isJustLift,
    stopAtTop,
    eccentricLoad,
    echoLevel,
    exerciseId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkoutSession &&
          other.id == this.id &&
          other.timestamp == this.timestamp &&
          other.mode == this.mode &&
          other.reps == this.reps &&
          other.weightPerCableKg == this.weightPerCableKg &&
          other.progressionKg == this.progressionKg &&
          other.duration == this.duration &&
          other.totalReps == this.totalReps &&
          other.warmupReps == this.warmupReps &&
          other.workingReps == this.workingReps &&
          other.isJustLift == this.isJustLift &&
          other.stopAtTop == this.stopAtTop &&
          other.eccentricLoad == this.eccentricLoad &&
          other.echoLevel == this.echoLevel &&
          other.exerciseId == this.exerciseId);
}

class WorkoutSessionsCompanion extends UpdateCompanion<WorkoutSession> {
  final Value<String> id;
  final Value<BigInt> timestamp;
  final Value<String> mode;
  final Value<int> reps;
  final Value<double> weightPerCableKg;
  final Value<double> progressionKg;
  final Value<int> duration;
  final Value<int> totalReps;
  final Value<int> warmupReps;
  final Value<int> workingReps;
  final Value<bool> isJustLift;
  final Value<bool> stopAtTop;
  final Value<int> eccentricLoad;
  final Value<int> echoLevel;
  final Value<String?> exerciseId;
  final Value<int> rowid;
  const WorkoutSessionsCompanion({
    this.id = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.mode = const Value.absent(),
    this.reps = const Value.absent(),
    this.weightPerCableKg = const Value.absent(),
    this.progressionKg = const Value.absent(),
    this.duration = const Value.absent(),
    this.totalReps = const Value.absent(),
    this.warmupReps = const Value.absent(),
    this.workingReps = const Value.absent(),
    this.isJustLift = const Value.absent(),
    this.stopAtTop = const Value.absent(),
    this.eccentricLoad = const Value.absent(),
    this.echoLevel = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkoutSessionsCompanion.insert({
    required String id,
    required BigInt timestamp,
    required String mode,
    required int reps,
    required double weightPerCableKg,
    required double progressionKg,
    required int duration,
    required int totalReps,
    required int warmupReps,
    required int workingReps,
    required bool isJustLift,
    required bool stopAtTop,
    required int eccentricLoad,
    required int echoLevel,
    this.exerciseId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       timestamp = Value(timestamp),
       mode = Value(mode),
       reps = Value(reps),
       weightPerCableKg = Value(weightPerCableKg),
       progressionKg = Value(progressionKg),
       duration = Value(duration),
       totalReps = Value(totalReps),
       warmupReps = Value(warmupReps),
       workingReps = Value(workingReps),
       isJustLift = Value(isJustLift),
       stopAtTop = Value(stopAtTop),
       eccentricLoad = Value(eccentricLoad),
       echoLevel = Value(echoLevel);
  static Insertable<WorkoutSession> custom({
    Expression<String>? id,
    Expression<BigInt>? timestamp,
    Expression<String>? mode,
    Expression<int>? reps,
    Expression<double>? weightPerCableKg,
    Expression<double>? progressionKg,
    Expression<int>? duration,
    Expression<int>? totalReps,
    Expression<int>? warmupReps,
    Expression<int>? workingReps,
    Expression<bool>? isJustLift,
    Expression<bool>? stopAtTop,
    Expression<int>? eccentricLoad,
    Expression<int>? echoLevel,
    Expression<String>? exerciseId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (timestamp != null) 'timestamp': timestamp,
      if (mode != null) 'mode': mode,
      if (reps != null) 'reps': reps,
      if (weightPerCableKg != null) 'weight_per_cable_kg': weightPerCableKg,
      if (progressionKg != null) 'progression_kg': progressionKg,
      if (duration != null) 'duration': duration,
      if (totalReps != null) 'total_reps': totalReps,
      if (warmupReps != null) 'warmup_reps': warmupReps,
      if (workingReps != null) 'working_reps': workingReps,
      if (isJustLift != null) 'is_just_lift': isJustLift,
      if (stopAtTop != null) 'stop_at_top': stopAtTop,
      if (eccentricLoad != null) 'eccentric_load': eccentricLoad,
      if (echoLevel != null) 'echo_level': echoLevel,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkoutSessionsCompanion copyWith({
    Value<String>? id,
    Value<BigInt>? timestamp,
    Value<String>? mode,
    Value<int>? reps,
    Value<double>? weightPerCableKg,
    Value<double>? progressionKg,
    Value<int>? duration,
    Value<int>? totalReps,
    Value<int>? warmupReps,
    Value<int>? workingReps,
    Value<bool>? isJustLift,
    Value<bool>? stopAtTop,
    Value<int>? eccentricLoad,
    Value<int>? echoLevel,
    Value<String?>? exerciseId,
    Value<int>? rowid,
  }) {
    return WorkoutSessionsCompanion(
      id: id ?? this.id,
      timestamp: timestamp ?? this.timestamp,
      mode: mode ?? this.mode,
      reps: reps ?? this.reps,
      weightPerCableKg: weightPerCableKg ?? this.weightPerCableKg,
      progressionKg: progressionKg ?? this.progressionKg,
      duration: duration ?? this.duration,
      totalReps: totalReps ?? this.totalReps,
      warmupReps: warmupReps ?? this.warmupReps,
      workingReps: workingReps ?? this.workingReps,
      isJustLift: isJustLift ?? this.isJustLift,
      stopAtTop: stopAtTop ?? this.stopAtTop,
      eccentricLoad: eccentricLoad ?? this.eccentricLoad,
      echoLevel: echoLevel ?? this.echoLevel,
      exerciseId: exerciseId ?? this.exerciseId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<BigInt>(timestamp.value);
    }
    if (mode.present) {
      map['mode'] = Variable<String>(mode.value);
    }
    if (reps.present) {
      map['reps'] = Variable<int>(reps.value);
    }
    if (weightPerCableKg.present) {
      map['weight_per_cable_kg'] = Variable<double>(weightPerCableKg.value);
    }
    if (progressionKg.present) {
      map['progression_kg'] = Variable<double>(progressionKg.value);
    }
    if (duration.present) {
      map['duration'] = Variable<int>(duration.value);
    }
    if (totalReps.present) {
      map['total_reps'] = Variable<int>(totalReps.value);
    }
    if (warmupReps.present) {
      map['warmup_reps'] = Variable<int>(warmupReps.value);
    }
    if (workingReps.present) {
      map['working_reps'] = Variable<int>(workingReps.value);
    }
    if (isJustLift.present) {
      map['is_just_lift'] = Variable<bool>(isJustLift.value);
    }
    if (stopAtTop.present) {
      map['stop_at_top'] = Variable<bool>(stopAtTop.value);
    }
    if (eccentricLoad.present) {
      map['eccentric_load'] = Variable<int>(eccentricLoad.value);
    }
    if (echoLevel.present) {
      map['echo_level'] = Variable<int>(echoLevel.value);
    }
    if (exerciseId.present) {
      map['exercise_id'] = Variable<String>(exerciseId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutSessionsCompanion(')
          ..write('id: $id, ')
          ..write('timestamp: $timestamp, ')
          ..write('mode: $mode, ')
          ..write('reps: $reps, ')
          ..write('weightPerCableKg: $weightPerCableKg, ')
          ..write('progressionKg: $progressionKg, ')
          ..write('duration: $duration, ')
          ..write('totalReps: $totalReps, ')
          ..write('warmupReps: $warmupReps, ')
          ..write('workingReps: $workingReps, ')
          ..write('isJustLift: $isJustLift, ')
          ..write('stopAtTop: $stopAtTop, ')
          ..write('eccentricLoad: $eccentricLoad, ')
          ..write('echoLevel: $echoLevel, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WorkoutMetricsTable extends WorkoutMetrics
    with TableInfo<$WorkoutMetricsTable, WorkoutMetric> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutMetricsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<BigInt> timestamp = GeneratedColumn<BigInt>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.bigInt,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _loadAMeta = const VerificationMeta('loadA');
  @override
  late final GeneratedColumn<double> loadA = GeneratedColumn<double>(
    'load_a',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _loadBMeta = const VerificationMeta('loadB');
  @override
  late final GeneratedColumn<double> loadB = GeneratedColumn<double>(
    'load_b',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _positionAMeta = const VerificationMeta(
    'positionA',
  );
  @override
  late final GeneratedColumn<int> positionA = GeneratedColumn<int>(
    'position_a',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _positionBMeta = const VerificationMeta(
    'positionB',
  );
  @override
  late final GeneratedColumn<int> positionB = GeneratedColumn<int>(
    'position_b',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ticksMeta = const VerificationMeta('ticks');
  @override
  late final GeneratedColumn<int> ticks = GeneratedColumn<int>(
    'ticks',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _velocityAMeta = const VerificationMeta(
    'velocityA',
  );
  @override
  late final GeneratedColumn<double> velocityA = GeneratedColumn<double>(
    'velocity_a',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _velocityBMeta = const VerificationMeta(
    'velocityB',
  );
  @override
  late final GeneratedColumn<double> velocityB = GeneratedColumn<double>(
    'velocity_b',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _powerMeta = const VerificationMeta('power');
  @override
  late final GeneratedColumn<double> power = GeneratedColumn<double>(
    'power',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sessionId,
    timestamp,
    loadA,
    loadB,
    positionA,
    positionB,
    ticks,
    velocityA,
    velocityB,
    power,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workout_metrics';
  @override
  VerificationContext validateIntegrity(
    Insertable<WorkoutMetric> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('load_a')) {
      context.handle(
        _loadAMeta,
        loadA.isAcceptableOrUnknown(data['load_a']!, _loadAMeta),
      );
    } else if (isInserting) {
      context.missing(_loadAMeta);
    }
    if (data.containsKey('load_b')) {
      context.handle(
        _loadBMeta,
        loadB.isAcceptableOrUnknown(data['load_b']!, _loadBMeta),
      );
    } else if (isInserting) {
      context.missing(_loadBMeta);
    }
    if (data.containsKey('position_a')) {
      context.handle(
        _positionAMeta,
        positionA.isAcceptableOrUnknown(data['position_a']!, _positionAMeta),
      );
    } else if (isInserting) {
      context.missing(_positionAMeta);
    }
    if (data.containsKey('position_b')) {
      context.handle(
        _positionBMeta,
        positionB.isAcceptableOrUnknown(data['position_b']!, _positionBMeta),
      );
    } else if (isInserting) {
      context.missing(_positionBMeta);
    }
    if (data.containsKey('ticks')) {
      context.handle(
        _ticksMeta,
        ticks.isAcceptableOrUnknown(data['ticks']!, _ticksMeta),
      );
    } else if (isInserting) {
      context.missing(_ticksMeta);
    }
    if (data.containsKey('velocity_a')) {
      context.handle(
        _velocityAMeta,
        velocityA.isAcceptableOrUnknown(data['velocity_a']!, _velocityAMeta),
      );
    } else if (isInserting) {
      context.missing(_velocityAMeta);
    }
    if (data.containsKey('velocity_b')) {
      context.handle(
        _velocityBMeta,
        velocityB.isAcceptableOrUnknown(data['velocity_b']!, _velocityBMeta),
      );
    } else if (isInserting) {
      context.missing(_velocityBMeta);
    }
    if (data.containsKey('power')) {
      context.handle(
        _powerMeta,
        power.isAcceptableOrUnknown(data['power']!, _powerMeta),
      );
    } else if (isInserting) {
      context.missing(_powerMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkoutMetric map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkoutMetric(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_id'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.bigInt,
        data['${effectivePrefix}timestamp'],
      )!,
      loadA: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}load_a'],
      )!,
      loadB: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}load_b'],
      )!,
      positionA: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position_a'],
      )!,
      positionB: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position_b'],
      )!,
      ticks: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ticks'],
      )!,
      velocityA: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}velocity_a'],
      )!,
      velocityB: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}velocity_b'],
      )!,
      power: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}power'],
      )!,
    );
  }

  @override
  $WorkoutMetricsTable createAlias(String alias) {
    return $WorkoutMetricsTable(attachedDatabase, alias);
  }
}

class WorkoutMetric extends DataClass implements Insertable<WorkoutMetric> {
  final int id;
  final String sessionId;
  final BigInt timestamp;
  final double loadA;
  final double loadB;
  final int positionA;
  final int positionB;
  final int ticks;
  final double velocityA;
  final double velocityB;
  final double power;
  const WorkoutMetric({
    required this.id,
    required this.sessionId,
    required this.timestamp,
    required this.loadA,
    required this.loadB,
    required this.positionA,
    required this.positionB,
    required this.ticks,
    required this.velocityA,
    required this.velocityB,
    required this.power,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['session_id'] = Variable<String>(sessionId);
    map['timestamp'] = Variable<BigInt>(timestamp);
    map['load_a'] = Variable<double>(loadA);
    map['load_b'] = Variable<double>(loadB);
    map['position_a'] = Variable<int>(positionA);
    map['position_b'] = Variable<int>(positionB);
    map['ticks'] = Variable<int>(ticks);
    map['velocity_a'] = Variable<double>(velocityA);
    map['velocity_b'] = Variable<double>(velocityB);
    map['power'] = Variable<double>(power);
    return map;
  }

  WorkoutMetricsCompanion toCompanion(bool nullToAbsent) {
    return WorkoutMetricsCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      timestamp: Value(timestamp),
      loadA: Value(loadA),
      loadB: Value(loadB),
      positionA: Value(positionA),
      positionB: Value(positionB),
      ticks: Value(ticks),
      velocityA: Value(velocityA),
      velocityB: Value(velocityB),
      power: Value(power),
    );
  }

  factory WorkoutMetric.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkoutMetric(
      id: serializer.fromJson<int>(json['id']),
      sessionId: serializer.fromJson<String>(json['sessionId']),
      timestamp: serializer.fromJson<BigInt>(json['timestamp']),
      loadA: serializer.fromJson<double>(json['loadA']),
      loadB: serializer.fromJson<double>(json['loadB']),
      positionA: serializer.fromJson<int>(json['positionA']),
      positionB: serializer.fromJson<int>(json['positionB']),
      ticks: serializer.fromJson<int>(json['ticks']),
      velocityA: serializer.fromJson<double>(json['velocityA']),
      velocityB: serializer.fromJson<double>(json['velocityB']),
      power: serializer.fromJson<double>(json['power']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sessionId': serializer.toJson<String>(sessionId),
      'timestamp': serializer.toJson<BigInt>(timestamp),
      'loadA': serializer.toJson<double>(loadA),
      'loadB': serializer.toJson<double>(loadB),
      'positionA': serializer.toJson<int>(positionA),
      'positionB': serializer.toJson<int>(positionB),
      'ticks': serializer.toJson<int>(ticks),
      'velocityA': serializer.toJson<double>(velocityA),
      'velocityB': serializer.toJson<double>(velocityB),
      'power': serializer.toJson<double>(power),
    };
  }

  WorkoutMetric copyWith({
    int? id,
    String? sessionId,
    BigInt? timestamp,
    double? loadA,
    double? loadB,
    int? positionA,
    int? positionB,
    int? ticks,
    double? velocityA,
    double? velocityB,
    double? power,
  }) => WorkoutMetric(
    id: id ?? this.id,
    sessionId: sessionId ?? this.sessionId,
    timestamp: timestamp ?? this.timestamp,
    loadA: loadA ?? this.loadA,
    loadB: loadB ?? this.loadB,
    positionA: positionA ?? this.positionA,
    positionB: positionB ?? this.positionB,
    ticks: ticks ?? this.ticks,
    velocityA: velocityA ?? this.velocityA,
    velocityB: velocityB ?? this.velocityB,
    power: power ?? this.power,
  );
  WorkoutMetric copyWithCompanion(WorkoutMetricsCompanion data) {
    return WorkoutMetric(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      loadA: data.loadA.present ? data.loadA.value : this.loadA,
      loadB: data.loadB.present ? data.loadB.value : this.loadB,
      positionA: data.positionA.present ? data.positionA.value : this.positionA,
      positionB: data.positionB.present ? data.positionB.value : this.positionB,
      ticks: data.ticks.present ? data.ticks.value : this.ticks,
      velocityA: data.velocityA.present ? data.velocityA.value : this.velocityA,
      velocityB: data.velocityB.present ? data.velocityB.value : this.velocityB,
      power: data.power.present ? data.power.value : this.power,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutMetric(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('timestamp: $timestamp, ')
          ..write('loadA: $loadA, ')
          ..write('loadB: $loadB, ')
          ..write('positionA: $positionA, ')
          ..write('positionB: $positionB, ')
          ..write('ticks: $ticks, ')
          ..write('velocityA: $velocityA, ')
          ..write('velocityB: $velocityB, ')
          ..write('power: $power')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sessionId,
    timestamp,
    loadA,
    loadB,
    positionA,
    positionB,
    ticks,
    velocityA,
    velocityB,
    power,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkoutMetric &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.timestamp == this.timestamp &&
          other.loadA == this.loadA &&
          other.loadB == this.loadB &&
          other.positionA == this.positionA &&
          other.positionB == this.positionB &&
          other.ticks == this.ticks &&
          other.velocityA == this.velocityA &&
          other.velocityB == this.velocityB &&
          other.power == this.power);
}

class WorkoutMetricsCompanion extends UpdateCompanion<WorkoutMetric> {
  final Value<int> id;
  final Value<String> sessionId;
  final Value<BigInt> timestamp;
  final Value<double> loadA;
  final Value<double> loadB;
  final Value<int> positionA;
  final Value<int> positionB;
  final Value<int> ticks;
  final Value<double> velocityA;
  final Value<double> velocityB;
  final Value<double> power;
  const WorkoutMetricsCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.loadA = const Value.absent(),
    this.loadB = const Value.absent(),
    this.positionA = const Value.absent(),
    this.positionB = const Value.absent(),
    this.ticks = const Value.absent(),
    this.velocityA = const Value.absent(),
    this.velocityB = const Value.absent(),
    this.power = const Value.absent(),
  });
  WorkoutMetricsCompanion.insert({
    this.id = const Value.absent(),
    required String sessionId,
    required BigInt timestamp,
    required double loadA,
    required double loadB,
    required int positionA,
    required int positionB,
    required int ticks,
    required double velocityA,
    required double velocityB,
    required double power,
  }) : sessionId = Value(sessionId),
       timestamp = Value(timestamp),
       loadA = Value(loadA),
       loadB = Value(loadB),
       positionA = Value(positionA),
       positionB = Value(positionB),
       ticks = Value(ticks),
       velocityA = Value(velocityA),
       velocityB = Value(velocityB),
       power = Value(power);
  static Insertable<WorkoutMetric> custom({
    Expression<int>? id,
    Expression<String>? sessionId,
    Expression<BigInt>? timestamp,
    Expression<double>? loadA,
    Expression<double>? loadB,
    Expression<int>? positionA,
    Expression<int>? positionB,
    Expression<int>? ticks,
    Expression<double>? velocityA,
    Expression<double>? velocityB,
    Expression<double>? power,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (timestamp != null) 'timestamp': timestamp,
      if (loadA != null) 'load_a': loadA,
      if (loadB != null) 'load_b': loadB,
      if (positionA != null) 'position_a': positionA,
      if (positionB != null) 'position_b': positionB,
      if (ticks != null) 'ticks': ticks,
      if (velocityA != null) 'velocity_a': velocityA,
      if (velocityB != null) 'velocity_b': velocityB,
      if (power != null) 'power': power,
    });
  }

  WorkoutMetricsCompanion copyWith({
    Value<int>? id,
    Value<String>? sessionId,
    Value<BigInt>? timestamp,
    Value<double>? loadA,
    Value<double>? loadB,
    Value<int>? positionA,
    Value<int>? positionB,
    Value<int>? ticks,
    Value<double>? velocityA,
    Value<double>? velocityB,
    Value<double>? power,
  }) {
    return WorkoutMetricsCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      timestamp: timestamp ?? this.timestamp,
      loadA: loadA ?? this.loadA,
      loadB: loadB ?? this.loadB,
      positionA: positionA ?? this.positionA,
      positionB: positionB ?? this.positionB,
      ticks: ticks ?? this.ticks,
      velocityA: velocityA ?? this.velocityA,
      velocityB: velocityB ?? this.velocityB,
      power: power ?? this.power,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<BigInt>(timestamp.value);
    }
    if (loadA.present) {
      map['load_a'] = Variable<double>(loadA.value);
    }
    if (loadB.present) {
      map['load_b'] = Variable<double>(loadB.value);
    }
    if (positionA.present) {
      map['position_a'] = Variable<int>(positionA.value);
    }
    if (positionB.present) {
      map['position_b'] = Variable<int>(positionB.value);
    }
    if (ticks.present) {
      map['ticks'] = Variable<int>(ticks.value);
    }
    if (velocityA.present) {
      map['velocity_a'] = Variable<double>(velocityA.value);
    }
    if (velocityB.present) {
      map['velocity_b'] = Variable<double>(velocityB.value);
    }
    if (power.present) {
      map['power'] = Variable<double>(power.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutMetricsCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('timestamp: $timestamp, ')
          ..write('loadA: $loadA, ')
          ..write('loadB: $loadB, ')
          ..write('positionA: $positionA, ')
          ..write('positionB: $positionB, ')
          ..write('ticks: $ticks, ')
          ..write('velocityA: $velocityA, ')
          ..write('velocityB: $velocityB, ')
          ..write('power: $power')
          ..write(')'))
        .toString();
  }
}

class $RoutinesTable extends Routines with TableInfo<$RoutinesTable, Routine> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RoutinesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<BigInt> createdAt = GeneratedColumn<BigInt>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.bigInt,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastUsedMeta = const VerificationMeta(
    'lastUsed',
  );
  @override
  late final GeneratedColumn<BigInt> lastUsed = GeneratedColumn<BigInt>(
    'last_used',
    aliasedName,
    false,
    type: DriftSqlType.bigInt,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _exerciseCountMeta = const VerificationMeta(
    'exerciseCount',
  );
  @override
  late final GeneratedColumn<int> exerciseCount = GeneratedColumn<int>(
    'exercise_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    createdAt,
    lastUsed,
    exerciseCount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'routines';
  @override
  VerificationContext validateIntegrity(
    Insertable<Routine> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('last_used')) {
      context.handle(
        _lastUsedMeta,
        lastUsed.isAcceptableOrUnknown(data['last_used']!, _lastUsedMeta),
      );
    } else if (isInserting) {
      context.missing(_lastUsedMeta);
    }
    if (data.containsKey('exercise_count')) {
      context.handle(
        _exerciseCountMeta,
        exerciseCount.isAcceptableOrUnknown(
          data['exercise_count']!,
          _exerciseCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_exerciseCountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Routine map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Routine(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.bigInt,
        data['${effectivePrefix}created_at'],
      )!,
      lastUsed: attachedDatabase.typeMapping.read(
        DriftSqlType.bigInt,
        data['${effectivePrefix}last_used'],
      )!,
      exerciseCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}exercise_count'],
      )!,
    );
  }

  @override
  $RoutinesTable createAlias(String alias) {
    return $RoutinesTable(attachedDatabase, alias);
  }
}

class Routine extends DataClass implements Insertable<Routine> {
  final String id;
  final String name;
  final BigInt createdAt;
  final BigInt lastUsed;
  final int exerciseCount;
  const Routine({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.lastUsed,
    required this.exerciseCount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['created_at'] = Variable<BigInt>(createdAt);
    map['last_used'] = Variable<BigInt>(lastUsed);
    map['exercise_count'] = Variable<int>(exerciseCount);
    return map;
  }

  RoutinesCompanion toCompanion(bool nullToAbsent) {
    return RoutinesCompanion(
      id: Value(id),
      name: Value(name),
      createdAt: Value(createdAt),
      lastUsed: Value(lastUsed),
      exerciseCount: Value(exerciseCount),
    );
  }

  factory Routine.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Routine(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      createdAt: serializer.fromJson<BigInt>(json['createdAt']),
      lastUsed: serializer.fromJson<BigInt>(json['lastUsed']),
      exerciseCount: serializer.fromJson<int>(json['exerciseCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'createdAt': serializer.toJson<BigInt>(createdAt),
      'lastUsed': serializer.toJson<BigInt>(lastUsed),
      'exerciseCount': serializer.toJson<int>(exerciseCount),
    };
  }

  Routine copyWith({
    String? id,
    String? name,
    BigInt? createdAt,
    BigInt? lastUsed,
    int? exerciseCount,
  }) => Routine(
    id: id ?? this.id,
    name: name ?? this.name,
    createdAt: createdAt ?? this.createdAt,
    lastUsed: lastUsed ?? this.lastUsed,
    exerciseCount: exerciseCount ?? this.exerciseCount,
  );
  Routine copyWithCompanion(RoutinesCompanion data) {
    return Routine(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      lastUsed: data.lastUsed.present ? data.lastUsed.value : this.lastUsed,
      exerciseCount: data.exerciseCount.present
          ? data.exerciseCount.value
          : this.exerciseCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Routine(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastUsed: $lastUsed, ')
          ..write('exerciseCount: $exerciseCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, createdAt, lastUsed, exerciseCount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Routine &&
          other.id == this.id &&
          other.name == this.name &&
          other.createdAt == this.createdAt &&
          other.lastUsed == this.lastUsed &&
          other.exerciseCount == this.exerciseCount);
}

class RoutinesCompanion extends UpdateCompanion<Routine> {
  final Value<String> id;
  final Value<String> name;
  final Value<BigInt> createdAt;
  final Value<BigInt> lastUsed;
  final Value<int> exerciseCount;
  final Value<int> rowid;
  const RoutinesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastUsed = const Value.absent(),
    this.exerciseCount = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RoutinesCompanion.insert({
    required String id,
    required String name,
    required BigInt createdAt,
    required BigInt lastUsed,
    required int exerciseCount,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       createdAt = Value(createdAt),
       lastUsed = Value(lastUsed),
       exerciseCount = Value(exerciseCount);
  static Insertable<Routine> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<BigInt>? createdAt,
    Expression<BigInt>? lastUsed,
    Expression<int>? exerciseCount,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (createdAt != null) 'created_at': createdAt,
      if (lastUsed != null) 'last_used': lastUsed,
      if (exerciseCount != null) 'exercise_count': exerciseCount,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RoutinesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<BigInt>? createdAt,
    Value<BigInt>? lastUsed,
    Value<int>? exerciseCount,
    Value<int>? rowid,
  }) {
    return RoutinesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      lastUsed: lastUsed ?? this.lastUsed,
      exerciseCount: exerciseCount ?? this.exerciseCount,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<BigInt>(createdAt.value);
    }
    if (lastUsed.present) {
      map['last_used'] = Variable<BigInt>(lastUsed.value);
    }
    if (exerciseCount.present) {
      map['exercise_count'] = Variable<int>(exerciseCount.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoutinesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastUsed: $lastUsed, ')
          ..write('exerciseCount: $exerciseCount, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RoutineExercisesTable extends RoutineExercises
    with TableInfo<$RoutineExercisesTable, RoutineExercise> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RoutineExercisesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _routineIdMeta = const VerificationMeta(
    'routineId',
  );
  @override
  late final GeneratedColumn<String> routineId = GeneratedColumn<String>(
    'routine_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES routines (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _exerciseIdMeta = const VerificationMeta(
    'exerciseId',
  );
  @override
  late final GeneratedColumn<String> exerciseId = GeneratedColumn<String>(
    'exercise_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
    'order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _setsMeta = const VerificationMeta('sets');
  @override
  late final GeneratedColumn<int> sets = GeneratedColumn<int>(
    'sets',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _repsMeta = const VerificationMeta('reps');
  @override
  late final GeneratedColumn<int> reps = GeneratedColumn<int>(
    'reps',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weightPerCableKgMeta = const VerificationMeta(
    'weightPerCableKg',
  );
  @override
  late final GeneratedColumn<double> weightPerCableKg = GeneratedColumn<double>(
    'weight_per_cable_kg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modeMeta = const VerificationMeta('mode');
  @override
  late final GeneratedColumn<String> mode = GeneratedColumn<String>(
    'mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _eccentricLoadMeta = const VerificationMeta(
    'eccentricLoad',
  );
  @override
  late final GeneratedColumn<int> eccentricLoad = GeneratedColumn<int>(
    'eccentric_load',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _echoLevelMeta = const VerificationMeta(
    'echoLevel',
  );
  @override
  late final GeneratedColumn<int> echoLevel = GeneratedColumn<int>(
    'echo_level',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    routineId,
    exerciseId,
    order,
    sets,
    reps,
    weightPerCableKg,
    mode,
    eccentricLoad,
    echoLevel,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'routine_exercises';
  @override
  VerificationContext validateIntegrity(
    Insertable<RoutineExercise> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('routine_id')) {
      context.handle(
        _routineIdMeta,
        routineId.isAcceptableOrUnknown(data['routine_id']!, _routineIdMeta),
      );
    } else if (isInserting) {
      context.missing(_routineIdMeta);
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
        _exerciseIdMeta,
        exerciseId.isAcceptableOrUnknown(data['exercise_id']!, _exerciseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
    }
    if (data.containsKey('order')) {
      context.handle(
        _orderMeta,
        order.isAcceptableOrUnknown(data['order']!, _orderMeta),
      );
    } else if (isInserting) {
      context.missing(_orderMeta);
    }
    if (data.containsKey('sets')) {
      context.handle(
        _setsMeta,
        sets.isAcceptableOrUnknown(data['sets']!, _setsMeta),
      );
    } else if (isInserting) {
      context.missing(_setsMeta);
    }
    if (data.containsKey('reps')) {
      context.handle(
        _repsMeta,
        reps.isAcceptableOrUnknown(data['reps']!, _repsMeta),
      );
    } else if (isInserting) {
      context.missing(_repsMeta);
    }
    if (data.containsKey('weight_per_cable_kg')) {
      context.handle(
        _weightPerCableKgMeta,
        weightPerCableKg.isAcceptableOrUnknown(
          data['weight_per_cable_kg']!,
          _weightPerCableKgMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_weightPerCableKgMeta);
    }
    if (data.containsKey('mode')) {
      context.handle(
        _modeMeta,
        mode.isAcceptableOrUnknown(data['mode']!, _modeMeta),
      );
    } else if (isInserting) {
      context.missing(_modeMeta);
    }
    if (data.containsKey('eccentric_load')) {
      context.handle(
        _eccentricLoadMeta,
        eccentricLoad.isAcceptableOrUnknown(
          data['eccentric_load']!,
          _eccentricLoadMeta,
        ),
      );
    }
    if (data.containsKey('echo_level')) {
      context.handle(
        _echoLevelMeta,
        echoLevel.isAcceptableOrUnknown(data['echo_level']!, _echoLevelMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RoutineExercise map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RoutineExercise(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      routineId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}routine_id'],
      )!,
      exerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exercise_id'],
      )!,
      order: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order'],
      )!,
      sets: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sets'],
      )!,
      reps: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reps'],
      )!,
      weightPerCableKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight_per_cable_kg'],
      )!,
      mode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mode'],
      )!,
      eccentricLoad: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}eccentric_load'],
      ),
      echoLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}echo_level'],
      ),
    );
  }

  @override
  $RoutineExercisesTable createAlias(String alias) {
    return $RoutineExercisesTable(attachedDatabase, alias);
  }
}

class RoutineExercise extends DataClass implements Insertable<RoutineExercise> {
  final int id;
  final String routineId;
  final String exerciseId;
  final int order;
  final int sets;
  final int reps;
  final double weightPerCableKg;
  final String mode;
  final int? eccentricLoad;
  final int? echoLevel;
  const RoutineExercise({
    required this.id,
    required this.routineId,
    required this.exerciseId,
    required this.order,
    required this.sets,
    required this.reps,
    required this.weightPerCableKg,
    required this.mode,
    this.eccentricLoad,
    this.echoLevel,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['routine_id'] = Variable<String>(routineId);
    map['exercise_id'] = Variable<String>(exerciseId);
    map['order'] = Variable<int>(order);
    map['sets'] = Variable<int>(sets);
    map['reps'] = Variable<int>(reps);
    map['weight_per_cable_kg'] = Variable<double>(weightPerCableKg);
    map['mode'] = Variable<String>(mode);
    if (!nullToAbsent || eccentricLoad != null) {
      map['eccentric_load'] = Variable<int>(eccentricLoad);
    }
    if (!nullToAbsent || echoLevel != null) {
      map['echo_level'] = Variable<int>(echoLevel);
    }
    return map;
  }

  RoutineExercisesCompanion toCompanion(bool nullToAbsent) {
    return RoutineExercisesCompanion(
      id: Value(id),
      routineId: Value(routineId),
      exerciseId: Value(exerciseId),
      order: Value(order),
      sets: Value(sets),
      reps: Value(reps),
      weightPerCableKg: Value(weightPerCableKg),
      mode: Value(mode),
      eccentricLoad: eccentricLoad == null && nullToAbsent
          ? const Value.absent()
          : Value(eccentricLoad),
      echoLevel: echoLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(echoLevel),
    );
  }

  factory RoutineExercise.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RoutineExercise(
      id: serializer.fromJson<int>(json['id']),
      routineId: serializer.fromJson<String>(json['routineId']),
      exerciseId: serializer.fromJson<String>(json['exerciseId']),
      order: serializer.fromJson<int>(json['order']),
      sets: serializer.fromJson<int>(json['sets']),
      reps: serializer.fromJson<int>(json['reps']),
      weightPerCableKg: serializer.fromJson<double>(json['weightPerCableKg']),
      mode: serializer.fromJson<String>(json['mode']),
      eccentricLoad: serializer.fromJson<int?>(json['eccentricLoad']),
      echoLevel: serializer.fromJson<int?>(json['echoLevel']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'routineId': serializer.toJson<String>(routineId),
      'exerciseId': serializer.toJson<String>(exerciseId),
      'order': serializer.toJson<int>(order),
      'sets': serializer.toJson<int>(sets),
      'reps': serializer.toJson<int>(reps),
      'weightPerCableKg': serializer.toJson<double>(weightPerCableKg),
      'mode': serializer.toJson<String>(mode),
      'eccentricLoad': serializer.toJson<int?>(eccentricLoad),
      'echoLevel': serializer.toJson<int?>(echoLevel),
    };
  }

  RoutineExercise copyWith({
    int? id,
    String? routineId,
    String? exerciseId,
    int? order,
    int? sets,
    int? reps,
    double? weightPerCableKg,
    String? mode,
    Value<int?> eccentricLoad = const Value.absent(),
    Value<int?> echoLevel = const Value.absent(),
  }) => RoutineExercise(
    id: id ?? this.id,
    routineId: routineId ?? this.routineId,
    exerciseId: exerciseId ?? this.exerciseId,
    order: order ?? this.order,
    sets: sets ?? this.sets,
    reps: reps ?? this.reps,
    weightPerCableKg: weightPerCableKg ?? this.weightPerCableKg,
    mode: mode ?? this.mode,
    eccentricLoad: eccentricLoad.present
        ? eccentricLoad.value
        : this.eccentricLoad,
    echoLevel: echoLevel.present ? echoLevel.value : this.echoLevel,
  );
  RoutineExercise copyWithCompanion(RoutineExercisesCompanion data) {
    return RoutineExercise(
      id: data.id.present ? data.id.value : this.id,
      routineId: data.routineId.present ? data.routineId.value : this.routineId,
      exerciseId: data.exerciseId.present
          ? data.exerciseId.value
          : this.exerciseId,
      order: data.order.present ? data.order.value : this.order,
      sets: data.sets.present ? data.sets.value : this.sets,
      reps: data.reps.present ? data.reps.value : this.reps,
      weightPerCableKg: data.weightPerCableKg.present
          ? data.weightPerCableKg.value
          : this.weightPerCableKg,
      mode: data.mode.present ? data.mode.value : this.mode,
      eccentricLoad: data.eccentricLoad.present
          ? data.eccentricLoad.value
          : this.eccentricLoad,
      echoLevel: data.echoLevel.present ? data.echoLevel.value : this.echoLevel,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RoutineExercise(')
          ..write('id: $id, ')
          ..write('routineId: $routineId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('order: $order, ')
          ..write('sets: $sets, ')
          ..write('reps: $reps, ')
          ..write('weightPerCableKg: $weightPerCableKg, ')
          ..write('mode: $mode, ')
          ..write('eccentricLoad: $eccentricLoad, ')
          ..write('echoLevel: $echoLevel')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    routineId,
    exerciseId,
    order,
    sets,
    reps,
    weightPerCableKg,
    mode,
    eccentricLoad,
    echoLevel,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RoutineExercise &&
          other.id == this.id &&
          other.routineId == this.routineId &&
          other.exerciseId == this.exerciseId &&
          other.order == this.order &&
          other.sets == this.sets &&
          other.reps == this.reps &&
          other.weightPerCableKg == this.weightPerCableKg &&
          other.mode == this.mode &&
          other.eccentricLoad == this.eccentricLoad &&
          other.echoLevel == this.echoLevel);
}

class RoutineExercisesCompanion extends UpdateCompanion<RoutineExercise> {
  final Value<int> id;
  final Value<String> routineId;
  final Value<String> exerciseId;
  final Value<int> order;
  final Value<int> sets;
  final Value<int> reps;
  final Value<double> weightPerCableKg;
  final Value<String> mode;
  final Value<int?> eccentricLoad;
  final Value<int?> echoLevel;
  const RoutineExercisesCompanion({
    this.id = const Value.absent(),
    this.routineId = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.order = const Value.absent(),
    this.sets = const Value.absent(),
    this.reps = const Value.absent(),
    this.weightPerCableKg = const Value.absent(),
    this.mode = const Value.absent(),
    this.eccentricLoad = const Value.absent(),
    this.echoLevel = const Value.absent(),
  });
  RoutineExercisesCompanion.insert({
    this.id = const Value.absent(),
    required String routineId,
    required String exerciseId,
    required int order,
    required int sets,
    required int reps,
    required double weightPerCableKg,
    required String mode,
    this.eccentricLoad = const Value.absent(),
    this.echoLevel = const Value.absent(),
  }) : routineId = Value(routineId),
       exerciseId = Value(exerciseId),
       order = Value(order),
       sets = Value(sets),
       reps = Value(reps),
       weightPerCableKg = Value(weightPerCableKg),
       mode = Value(mode);
  static Insertable<RoutineExercise> custom({
    Expression<int>? id,
    Expression<String>? routineId,
    Expression<String>? exerciseId,
    Expression<int>? order,
    Expression<int>? sets,
    Expression<int>? reps,
    Expression<double>? weightPerCableKg,
    Expression<String>? mode,
    Expression<int>? eccentricLoad,
    Expression<int>? echoLevel,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (routineId != null) 'routine_id': routineId,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (order != null) 'order': order,
      if (sets != null) 'sets': sets,
      if (reps != null) 'reps': reps,
      if (weightPerCableKg != null) 'weight_per_cable_kg': weightPerCableKg,
      if (mode != null) 'mode': mode,
      if (eccentricLoad != null) 'eccentric_load': eccentricLoad,
      if (echoLevel != null) 'echo_level': echoLevel,
    });
  }

  RoutineExercisesCompanion copyWith({
    Value<int>? id,
    Value<String>? routineId,
    Value<String>? exerciseId,
    Value<int>? order,
    Value<int>? sets,
    Value<int>? reps,
    Value<double>? weightPerCableKg,
    Value<String>? mode,
    Value<int?>? eccentricLoad,
    Value<int?>? echoLevel,
  }) {
    return RoutineExercisesCompanion(
      id: id ?? this.id,
      routineId: routineId ?? this.routineId,
      exerciseId: exerciseId ?? this.exerciseId,
      order: order ?? this.order,
      sets: sets ?? this.sets,
      reps: reps ?? this.reps,
      weightPerCableKg: weightPerCableKg ?? this.weightPerCableKg,
      mode: mode ?? this.mode,
      eccentricLoad: eccentricLoad ?? this.eccentricLoad,
      echoLevel: echoLevel ?? this.echoLevel,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (routineId.present) {
      map['routine_id'] = Variable<String>(routineId.value);
    }
    if (exerciseId.present) {
      map['exercise_id'] = Variable<String>(exerciseId.value);
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    if (sets.present) {
      map['sets'] = Variable<int>(sets.value);
    }
    if (reps.present) {
      map['reps'] = Variable<int>(reps.value);
    }
    if (weightPerCableKg.present) {
      map['weight_per_cable_kg'] = Variable<double>(weightPerCableKg.value);
    }
    if (mode.present) {
      map['mode'] = Variable<String>(mode.value);
    }
    if (eccentricLoad.present) {
      map['eccentric_load'] = Variable<int>(eccentricLoad.value);
    }
    if (echoLevel.present) {
      map['echo_level'] = Variable<int>(echoLevel.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoutineExercisesCompanion(')
          ..write('id: $id, ')
          ..write('routineId: $routineId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('order: $order, ')
          ..write('sets: $sets, ')
          ..write('reps: $reps, ')
          ..write('weightPerCableKg: $weightPerCableKg, ')
          ..write('mode: $mode, ')
          ..write('eccentricLoad: $eccentricLoad, ')
          ..write('echoLevel: $echoLevel')
          ..write(')'))
        .toString();
  }
}

class $ExercisesTable extends Exercises
    with TableInfo<$ExercisesTable, Exercise> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExercisesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _muscleGroupsMeta = const VerificationMeta(
    'muscleGroups',
  );
  @override
  late final GeneratedColumn<String> muscleGroups = GeneratedColumn<String>(
    'muscle_groups',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<BigInt> createdAt = GeneratedColumn<BigInt>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.bigInt,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastUsedMeta = const VerificationMeta(
    'lastUsed',
  );
  @override
  late final GeneratedColumn<BigInt> lastUsed = GeneratedColumn<BigInt>(
    'last_used',
    aliasedName,
    false,
    type: DriftSqlType.bigInt,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    category,
    muscleGroups,
    notes,
    createdAt,
    lastUsed,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercises';
  @override
  VerificationContext validateIntegrity(
    Insertable<Exercise> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('muscle_groups')) {
      context.handle(
        _muscleGroupsMeta,
        muscleGroups.isAcceptableOrUnknown(
          data['muscle_groups']!,
          _muscleGroupsMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('last_used')) {
      context.handle(
        _lastUsedMeta,
        lastUsed.isAcceptableOrUnknown(data['last_used']!, _lastUsedMeta),
      );
    } else if (isInserting) {
      context.missing(_lastUsedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Exercise map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Exercise(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      ),
      muscleGroups: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}muscle_groups'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.bigInt,
        data['${effectivePrefix}created_at'],
      )!,
      lastUsed: attachedDatabase.typeMapping.read(
        DriftSqlType.bigInt,
        data['${effectivePrefix}last_used'],
      )!,
    );
  }

  @override
  $ExercisesTable createAlias(String alias) {
    return $ExercisesTable(attachedDatabase, alias);
  }
}

class Exercise extends DataClass implements Insertable<Exercise> {
  final String id;
  final String name;
  final String? category;
  final String? muscleGroups;
  final String? notes;
  final BigInt createdAt;
  final BigInt lastUsed;
  const Exercise({
    required this.id,
    required this.name,
    this.category,
    this.muscleGroups,
    this.notes,
    required this.createdAt,
    required this.lastUsed,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    if (!nullToAbsent || muscleGroups != null) {
      map['muscle_groups'] = Variable<String>(muscleGroups);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<BigInt>(createdAt);
    map['last_used'] = Variable<BigInt>(lastUsed);
    return map;
  }

  ExercisesCompanion toCompanion(bool nullToAbsent) {
    return ExercisesCompanion(
      id: Value(id),
      name: Value(name),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      muscleGroups: muscleGroups == null && nullToAbsent
          ? const Value.absent()
          : Value(muscleGroups),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      lastUsed: Value(lastUsed),
    );
  }

  factory Exercise.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Exercise(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      category: serializer.fromJson<String?>(json['category']),
      muscleGroups: serializer.fromJson<String?>(json['muscleGroups']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<BigInt>(json['createdAt']),
      lastUsed: serializer.fromJson<BigInt>(json['lastUsed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'category': serializer.toJson<String?>(category),
      'muscleGroups': serializer.toJson<String?>(muscleGroups),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<BigInt>(createdAt),
      'lastUsed': serializer.toJson<BigInt>(lastUsed),
    };
  }

  Exercise copyWith({
    String? id,
    String? name,
    Value<String?> category = const Value.absent(),
    Value<String?> muscleGroups = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    BigInt? createdAt,
    BigInt? lastUsed,
  }) => Exercise(
    id: id ?? this.id,
    name: name ?? this.name,
    category: category.present ? category.value : this.category,
    muscleGroups: muscleGroups.present ? muscleGroups.value : this.muscleGroups,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    lastUsed: lastUsed ?? this.lastUsed,
  );
  Exercise copyWithCompanion(ExercisesCompanion data) {
    return Exercise(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      category: data.category.present ? data.category.value : this.category,
      muscleGroups: data.muscleGroups.present
          ? data.muscleGroups.value
          : this.muscleGroups,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      lastUsed: data.lastUsed.present ? data.lastUsed.value : this.lastUsed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Exercise(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('muscleGroups: $muscleGroups, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastUsed: $lastUsed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, category, muscleGroups, notes, createdAt, lastUsed);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Exercise &&
          other.id == this.id &&
          other.name == this.name &&
          other.category == this.category &&
          other.muscleGroups == this.muscleGroups &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.lastUsed == this.lastUsed);
}

class ExercisesCompanion extends UpdateCompanion<Exercise> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> category;
  final Value<String?> muscleGroups;
  final Value<String?> notes;
  final Value<BigInt> createdAt;
  final Value<BigInt> lastUsed;
  final Value<int> rowid;
  const ExercisesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.muscleGroups = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastUsed = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExercisesCompanion.insert({
    required String id,
    required String name,
    this.category = const Value.absent(),
    this.muscleGroups = const Value.absent(),
    this.notes = const Value.absent(),
    required BigInt createdAt,
    required BigInt lastUsed,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       createdAt = Value(createdAt),
       lastUsed = Value(lastUsed);
  static Insertable<Exercise> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? category,
    Expression<String>? muscleGroups,
    Expression<String>? notes,
    Expression<BigInt>? createdAt,
    Expression<BigInt>? lastUsed,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (muscleGroups != null) 'muscle_groups': muscleGroups,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (lastUsed != null) 'last_used': lastUsed,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExercisesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? category,
    Value<String?>? muscleGroups,
    Value<String?>? notes,
    Value<BigInt>? createdAt,
    Value<BigInt>? lastUsed,
    Value<int>? rowid,
  }) {
    return ExercisesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      muscleGroups: muscleGroups ?? this.muscleGroups,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      lastUsed: lastUsed ?? this.lastUsed,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (muscleGroups.present) {
      map['muscle_groups'] = Variable<String>(muscleGroups.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<BigInt>(createdAt.value);
    }
    if (lastUsed.present) {
      map['last_used'] = Variable<BigInt>(lastUsed.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExercisesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('muscleGroups: $muscleGroups, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastUsed: $lastUsed, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExerciseVideosTable extends ExerciseVideos
    with TableInfo<$ExerciseVideosTable, ExerciseVideo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExerciseVideosTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _exerciseIdMeta = const VerificationMeta(
    'exerciseId',
  );
  @override
  late final GeneratedColumn<String> exerciseId = GeneratedColumn<String>(
    'exercise_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES exercises (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _videoUrlMeta = const VerificationMeta(
    'videoUrl',
  );
  @override
  late final GeneratedColumn<String> videoUrl = GeneratedColumn<String>(
    'video_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _thumbnailUrlMeta = const VerificationMeta(
    'thumbnailUrl',
  );
  @override
  late final GeneratedColumn<String> thumbnailUrl = GeneratedColumn<String>(
    'thumbnail_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
    'order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    exerciseId,
    videoUrl,
    thumbnailUrl,
    order,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercise_videos';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExerciseVideo> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
        _exerciseIdMeta,
        exerciseId.isAcceptableOrUnknown(data['exercise_id']!, _exerciseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
    }
    if (data.containsKey('video_url')) {
      context.handle(
        _videoUrlMeta,
        videoUrl.isAcceptableOrUnknown(data['video_url']!, _videoUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_videoUrlMeta);
    }
    if (data.containsKey('thumbnail_url')) {
      context.handle(
        _thumbnailUrlMeta,
        thumbnailUrl.isAcceptableOrUnknown(
          data['thumbnail_url']!,
          _thumbnailUrlMeta,
        ),
      );
    }
    if (data.containsKey('order')) {
      context.handle(
        _orderMeta,
        order.isAcceptableOrUnknown(data['order']!, _orderMeta),
      );
    } else if (isInserting) {
      context.missing(_orderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExerciseVideo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExerciseVideo(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      exerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exercise_id'],
      )!,
      videoUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}video_url'],
      )!,
      thumbnailUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}thumbnail_url'],
      ),
      order: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order'],
      )!,
    );
  }

  @override
  $ExerciseVideosTable createAlias(String alias) {
    return $ExerciseVideosTable(attachedDatabase, alias);
  }
}

class ExerciseVideo extends DataClass implements Insertable<ExerciseVideo> {
  final int id;
  final String exerciseId;
  final String videoUrl;
  final String? thumbnailUrl;
  final int order;
  const ExerciseVideo({
    required this.id,
    required this.exerciseId,
    required this.videoUrl,
    this.thumbnailUrl,
    required this.order,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['exercise_id'] = Variable<String>(exerciseId);
    map['video_url'] = Variable<String>(videoUrl);
    if (!nullToAbsent || thumbnailUrl != null) {
      map['thumbnail_url'] = Variable<String>(thumbnailUrl);
    }
    map['order'] = Variable<int>(order);
    return map;
  }

  ExerciseVideosCompanion toCompanion(bool nullToAbsent) {
    return ExerciseVideosCompanion(
      id: Value(id),
      exerciseId: Value(exerciseId),
      videoUrl: Value(videoUrl),
      thumbnailUrl: thumbnailUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(thumbnailUrl),
      order: Value(order),
    );
  }

  factory ExerciseVideo.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExerciseVideo(
      id: serializer.fromJson<int>(json['id']),
      exerciseId: serializer.fromJson<String>(json['exerciseId']),
      videoUrl: serializer.fromJson<String>(json['videoUrl']),
      thumbnailUrl: serializer.fromJson<String?>(json['thumbnailUrl']),
      order: serializer.fromJson<int>(json['order']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'exerciseId': serializer.toJson<String>(exerciseId),
      'videoUrl': serializer.toJson<String>(videoUrl),
      'thumbnailUrl': serializer.toJson<String?>(thumbnailUrl),
      'order': serializer.toJson<int>(order),
    };
  }

  ExerciseVideo copyWith({
    int? id,
    String? exerciseId,
    String? videoUrl,
    Value<String?> thumbnailUrl = const Value.absent(),
    int? order,
  }) => ExerciseVideo(
    id: id ?? this.id,
    exerciseId: exerciseId ?? this.exerciseId,
    videoUrl: videoUrl ?? this.videoUrl,
    thumbnailUrl: thumbnailUrl.present ? thumbnailUrl.value : this.thumbnailUrl,
    order: order ?? this.order,
  );
  ExerciseVideo copyWithCompanion(ExerciseVideosCompanion data) {
    return ExerciseVideo(
      id: data.id.present ? data.id.value : this.id,
      exerciseId: data.exerciseId.present
          ? data.exerciseId.value
          : this.exerciseId,
      videoUrl: data.videoUrl.present ? data.videoUrl.value : this.videoUrl,
      thumbnailUrl: data.thumbnailUrl.present
          ? data.thumbnailUrl.value
          : this.thumbnailUrl,
      order: data.order.present ? data.order.value : this.order,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseVideo(')
          ..write('id: $id, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('videoUrl: $videoUrl, ')
          ..write('thumbnailUrl: $thumbnailUrl, ')
          ..write('order: $order')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, exerciseId, videoUrl, thumbnailUrl, order);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExerciseVideo &&
          other.id == this.id &&
          other.exerciseId == this.exerciseId &&
          other.videoUrl == this.videoUrl &&
          other.thumbnailUrl == this.thumbnailUrl &&
          other.order == this.order);
}

class ExerciseVideosCompanion extends UpdateCompanion<ExerciseVideo> {
  final Value<int> id;
  final Value<String> exerciseId;
  final Value<String> videoUrl;
  final Value<String?> thumbnailUrl;
  final Value<int> order;
  const ExerciseVideosCompanion({
    this.id = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.videoUrl = const Value.absent(),
    this.thumbnailUrl = const Value.absent(),
    this.order = const Value.absent(),
  });
  ExerciseVideosCompanion.insert({
    this.id = const Value.absent(),
    required String exerciseId,
    required String videoUrl,
    this.thumbnailUrl = const Value.absent(),
    required int order,
  }) : exerciseId = Value(exerciseId),
       videoUrl = Value(videoUrl),
       order = Value(order);
  static Insertable<ExerciseVideo> custom({
    Expression<int>? id,
    Expression<String>? exerciseId,
    Expression<String>? videoUrl,
    Expression<String>? thumbnailUrl,
    Expression<int>? order,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (videoUrl != null) 'video_url': videoUrl,
      if (thumbnailUrl != null) 'thumbnail_url': thumbnailUrl,
      if (order != null) 'order': order,
    });
  }

  ExerciseVideosCompanion copyWith({
    Value<int>? id,
    Value<String>? exerciseId,
    Value<String>? videoUrl,
    Value<String?>? thumbnailUrl,
    Value<int>? order,
  }) {
    return ExerciseVideosCompanion(
      id: id ?? this.id,
      exerciseId: exerciseId ?? this.exerciseId,
      videoUrl: videoUrl ?? this.videoUrl,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      order: order ?? this.order,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (exerciseId.present) {
      map['exercise_id'] = Variable<String>(exerciseId.value);
    }
    if (videoUrl.present) {
      map['video_url'] = Variable<String>(videoUrl.value);
    }
    if (thumbnailUrl.present) {
      map['thumbnail_url'] = Variable<String>(thumbnailUrl.value);
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseVideosCompanion(')
          ..write('id: $id, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('videoUrl: $videoUrl, ')
          ..write('thumbnailUrl: $thumbnailUrl, ')
          ..write('order: $order')
          ..write(')'))
        .toString();
  }
}

class $PersonalRecordsTable extends PersonalRecords
    with TableInfo<$PersonalRecordsTable, PersonalRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PersonalRecordsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _exerciseIdMeta = const VerificationMeta(
    'exerciseId',
  );
  @override
  late final GeneratedColumn<String> exerciseId = GeneratedColumn<String>(
    'exercise_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weightPerCableKgMeta = const VerificationMeta(
    'weightPerCableKg',
  );
  @override
  late final GeneratedColumn<double> weightPerCableKg = GeneratedColumn<double>(
    'weight_per_cable_kg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _repsMeta = const VerificationMeta('reps');
  @override
  late final GeneratedColumn<int> reps = GeneratedColumn<int>(
    'reps',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<BigInt> timestamp = GeneratedColumn<BigInt>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.bigInt,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _workoutModeMeta = const VerificationMeta(
    'workoutMode',
  );
  @override
  late final GeneratedColumn<String> workoutMode = GeneratedColumn<String>(
    'workout_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    exerciseId,
    weightPerCableKg,
    reps,
    timestamp,
    workoutMode,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'personal_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<PersonalRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
        _exerciseIdMeta,
        exerciseId.isAcceptableOrUnknown(data['exercise_id']!, _exerciseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
    }
    if (data.containsKey('weight_per_cable_kg')) {
      context.handle(
        _weightPerCableKgMeta,
        weightPerCableKg.isAcceptableOrUnknown(
          data['weight_per_cable_kg']!,
          _weightPerCableKgMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_weightPerCableKgMeta);
    }
    if (data.containsKey('reps')) {
      context.handle(
        _repsMeta,
        reps.isAcceptableOrUnknown(data['reps']!, _repsMeta),
      );
    } else if (isInserting) {
      context.missing(_repsMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('workout_mode')) {
      context.handle(
        _workoutModeMeta,
        workoutMode.isAcceptableOrUnknown(
          data['workout_mode']!,
          _workoutModeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_workoutModeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {exerciseId, workoutMode},
  ];
  @override
  PersonalRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PersonalRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      exerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exercise_id'],
      )!,
      weightPerCableKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight_per_cable_kg'],
      )!,
      reps: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reps'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.bigInt,
        data['${effectivePrefix}timestamp'],
      )!,
      workoutMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}workout_mode'],
      )!,
    );
  }

  @override
  $PersonalRecordsTable createAlias(String alias) {
    return $PersonalRecordsTable(attachedDatabase, alias);
  }
}

class PersonalRecord extends DataClass implements Insertable<PersonalRecord> {
  final int id;
  final String exerciseId;
  final double weightPerCableKg;
  final int reps;
  final BigInt timestamp;
  final String workoutMode;
  const PersonalRecord({
    required this.id,
    required this.exerciseId,
    required this.weightPerCableKg,
    required this.reps,
    required this.timestamp,
    required this.workoutMode,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['exercise_id'] = Variable<String>(exerciseId);
    map['weight_per_cable_kg'] = Variable<double>(weightPerCableKg);
    map['reps'] = Variable<int>(reps);
    map['timestamp'] = Variable<BigInt>(timestamp);
    map['workout_mode'] = Variable<String>(workoutMode);
    return map;
  }

  PersonalRecordsCompanion toCompanion(bool nullToAbsent) {
    return PersonalRecordsCompanion(
      id: Value(id),
      exerciseId: Value(exerciseId),
      weightPerCableKg: Value(weightPerCableKg),
      reps: Value(reps),
      timestamp: Value(timestamp),
      workoutMode: Value(workoutMode),
    );
  }

  factory PersonalRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PersonalRecord(
      id: serializer.fromJson<int>(json['id']),
      exerciseId: serializer.fromJson<String>(json['exerciseId']),
      weightPerCableKg: serializer.fromJson<double>(json['weightPerCableKg']),
      reps: serializer.fromJson<int>(json['reps']),
      timestamp: serializer.fromJson<BigInt>(json['timestamp']),
      workoutMode: serializer.fromJson<String>(json['workoutMode']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'exerciseId': serializer.toJson<String>(exerciseId),
      'weightPerCableKg': serializer.toJson<double>(weightPerCableKg),
      'reps': serializer.toJson<int>(reps),
      'timestamp': serializer.toJson<BigInt>(timestamp),
      'workoutMode': serializer.toJson<String>(workoutMode),
    };
  }

  PersonalRecord copyWith({
    int? id,
    String? exerciseId,
    double? weightPerCableKg,
    int? reps,
    BigInt? timestamp,
    String? workoutMode,
  }) => PersonalRecord(
    id: id ?? this.id,
    exerciseId: exerciseId ?? this.exerciseId,
    weightPerCableKg: weightPerCableKg ?? this.weightPerCableKg,
    reps: reps ?? this.reps,
    timestamp: timestamp ?? this.timestamp,
    workoutMode: workoutMode ?? this.workoutMode,
  );
  PersonalRecord copyWithCompanion(PersonalRecordsCompanion data) {
    return PersonalRecord(
      id: data.id.present ? data.id.value : this.id,
      exerciseId: data.exerciseId.present
          ? data.exerciseId.value
          : this.exerciseId,
      weightPerCableKg: data.weightPerCableKg.present
          ? data.weightPerCableKg.value
          : this.weightPerCableKg,
      reps: data.reps.present ? data.reps.value : this.reps,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      workoutMode: data.workoutMode.present
          ? data.workoutMode.value
          : this.workoutMode,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PersonalRecord(')
          ..write('id: $id, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('weightPerCableKg: $weightPerCableKg, ')
          ..write('reps: $reps, ')
          ..write('timestamp: $timestamp, ')
          ..write('workoutMode: $workoutMode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    exerciseId,
    weightPerCableKg,
    reps,
    timestamp,
    workoutMode,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PersonalRecord &&
          other.id == this.id &&
          other.exerciseId == this.exerciseId &&
          other.weightPerCableKg == this.weightPerCableKg &&
          other.reps == this.reps &&
          other.timestamp == this.timestamp &&
          other.workoutMode == this.workoutMode);
}

class PersonalRecordsCompanion extends UpdateCompanion<PersonalRecord> {
  final Value<int> id;
  final Value<String> exerciseId;
  final Value<double> weightPerCableKg;
  final Value<int> reps;
  final Value<BigInt> timestamp;
  final Value<String> workoutMode;
  const PersonalRecordsCompanion({
    this.id = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.weightPerCableKg = const Value.absent(),
    this.reps = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.workoutMode = const Value.absent(),
  });
  PersonalRecordsCompanion.insert({
    this.id = const Value.absent(),
    required String exerciseId,
    required double weightPerCableKg,
    required int reps,
    required BigInt timestamp,
    required String workoutMode,
  }) : exerciseId = Value(exerciseId),
       weightPerCableKg = Value(weightPerCableKg),
       reps = Value(reps),
       timestamp = Value(timestamp),
       workoutMode = Value(workoutMode);
  static Insertable<PersonalRecord> custom({
    Expression<int>? id,
    Expression<String>? exerciseId,
    Expression<double>? weightPerCableKg,
    Expression<int>? reps,
    Expression<BigInt>? timestamp,
    Expression<String>? workoutMode,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (weightPerCableKg != null) 'weight_per_cable_kg': weightPerCableKg,
      if (reps != null) 'reps': reps,
      if (timestamp != null) 'timestamp': timestamp,
      if (workoutMode != null) 'workout_mode': workoutMode,
    });
  }

  PersonalRecordsCompanion copyWith({
    Value<int>? id,
    Value<String>? exerciseId,
    Value<double>? weightPerCableKg,
    Value<int>? reps,
    Value<BigInt>? timestamp,
    Value<String>? workoutMode,
  }) {
    return PersonalRecordsCompanion(
      id: id ?? this.id,
      exerciseId: exerciseId ?? this.exerciseId,
      weightPerCableKg: weightPerCableKg ?? this.weightPerCableKg,
      reps: reps ?? this.reps,
      timestamp: timestamp ?? this.timestamp,
      workoutMode: workoutMode ?? this.workoutMode,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (exerciseId.present) {
      map['exercise_id'] = Variable<String>(exerciseId.value);
    }
    if (weightPerCableKg.present) {
      map['weight_per_cable_kg'] = Variable<double>(weightPerCableKg.value);
    }
    if (reps.present) {
      map['reps'] = Variable<int>(reps.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<BigInt>(timestamp.value);
    }
    if (workoutMode.present) {
      map['workout_mode'] = Variable<String>(workoutMode.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PersonalRecordsCompanion(')
          ..write('id: $id, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('weightPerCableKg: $weightPerCableKg, ')
          ..write('reps: $reps, ')
          ..write('timestamp: $timestamp, ')
          ..write('workoutMode: $workoutMode')
          ..write(')'))
        .toString();
  }
}

class $WeeklyProgramsTable extends WeeklyPrograms
    with TableInfo<$WeeklyProgramsTable, WeeklyProgram> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WeeklyProgramsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<BigInt> createdAt = GeneratedColumn<BigInt>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.bigInt,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastUsedMeta = const VerificationMeta(
    'lastUsed',
  );
  @override
  late final GeneratedColumn<BigInt> lastUsed = GeneratedColumn<BigInt>(
    'last_used',
    aliasedName,
    false,
    type: DriftSqlType.bigInt,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    createdAt,
    lastUsed,
    isActive,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'weekly_programs';
  @override
  VerificationContext validateIntegrity(
    Insertable<WeeklyProgram> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('last_used')) {
      context.handle(
        _lastUsedMeta,
        lastUsed.isAcceptableOrUnknown(data['last_used']!, _lastUsedMeta),
      );
    } else if (isInserting) {
      context.missing(_lastUsedMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WeeklyProgram map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WeeklyProgram(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.bigInt,
        data['${effectivePrefix}created_at'],
      )!,
      lastUsed: attachedDatabase.typeMapping.read(
        DriftSqlType.bigInt,
        data['${effectivePrefix}last_used'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
    );
  }

  @override
  $WeeklyProgramsTable createAlias(String alias) {
    return $WeeklyProgramsTable(attachedDatabase, alias);
  }
}

class WeeklyProgram extends DataClass implements Insertable<WeeklyProgram> {
  final String id;
  final String name;
  final BigInt createdAt;
  final BigInt lastUsed;
  final bool isActive;
  const WeeklyProgram({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.lastUsed,
    required this.isActive,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['created_at'] = Variable<BigInt>(createdAt);
    map['last_used'] = Variable<BigInt>(lastUsed);
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  WeeklyProgramsCompanion toCompanion(bool nullToAbsent) {
    return WeeklyProgramsCompanion(
      id: Value(id),
      name: Value(name),
      createdAt: Value(createdAt),
      lastUsed: Value(lastUsed),
      isActive: Value(isActive),
    );
  }

  factory WeeklyProgram.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WeeklyProgram(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      createdAt: serializer.fromJson<BigInt>(json['createdAt']),
      lastUsed: serializer.fromJson<BigInt>(json['lastUsed']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'createdAt': serializer.toJson<BigInt>(createdAt),
      'lastUsed': serializer.toJson<BigInt>(lastUsed),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  WeeklyProgram copyWith({
    String? id,
    String? name,
    BigInt? createdAt,
    BigInt? lastUsed,
    bool? isActive,
  }) => WeeklyProgram(
    id: id ?? this.id,
    name: name ?? this.name,
    createdAt: createdAt ?? this.createdAt,
    lastUsed: lastUsed ?? this.lastUsed,
    isActive: isActive ?? this.isActive,
  );
  WeeklyProgram copyWithCompanion(WeeklyProgramsCompanion data) {
    return WeeklyProgram(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      lastUsed: data.lastUsed.present ? data.lastUsed.value : this.lastUsed,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WeeklyProgram(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastUsed: $lastUsed, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, createdAt, lastUsed, isActive);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WeeklyProgram &&
          other.id == this.id &&
          other.name == this.name &&
          other.createdAt == this.createdAt &&
          other.lastUsed == this.lastUsed &&
          other.isActive == this.isActive);
}

class WeeklyProgramsCompanion extends UpdateCompanion<WeeklyProgram> {
  final Value<String> id;
  final Value<String> name;
  final Value<BigInt> createdAt;
  final Value<BigInt> lastUsed;
  final Value<bool> isActive;
  final Value<int> rowid;
  const WeeklyProgramsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastUsed = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WeeklyProgramsCompanion.insert({
    required String id,
    required String name,
    required BigInt createdAt,
    required BigInt lastUsed,
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       createdAt = Value(createdAt),
       lastUsed = Value(lastUsed);
  static Insertable<WeeklyProgram> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<BigInt>? createdAt,
    Expression<BigInt>? lastUsed,
    Expression<bool>? isActive,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (createdAt != null) 'created_at': createdAt,
      if (lastUsed != null) 'last_used': lastUsed,
      if (isActive != null) 'is_active': isActive,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WeeklyProgramsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<BigInt>? createdAt,
    Value<BigInt>? lastUsed,
    Value<bool>? isActive,
    Value<int>? rowid,
  }) {
    return WeeklyProgramsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      lastUsed: lastUsed ?? this.lastUsed,
      isActive: isActive ?? this.isActive,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<BigInt>(createdAt.value);
    }
    if (lastUsed.present) {
      map['last_used'] = Variable<BigInt>(lastUsed.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeeklyProgramsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastUsed: $lastUsed, ')
          ..write('isActive: $isActive, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProgramDaysTable extends ProgramDays
    with TableInfo<$ProgramDaysTable, ProgramDay> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProgramDaysTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _programIdMeta = const VerificationMeta(
    'programId',
  );
  @override
  late final GeneratedColumn<String> programId = GeneratedColumn<String>(
    'program_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES weekly_programs (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _routineIdMeta = const VerificationMeta(
    'routineId',
  );
  @override
  late final GeneratedColumn<String> routineId = GeneratedColumn<String>(
    'routine_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES routines (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _dayOfWeekMeta = const VerificationMeta(
    'dayOfWeek',
  );
  @override
  late final GeneratedColumn<int> dayOfWeek = GeneratedColumn<int>(
    'day_of_week',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, programId, routineId, dayOfWeek];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'program_days';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProgramDay> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('program_id')) {
      context.handle(
        _programIdMeta,
        programId.isAcceptableOrUnknown(data['program_id']!, _programIdMeta),
      );
    } else if (isInserting) {
      context.missing(_programIdMeta);
    }
    if (data.containsKey('routine_id')) {
      context.handle(
        _routineIdMeta,
        routineId.isAcceptableOrUnknown(data['routine_id']!, _routineIdMeta),
      );
    } else if (isInserting) {
      context.missing(_routineIdMeta);
    }
    if (data.containsKey('day_of_week')) {
      context.handle(
        _dayOfWeekMeta,
        dayOfWeek.isAcceptableOrUnknown(data['day_of_week']!, _dayOfWeekMeta),
      );
    } else if (isInserting) {
      context.missing(_dayOfWeekMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProgramDay map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProgramDay(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      programId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}program_id'],
      )!,
      routineId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}routine_id'],
      )!,
      dayOfWeek: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}day_of_week'],
      )!,
    );
  }

  @override
  $ProgramDaysTable createAlias(String alias) {
    return $ProgramDaysTable(attachedDatabase, alias);
  }
}

class ProgramDay extends DataClass implements Insertable<ProgramDay> {
  final int id;
  final String programId;
  final String routineId;
  final int dayOfWeek;
  const ProgramDay({
    required this.id,
    required this.programId,
    required this.routineId,
    required this.dayOfWeek,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['program_id'] = Variable<String>(programId);
    map['routine_id'] = Variable<String>(routineId);
    map['day_of_week'] = Variable<int>(dayOfWeek);
    return map;
  }

  ProgramDaysCompanion toCompanion(bool nullToAbsent) {
    return ProgramDaysCompanion(
      id: Value(id),
      programId: Value(programId),
      routineId: Value(routineId),
      dayOfWeek: Value(dayOfWeek),
    );
  }

  factory ProgramDay.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProgramDay(
      id: serializer.fromJson<int>(json['id']),
      programId: serializer.fromJson<String>(json['programId']),
      routineId: serializer.fromJson<String>(json['routineId']),
      dayOfWeek: serializer.fromJson<int>(json['dayOfWeek']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'programId': serializer.toJson<String>(programId),
      'routineId': serializer.toJson<String>(routineId),
      'dayOfWeek': serializer.toJson<int>(dayOfWeek),
    };
  }

  ProgramDay copyWith({
    int? id,
    String? programId,
    String? routineId,
    int? dayOfWeek,
  }) => ProgramDay(
    id: id ?? this.id,
    programId: programId ?? this.programId,
    routineId: routineId ?? this.routineId,
    dayOfWeek: dayOfWeek ?? this.dayOfWeek,
  );
  ProgramDay copyWithCompanion(ProgramDaysCompanion data) {
    return ProgramDay(
      id: data.id.present ? data.id.value : this.id,
      programId: data.programId.present ? data.programId.value : this.programId,
      routineId: data.routineId.present ? data.routineId.value : this.routineId,
      dayOfWeek: data.dayOfWeek.present ? data.dayOfWeek.value : this.dayOfWeek,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProgramDay(')
          ..write('id: $id, ')
          ..write('programId: $programId, ')
          ..write('routineId: $routineId, ')
          ..write('dayOfWeek: $dayOfWeek')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, programId, routineId, dayOfWeek);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProgramDay &&
          other.id == this.id &&
          other.programId == this.programId &&
          other.routineId == this.routineId &&
          other.dayOfWeek == this.dayOfWeek);
}

class ProgramDaysCompanion extends UpdateCompanion<ProgramDay> {
  final Value<int> id;
  final Value<String> programId;
  final Value<String> routineId;
  final Value<int> dayOfWeek;
  const ProgramDaysCompanion({
    this.id = const Value.absent(),
    this.programId = const Value.absent(),
    this.routineId = const Value.absent(),
    this.dayOfWeek = const Value.absent(),
  });
  ProgramDaysCompanion.insert({
    this.id = const Value.absent(),
    required String programId,
    required String routineId,
    required int dayOfWeek,
  }) : programId = Value(programId),
       routineId = Value(routineId),
       dayOfWeek = Value(dayOfWeek);
  static Insertable<ProgramDay> custom({
    Expression<int>? id,
    Expression<String>? programId,
    Expression<String>? routineId,
    Expression<int>? dayOfWeek,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (programId != null) 'program_id': programId,
      if (routineId != null) 'routine_id': routineId,
      if (dayOfWeek != null) 'day_of_week': dayOfWeek,
    });
  }

  ProgramDaysCompanion copyWith({
    Value<int>? id,
    Value<String>? programId,
    Value<String>? routineId,
    Value<int>? dayOfWeek,
  }) {
    return ProgramDaysCompanion(
      id: id ?? this.id,
      programId: programId ?? this.programId,
      routineId: routineId ?? this.routineId,
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (programId.present) {
      map['program_id'] = Variable<String>(programId.value);
    }
    if (routineId.present) {
      map['routine_id'] = Variable<String>(routineId.value);
    }
    if (dayOfWeek.present) {
      map['day_of_week'] = Variable<int>(dayOfWeek.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProgramDaysCompanion(')
          ..write('id: $id, ')
          ..write('programId: $programId, ')
          ..write('routineId: $routineId, ')
          ..write('dayOfWeek: $dayOfWeek')
          ..write(')'))
        .toString();
  }
}

class $ConnectionLogsTable extends ConnectionLogs
    with TableInfo<$ConnectionLogsTable, ConnectionLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ConnectionLogsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<BigInt> timestamp = GeneratedColumn<BigInt>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.bigInt,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _eventTypeMeta = const VerificationMeta(
    'eventType',
  );
  @override
  late final GeneratedColumn<String> eventType = GeneratedColumn<String>(
    'event_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<String> level = GeneratedColumn<String>(
    'level',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _messageMeta = const VerificationMeta(
    'message',
  );
  @override
  late final GeneratedColumn<String> message = GeneratedColumn<String>(
    'message',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceAddressMeta = const VerificationMeta(
    'deviceAddress',
  );
  @override
  late final GeneratedColumn<String> deviceAddress = GeneratedColumn<String>(
    'device_address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deviceNameMeta = const VerificationMeta(
    'deviceName',
  );
  @override
  late final GeneratedColumn<String> deviceName = GeneratedColumn<String>(
    'device_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _detailsMeta = const VerificationMeta(
    'details',
  );
  @override
  late final GeneratedColumn<String> details = GeneratedColumn<String>(
    'details',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _metadataMeta = const VerificationMeta(
    'metadata',
  );
  @override
  late final GeneratedColumn<String> metadata = GeneratedColumn<String>(
    'metadata',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    timestamp,
    eventType,
    level,
    message,
    deviceAddress,
    deviceName,
    details,
    metadata,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'connection_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<ConnectionLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('event_type')) {
      context.handle(
        _eventTypeMeta,
        eventType.isAcceptableOrUnknown(data['event_type']!, _eventTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_eventTypeMeta);
    }
    if (data.containsKey('level')) {
      context.handle(
        _levelMeta,
        level.isAcceptableOrUnknown(data['level']!, _levelMeta),
      );
    } else if (isInserting) {
      context.missing(_levelMeta);
    }
    if (data.containsKey('message')) {
      context.handle(
        _messageMeta,
        message.isAcceptableOrUnknown(data['message']!, _messageMeta),
      );
    } else if (isInserting) {
      context.missing(_messageMeta);
    }
    if (data.containsKey('device_address')) {
      context.handle(
        _deviceAddressMeta,
        deviceAddress.isAcceptableOrUnknown(
          data['device_address']!,
          _deviceAddressMeta,
        ),
      );
    }
    if (data.containsKey('device_name')) {
      context.handle(
        _deviceNameMeta,
        deviceName.isAcceptableOrUnknown(data['device_name']!, _deviceNameMeta),
      );
    }
    if (data.containsKey('details')) {
      context.handle(
        _detailsMeta,
        details.isAcceptableOrUnknown(data['details']!, _detailsMeta),
      );
    }
    if (data.containsKey('metadata')) {
      context.handle(
        _metadataMeta,
        metadata.isAcceptableOrUnknown(data['metadata']!, _metadataMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ConnectionLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ConnectionLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.bigInt,
        data['${effectivePrefix}timestamp'],
      )!,
      eventType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_type'],
      )!,
      level: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}level'],
      )!,
      message: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message'],
      )!,
      deviceAddress: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_address'],
      ),
      deviceName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_name'],
      ),
      details: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}details'],
      ),
      metadata: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metadata'],
      ),
    );
  }

  @override
  $ConnectionLogsTable createAlias(String alias) {
    return $ConnectionLogsTable(attachedDatabase, alias);
  }
}

class ConnectionLog extends DataClass implements Insertable<ConnectionLog> {
  final int id;
  final BigInt timestamp;
  final String eventType;
  final String level;
  final String message;
  final String? deviceAddress;
  final String? deviceName;
  final String? details;
  final String? metadata;
  const ConnectionLog({
    required this.id,
    required this.timestamp,
    required this.eventType,
    required this.level,
    required this.message,
    this.deviceAddress,
    this.deviceName,
    this.details,
    this.metadata,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['timestamp'] = Variable<BigInt>(timestamp);
    map['event_type'] = Variable<String>(eventType);
    map['level'] = Variable<String>(level);
    map['message'] = Variable<String>(message);
    if (!nullToAbsent || deviceAddress != null) {
      map['device_address'] = Variable<String>(deviceAddress);
    }
    if (!nullToAbsent || deviceName != null) {
      map['device_name'] = Variable<String>(deviceName);
    }
    if (!nullToAbsent || details != null) {
      map['details'] = Variable<String>(details);
    }
    if (!nullToAbsent || metadata != null) {
      map['metadata'] = Variable<String>(metadata);
    }
    return map;
  }

  ConnectionLogsCompanion toCompanion(bool nullToAbsent) {
    return ConnectionLogsCompanion(
      id: Value(id),
      timestamp: Value(timestamp),
      eventType: Value(eventType),
      level: Value(level),
      message: Value(message),
      deviceAddress: deviceAddress == null && nullToAbsent
          ? const Value.absent()
          : Value(deviceAddress),
      deviceName: deviceName == null && nullToAbsent
          ? const Value.absent()
          : Value(deviceName),
      details: details == null && nullToAbsent
          ? const Value.absent()
          : Value(details),
      metadata: metadata == null && nullToAbsent
          ? const Value.absent()
          : Value(metadata),
    );
  }

  factory ConnectionLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ConnectionLog(
      id: serializer.fromJson<int>(json['id']),
      timestamp: serializer.fromJson<BigInt>(json['timestamp']),
      eventType: serializer.fromJson<String>(json['eventType']),
      level: serializer.fromJson<String>(json['level']),
      message: serializer.fromJson<String>(json['message']),
      deviceAddress: serializer.fromJson<String?>(json['deviceAddress']),
      deviceName: serializer.fromJson<String?>(json['deviceName']),
      details: serializer.fromJson<String?>(json['details']),
      metadata: serializer.fromJson<String?>(json['metadata']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'timestamp': serializer.toJson<BigInt>(timestamp),
      'eventType': serializer.toJson<String>(eventType),
      'level': serializer.toJson<String>(level),
      'message': serializer.toJson<String>(message),
      'deviceAddress': serializer.toJson<String?>(deviceAddress),
      'deviceName': serializer.toJson<String?>(deviceName),
      'details': serializer.toJson<String?>(details),
      'metadata': serializer.toJson<String?>(metadata),
    };
  }

  ConnectionLog copyWith({
    int? id,
    BigInt? timestamp,
    String? eventType,
    String? level,
    String? message,
    Value<String?> deviceAddress = const Value.absent(),
    Value<String?> deviceName = const Value.absent(),
    Value<String?> details = const Value.absent(),
    Value<String?> metadata = const Value.absent(),
  }) => ConnectionLog(
    id: id ?? this.id,
    timestamp: timestamp ?? this.timestamp,
    eventType: eventType ?? this.eventType,
    level: level ?? this.level,
    message: message ?? this.message,
    deviceAddress: deviceAddress.present
        ? deviceAddress.value
        : this.deviceAddress,
    deviceName: deviceName.present ? deviceName.value : this.deviceName,
    details: details.present ? details.value : this.details,
    metadata: metadata.present ? metadata.value : this.metadata,
  );
  ConnectionLog copyWithCompanion(ConnectionLogsCompanion data) {
    return ConnectionLog(
      id: data.id.present ? data.id.value : this.id,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      eventType: data.eventType.present ? data.eventType.value : this.eventType,
      level: data.level.present ? data.level.value : this.level,
      message: data.message.present ? data.message.value : this.message,
      deviceAddress: data.deviceAddress.present
          ? data.deviceAddress.value
          : this.deviceAddress,
      deviceName: data.deviceName.present
          ? data.deviceName.value
          : this.deviceName,
      details: data.details.present ? data.details.value : this.details,
      metadata: data.metadata.present ? data.metadata.value : this.metadata,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ConnectionLog(')
          ..write('id: $id, ')
          ..write('timestamp: $timestamp, ')
          ..write('eventType: $eventType, ')
          ..write('level: $level, ')
          ..write('message: $message, ')
          ..write('deviceAddress: $deviceAddress, ')
          ..write('deviceName: $deviceName, ')
          ..write('details: $details, ')
          ..write('metadata: $metadata')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    timestamp,
    eventType,
    level,
    message,
    deviceAddress,
    deviceName,
    details,
    metadata,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ConnectionLog &&
          other.id == this.id &&
          other.timestamp == this.timestamp &&
          other.eventType == this.eventType &&
          other.level == this.level &&
          other.message == this.message &&
          other.deviceAddress == this.deviceAddress &&
          other.deviceName == this.deviceName &&
          other.details == this.details &&
          other.metadata == this.metadata);
}

class ConnectionLogsCompanion extends UpdateCompanion<ConnectionLog> {
  final Value<int> id;
  final Value<BigInt> timestamp;
  final Value<String> eventType;
  final Value<String> level;
  final Value<String> message;
  final Value<String?> deviceAddress;
  final Value<String?> deviceName;
  final Value<String?> details;
  final Value<String?> metadata;
  const ConnectionLogsCompanion({
    this.id = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.eventType = const Value.absent(),
    this.level = const Value.absent(),
    this.message = const Value.absent(),
    this.deviceAddress = const Value.absent(),
    this.deviceName = const Value.absent(),
    this.details = const Value.absent(),
    this.metadata = const Value.absent(),
  });
  ConnectionLogsCompanion.insert({
    this.id = const Value.absent(),
    required BigInt timestamp,
    required String eventType,
    required String level,
    required String message,
    this.deviceAddress = const Value.absent(),
    this.deviceName = const Value.absent(),
    this.details = const Value.absent(),
    this.metadata = const Value.absent(),
  }) : timestamp = Value(timestamp),
       eventType = Value(eventType),
       level = Value(level),
       message = Value(message);
  static Insertable<ConnectionLog> custom({
    Expression<int>? id,
    Expression<BigInt>? timestamp,
    Expression<String>? eventType,
    Expression<String>? level,
    Expression<String>? message,
    Expression<String>? deviceAddress,
    Expression<String>? deviceName,
    Expression<String>? details,
    Expression<String>? metadata,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (timestamp != null) 'timestamp': timestamp,
      if (eventType != null) 'event_type': eventType,
      if (level != null) 'level': level,
      if (message != null) 'message': message,
      if (deviceAddress != null) 'device_address': deviceAddress,
      if (deviceName != null) 'device_name': deviceName,
      if (details != null) 'details': details,
      if (metadata != null) 'metadata': metadata,
    });
  }

  ConnectionLogsCompanion copyWith({
    Value<int>? id,
    Value<BigInt>? timestamp,
    Value<String>? eventType,
    Value<String>? level,
    Value<String>? message,
    Value<String?>? deviceAddress,
    Value<String?>? deviceName,
    Value<String?>? details,
    Value<String?>? metadata,
  }) {
    return ConnectionLogsCompanion(
      id: id ?? this.id,
      timestamp: timestamp ?? this.timestamp,
      eventType: eventType ?? this.eventType,
      level: level ?? this.level,
      message: message ?? this.message,
      deviceAddress: deviceAddress ?? this.deviceAddress,
      deviceName: deviceName ?? this.deviceName,
      details: details ?? this.details,
      metadata: metadata ?? this.metadata,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<BigInt>(timestamp.value);
    }
    if (eventType.present) {
      map['event_type'] = Variable<String>(eventType.value);
    }
    if (level.present) {
      map['level'] = Variable<String>(level.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (deviceAddress.present) {
      map['device_address'] = Variable<String>(deviceAddress.value);
    }
    if (deviceName.present) {
      map['device_name'] = Variable<String>(deviceName.value);
    }
    if (details.present) {
      map['details'] = Variable<String>(details.value);
    }
    if (metadata.present) {
      map['metadata'] = Variable<String>(metadata.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConnectionLogsCompanion(')
          ..write('id: $id, ')
          ..write('timestamp: $timestamp, ')
          ..write('eventType: $eventType, ')
          ..write('level: $level, ')
          ..write('message: $message, ')
          ..write('deviceAddress: $deviceAddress, ')
          ..write('deviceName: $deviceName, ')
          ..write('details: $details, ')
          ..write('metadata: $metadata')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $WorkoutSessionsTable workoutSessions = $WorkoutSessionsTable(
    this,
  );
  late final $WorkoutMetricsTable workoutMetrics = $WorkoutMetricsTable(this);
  late final $RoutinesTable routines = $RoutinesTable(this);
  late final $RoutineExercisesTable routineExercises = $RoutineExercisesTable(
    this,
  );
  late final $ExercisesTable exercises = $ExercisesTable(this);
  late final $ExerciseVideosTable exerciseVideos = $ExerciseVideosTable(this);
  late final $PersonalRecordsTable personalRecords = $PersonalRecordsTable(
    this,
  );
  late final $WeeklyProgramsTable weeklyPrograms = $WeeklyProgramsTable(this);
  late final $ProgramDaysTable programDays = $ProgramDaysTable(this);
  late final $ConnectionLogsTable connectionLogs = $ConnectionLogsTable(this);
  late final WorkoutDao workoutDao = WorkoutDao(this as AppDatabase);
  late final ExerciseDao exerciseDao = ExerciseDao(this as AppDatabase);
  late final PrDao prDao = PrDao(this as AppDatabase);
  late final ConnectionLogDao connectionLogDao = ConnectionLogDao(
    this as AppDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    workoutSessions,
    workoutMetrics,
    routines,
    routineExercises,
    exercises,
    exerciseVideos,
    personalRecords,
    weeklyPrograms,
    programDays,
    connectionLogs,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'routines',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('routine_exercises', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'exercises',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('exercise_videos', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'weekly_programs',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('program_days', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'routines',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('program_days', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$WorkoutSessionsTableCreateCompanionBuilder =
    WorkoutSessionsCompanion Function({
      required String id,
      required BigInt timestamp,
      required String mode,
      required int reps,
      required double weightPerCableKg,
      required double progressionKg,
      required int duration,
      required int totalReps,
      required int warmupReps,
      required int workingReps,
      required bool isJustLift,
      required bool stopAtTop,
      required int eccentricLoad,
      required int echoLevel,
      Value<String?> exerciseId,
      Value<int> rowid,
    });
typedef $$WorkoutSessionsTableUpdateCompanionBuilder =
    WorkoutSessionsCompanion Function({
      Value<String> id,
      Value<BigInt> timestamp,
      Value<String> mode,
      Value<int> reps,
      Value<double> weightPerCableKg,
      Value<double> progressionKg,
      Value<int> duration,
      Value<int> totalReps,
      Value<int> warmupReps,
      Value<int> workingReps,
      Value<bool> isJustLift,
      Value<bool> stopAtTop,
      Value<int> eccentricLoad,
      Value<int> echoLevel,
      Value<String?> exerciseId,
      Value<int> rowid,
    });

class $$WorkoutSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $WorkoutSessionsTable> {
  $$WorkoutSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<BigInt> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mode => $composableBuilder(
    column: $table.mode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reps => $composableBuilder(
    column: $table.reps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weightPerCableKg => $composableBuilder(
    column: $table.weightPerCableKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get progressionKg => $composableBuilder(
    column: $table.progressionKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get duration => $composableBuilder(
    column: $table.duration,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalReps => $composableBuilder(
    column: $table.totalReps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get warmupReps => $composableBuilder(
    column: $table.warmupReps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get workingReps => $composableBuilder(
    column: $table.workingReps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isJustLift => $composableBuilder(
    column: $table.isJustLift,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get stopAtTop => $composableBuilder(
    column: $table.stopAtTop,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get eccentricLoad => $composableBuilder(
    column: $table.eccentricLoad,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get echoLevel => $composableBuilder(
    column: $table.echoLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WorkoutSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkoutSessionsTable> {
  $$WorkoutSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<BigInt> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mode => $composableBuilder(
    column: $table.mode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reps => $composableBuilder(
    column: $table.reps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weightPerCableKg => $composableBuilder(
    column: $table.weightPerCableKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get progressionKg => $composableBuilder(
    column: $table.progressionKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get duration => $composableBuilder(
    column: $table.duration,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalReps => $composableBuilder(
    column: $table.totalReps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get warmupReps => $composableBuilder(
    column: $table.warmupReps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get workingReps => $composableBuilder(
    column: $table.workingReps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isJustLift => $composableBuilder(
    column: $table.isJustLift,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get stopAtTop => $composableBuilder(
    column: $table.stopAtTop,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get eccentricLoad => $composableBuilder(
    column: $table.eccentricLoad,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get echoLevel => $composableBuilder(
    column: $table.echoLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WorkoutSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkoutSessionsTable> {
  $$WorkoutSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<BigInt> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<String> get mode =>
      $composableBuilder(column: $table.mode, builder: (column) => column);

  GeneratedColumn<int> get reps =>
      $composableBuilder(column: $table.reps, builder: (column) => column);

  GeneratedColumn<double> get weightPerCableKg => $composableBuilder(
    column: $table.weightPerCableKg,
    builder: (column) => column,
  );

  GeneratedColumn<double> get progressionKg => $composableBuilder(
    column: $table.progressionKg,
    builder: (column) => column,
  );

  GeneratedColumn<int> get duration =>
      $composableBuilder(column: $table.duration, builder: (column) => column);

  GeneratedColumn<int> get totalReps =>
      $composableBuilder(column: $table.totalReps, builder: (column) => column);

  GeneratedColumn<int> get warmupReps => $composableBuilder(
    column: $table.warmupReps,
    builder: (column) => column,
  );

  GeneratedColumn<int> get workingReps => $composableBuilder(
    column: $table.workingReps,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isJustLift => $composableBuilder(
    column: $table.isJustLift,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get stopAtTop =>
      $composableBuilder(column: $table.stopAtTop, builder: (column) => column);

  GeneratedColumn<int> get eccentricLoad => $composableBuilder(
    column: $table.eccentricLoad,
    builder: (column) => column,
  );

  GeneratedColumn<int> get echoLevel =>
      $composableBuilder(column: $table.echoLevel, builder: (column) => column);

  GeneratedColumn<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => column,
  );
}

class $$WorkoutSessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WorkoutSessionsTable,
          WorkoutSession,
          $$WorkoutSessionsTableFilterComposer,
          $$WorkoutSessionsTableOrderingComposer,
          $$WorkoutSessionsTableAnnotationComposer,
          $$WorkoutSessionsTableCreateCompanionBuilder,
          $$WorkoutSessionsTableUpdateCompanionBuilder,
          (
            WorkoutSession,
            BaseReferences<
              _$AppDatabase,
              $WorkoutSessionsTable,
              WorkoutSession
            >,
          ),
          WorkoutSession,
          PrefetchHooks Function()
        > {
  $$WorkoutSessionsTableTableManager(
    _$AppDatabase db,
    $WorkoutSessionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkoutSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkoutSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkoutSessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<BigInt> timestamp = const Value.absent(),
                Value<String> mode = const Value.absent(),
                Value<int> reps = const Value.absent(),
                Value<double> weightPerCableKg = const Value.absent(),
                Value<double> progressionKg = const Value.absent(),
                Value<int> duration = const Value.absent(),
                Value<int> totalReps = const Value.absent(),
                Value<int> warmupReps = const Value.absent(),
                Value<int> workingReps = const Value.absent(),
                Value<bool> isJustLift = const Value.absent(),
                Value<bool> stopAtTop = const Value.absent(),
                Value<int> eccentricLoad = const Value.absent(),
                Value<int> echoLevel = const Value.absent(),
                Value<String?> exerciseId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkoutSessionsCompanion(
                id: id,
                timestamp: timestamp,
                mode: mode,
                reps: reps,
                weightPerCableKg: weightPerCableKg,
                progressionKg: progressionKg,
                duration: duration,
                totalReps: totalReps,
                warmupReps: warmupReps,
                workingReps: workingReps,
                isJustLift: isJustLift,
                stopAtTop: stopAtTop,
                eccentricLoad: eccentricLoad,
                echoLevel: echoLevel,
                exerciseId: exerciseId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required BigInt timestamp,
                required String mode,
                required int reps,
                required double weightPerCableKg,
                required double progressionKg,
                required int duration,
                required int totalReps,
                required int warmupReps,
                required int workingReps,
                required bool isJustLift,
                required bool stopAtTop,
                required int eccentricLoad,
                required int echoLevel,
                Value<String?> exerciseId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkoutSessionsCompanion.insert(
                id: id,
                timestamp: timestamp,
                mode: mode,
                reps: reps,
                weightPerCableKg: weightPerCableKg,
                progressionKg: progressionKg,
                duration: duration,
                totalReps: totalReps,
                warmupReps: warmupReps,
                workingReps: workingReps,
                isJustLift: isJustLift,
                stopAtTop: stopAtTop,
                eccentricLoad: eccentricLoad,
                echoLevel: echoLevel,
                exerciseId: exerciseId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WorkoutSessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WorkoutSessionsTable,
      WorkoutSession,
      $$WorkoutSessionsTableFilterComposer,
      $$WorkoutSessionsTableOrderingComposer,
      $$WorkoutSessionsTableAnnotationComposer,
      $$WorkoutSessionsTableCreateCompanionBuilder,
      $$WorkoutSessionsTableUpdateCompanionBuilder,
      (
        WorkoutSession,
        BaseReferences<_$AppDatabase, $WorkoutSessionsTable, WorkoutSession>,
      ),
      WorkoutSession,
      PrefetchHooks Function()
    >;
typedef $$WorkoutMetricsTableCreateCompanionBuilder =
    WorkoutMetricsCompanion Function({
      Value<int> id,
      required String sessionId,
      required BigInt timestamp,
      required double loadA,
      required double loadB,
      required int positionA,
      required int positionB,
      required int ticks,
      required double velocityA,
      required double velocityB,
      required double power,
    });
typedef $$WorkoutMetricsTableUpdateCompanionBuilder =
    WorkoutMetricsCompanion Function({
      Value<int> id,
      Value<String> sessionId,
      Value<BigInt> timestamp,
      Value<double> loadA,
      Value<double> loadB,
      Value<int> positionA,
      Value<int> positionB,
      Value<int> ticks,
      Value<double> velocityA,
      Value<double> velocityB,
      Value<double> power,
    });

class $$WorkoutMetricsTableFilterComposer
    extends Composer<_$AppDatabase, $WorkoutMetricsTable> {
  $$WorkoutMetricsTableFilterComposer({
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

  ColumnFilters<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<BigInt> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get loadA => $composableBuilder(
    column: $table.loadA,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get loadB => $composableBuilder(
    column: $table.loadB,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get positionA => $composableBuilder(
    column: $table.positionA,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get positionB => $composableBuilder(
    column: $table.positionB,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ticks => $composableBuilder(
    column: $table.ticks,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get velocityA => $composableBuilder(
    column: $table.velocityA,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get velocityB => $composableBuilder(
    column: $table.velocityB,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get power => $composableBuilder(
    column: $table.power,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WorkoutMetricsTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkoutMetricsTable> {
  $$WorkoutMetricsTableOrderingComposer({
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

  ColumnOrderings<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<BigInt> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get loadA => $composableBuilder(
    column: $table.loadA,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get loadB => $composableBuilder(
    column: $table.loadB,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get positionA => $composableBuilder(
    column: $table.positionA,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get positionB => $composableBuilder(
    column: $table.positionB,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ticks => $composableBuilder(
    column: $table.ticks,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get velocityA => $composableBuilder(
    column: $table.velocityA,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get velocityB => $composableBuilder(
    column: $table.velocityB,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get power => $composableBuilder(
    column: $table.power,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WorkoutMetricsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkoutMetricsTable> {
  $$WorkoutMetricsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sessionId =>
      $composableBuilder(column: $table.sessionId, builder: (column) => column);

  GeneratedColumn<BigInt> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<double> get loadA =>
      $composableBuilder(column: $table.loadA, builder: (column) => column);

  GeneratedColumn<double> get loadB =>
      $composableBuilder(column: $table.loadB, builder: (column) => column);

  GeneratedColumn<int> get positionA =>
      $composableBuilder(column: $table.positionA, builder: (column) => column);

  GeneratedColumn<int> get positionB =>
      $composableBuilder(column: $table.positionB, builder: (column) => column);

  GeneratedColumn<int> get ticks =>
      $composableBuilder(column: $table.ticks, builder: (column) => column);

  GeneratedColumn<double> get velocityA =>
      $composableBuilder(column: $table.velocityA, builder: (column) => column);

  GeneratedColumn<double> get velocityB =>
      $composableBuilder(column: $table.velocityB, builder: (column) => column);

  GeneratedColumn<double> get power =>
      $composableBuilder(column: $table.power, builder: (column) => column);
}

class $$WorkoutMetricsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WorkoutMetricsTable,
          WorkoutMetric,
          $$WorkoutMetricsTableFilterComposer,
          $$WorkoutMetricsTableOrderingComposer,
          $$WorkoutMetricsTableAnnotationComposer,
          $$WorkoutMetricsTableCreateCompanionBuilder,
          $$WorkoutMetricsTableUpdateCompanionBuilder,
          (
            WorkoutMetric,
            BaseReferences<_$AppDatabase, $WorkoutMetricsTable, WorkoutMetric>,
          ),
          WorkoutMetric,
          PrefetchHooks Function()
        > {
  $$WorkoutMetricsTableTableManager(
    _$AppDatabase db,
    $WorkoutMetricsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkoutMetricsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkoutMetricsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkoutMetricsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> sessionId = const Value.absent(),
                Value<BigInt> timestamp = const Value.absent(),
                Value<double> loadA = const Value.absent(),
                Value<double> loadB = const Value.absent(),
                Value<int> positionA = const Value.absent(),
                Value<int> positionB = const Value.absent(),
                Value<int> ticks = const Value.absent(),
                Value<double> velocityA = const Value.absent(),
                Value<double> velocityB = const Value.absent(),
                Value<double> power = const Value.absent(),
              }) => WorkoutMetricsCompanion(
                id: id,
                sessionId: sessionId,
                timestamp: timestamp,
                loadA: loadA,
                loadB: loadB,
                positionA: positionA,
                positionB: positionB,
                ticks: ticks,
                velocityA: velocityA,
                velocityB: velocityB,
                power: power,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String sessionId,
                required BigInt timestamp,
                required double loadA,
                required double loadB,
                required int positionA,
                required int positionB,
                required int ticks,
                required double velocityA,
                required double velocityB,
                required double power,
              }) => WorkoutMetricsCompanion.insert(
                id: id,
                sessionId: sessionId,
                timestamp: timestamp,
                loadA: loadA,
                loadB: loadB,
                positionA: positionA,
                positionB: positionB,
                ticks: ticks,
                velocityA: velocityA,
                velocityB: velocityB,
                power: power,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WorkoutMetricsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WorkoutMetricsTable,
      WorkoutMetric,
      $$WorkoutMetricsTableFilterComposer,
      $$WorkoutMetricsTableOrderingComposer,
      $$WorkoutMetricsTableAnnotationComposer,
      $$WorkoutMetricsTableCreateCompanionBuilder,
      $$WorkoutMetricsTableUpdateCompanionBuilder,
      (
        WorkoutMetric,
        BaseReferences<_$AppDatabase, $WorkoutMetricsTable, WorkoutMetric>,
      ),
      WorkoutMetric,
      PrefetchHooks Function()
    >;
typedef $$RoutinesTableCreateCompanionBuilder =
    RoutinesCompanion Function({
      required String id,
      required String name,
      required BigInt createdAt,
      required BigInt lastUsed,
      required int exerciseCount,
      Value<int> rowid,
    });
typedef $$RoutinesTableUpdateCompanionBuilder =
    RoutinesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<BigInt> createdAt,
      Value<BigInt> lastUsed,
      Value<int> exerciseCount,
      Value<int> rowid,
    });

final class $$RoutinesTableReferences
    extends BaseReferences<_$AppDatabase, $RoutinesTable, Routine> {
  $$RoutinesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$RoutineExercisesTable, List<RoutineExercise>>
  _routineExercisesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.routineExercises,
    aliasName: $_aliasNameGenerator(
      db.routines.id,
      db.routineExercises.routineId,
    ),
  );

  $$RoutineExercisesTableProcessedTableManager get routineExercisesRefs {
    final manager = $$RoutineExercisesTableTableManager(
      $_db,
      $_db.routineExercises,
    ).filter((f) => f.routineId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _routineExercisesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ProgramDaysTable, List<ProgramDay>>
  _programDaysRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.programDays,
    aliasName: $_aliasNameGenerator(db.routines.id, db.programDays.routineId),
  );

  $$ProgramDaysTableProcessedTableManager get programDaysRefs {
    final manager = $$ProgramDaysTableTableManager(
      $_db,
      $_db.programDays,
    ).filter((f) => f.routineId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_programDaysRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RoutinesTableFilterComposer
    extends Composer<_$AppDatabase, $RoutinesTable> {
  $$RoutinesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<BigInt> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<BigInt> get lastUsed => $composableBuilder(
    column: $table.lastUsed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get exerciseCount => $composableBuilder(
    column: $table.exerciseCount,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> routineExercisesRefs(
    Expression<bool> Function($$RoutineExercisesTableFilterComposer f) f,
  ) {
    final $$RoutineExercisesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.routineExercises,
      getReferencedColumn: (t) => t.routineId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoutineExercisesTableFilterComposer(
            $db: $db,
            $table: $db.routineExercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> programDaysRefs(
    Expression<bool> Function($$ProgramDaysTableFilterComposer f) f,
  ) {
    final $$ProgramDaysTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.programDays,
      getReferencedColumn: (t) => t.routineId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProgramDaysTableFilterComposer(
            $db: $db,
            $table: $db.programDays,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RoutinesTableOrderingComposer
    extends Composer<_$AppDatabase, $RoutinesTable> {
  $$RoutinesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<BigInt> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<BigInt> get lastUsed => $composableBuilder(
    column: $table.lastUsed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get exerciseCount => $composableBuilder(
    column: $table.exerciseCount,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RoutinesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RoutinesTable> {
  $$RoutinesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<BigInt> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<BigInt> get lastUsed =>
      $composableBuilder(column: $table.lastUsed, builder: (column) => column);

  GeneratedColumn<int> get exerciseCount => $composableBuilder(
    column: $table.exerciseCount,
    builder: (column) => column,
  );

  Expression<T> routineExercisesRefs<T extends Object>(
    Expression<T> Function($$RoutineExercisesTableAnnotationComposer a) f,
  ) {
    final $$RoutineExercisesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.routineExercises,
      getReferencedColumn: (t) => t.routineId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoutineExercisesTableAnnotationComposer(
            $db: $db,
            $table: $db.routineExercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> programDaysRefs<T extends Object>(
    Expression<T> Function($$ProgramDaysTableAnnotationComposer a) f,
  ) {
    final $$ProgramDaysTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.programDays,
      getReferencedColumn: (t) => t.routineId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProgramDaysTableAnnotationComposer(
            $db: $db,
            $table: $db.programDays,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RoutinesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RoutinesTable,
          Routine,
          $$RoutinesTableFilterComposer,
          $$RoutinesTableOrderingComposer,
          $$RoutinesTableAnnotationComposer,
          $$RoutinesTableCreateCompanionBuilder,
          $$RoutinesTableUpdateCompanionBuilder,
          (Routine, $$RoutinesTableReferences),
          Routine,
          PrefetchHooks Function({
            bool routineExercisesRefs,
            bool programDaysRefs,
          })
        > {
  $$RoutinesTableTableManager(_$AppDatabase db, $RoutinesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RoutinesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RoutinesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RoutinesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<BigInt> createdAt = const Value.absent(),
                Value<BigInt> lastUsed = const Value.absent(),
                Value<int> exerciseCount = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RoutinesCompanion(
                id: id,
                name: name,
                createdAt: createdAt,
                lastUsed: lastUsed,
                exerciseCount: exerciseCount,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required BigInt createdAt,
                required BigInt lastUsed,
                required int exerciseCount,
                Value<int> rowid = const Value.absent(),
              }) => RoutinesCompanion.insert(
                id: id,
                name: name,
                createdAt: createdAt,
                lastUsed: lastUsed,
                exerciseCount: exerciseCount,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RoutinesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({routineExercisesRefs = false, programDaysRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (routineExercisesRefs) db.routineExercises,
                    if (programDaysRefs) db.programDays,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (routineExercisesRefs)
                        await $_getPrefetchedData<
                          Routine,
                          $RoutinesTable,
                          RoutineExercise
                        >(
                          currentTable: table,
                          referencedTable: $$RoutinesTableReferences
                              ._routineExercisesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RoutinesTableReferences(
                                db,
                                table,
                                p0,
                              ).routineExercisesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.routineId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (programDaysRefs)
                        await $_getPrefetchedData<
                          Routine,
                          $RoutinesTable,
                          ProgramDay
                        >(
                          currentTable: table,
                          referencedTable: $$RoutinesTableReferences
                              ._programDaysRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RoutinesTableReferences(
                                db,
                                table,
                                p0,
                              ).programDaysRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.routineId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$RoutinesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RoutinesTable,
      Routine,
      $$RoutinesTableFilterComposer,
      $$RoutinesTableOrderingComposer,
      $$RoutinesTableAnnotationComposer,
      $$RoutinesTableCreateCompanionBuilder,
      $$RoutinesTableUpdateCompanionBuilder,
      (Routine, $$RoutinesTableReferences),
      Routine,
      PrefetchHooks Function({bool routineExercisesRefs, bool programDaysRefs})
    >;
typedef $$RoutineExercisesTableCreateCompanionBuilder =
    RoutineExercisesCompanion Function({
      Value<int> id,
      required String routineId,
      required String exerciseId,
      required int order,
      required int sets,
      required int reps,
      required double weightPerCableKg,
      required String mode,
      Value<int?> eccentricLoad,
      Value<int?> echoLevel,
    });
typedef $$RoutineExercisesTableUpdateCompanionBuilder =
    RoutineExercisesCompanion Function({
      Value<int> id,
      Value<String> routineId,
      Value<String> exerciseId,
      Value<int> order,
      Value<int> sets,
      Value<int> reps,
      Value<double> weightPerCableKg,
      Value<String> mode,
      Value<int?> eccentricLoad,
      Value<int?> echoLevel,
    });

final class $$RoutineExercisesTableReferences
    extends
        BaseReferences<_$AppDatabase, $RoutineExercisesTable, RoutineExercise> {
  $$RoutineExercisesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $RoutinesTable _routineIdTable(_$AppDatabase db) =>
      db.routines.createAlias(
        $_aliasNameGenerator(db.routineExercises.routineId, db.routines.id),
      );

  $$RoutinesTableProcessedTableManager get routineId {
    final $_column = $_itemColumn<String>('routine_id')!;

    final manager = $$RoutinesTableTableManager(
      $_db,
      $_db.routines,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_routineIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RoutineExercisesTableFilterComposer
    extends Composer<_$AppDatabase, $RoutineExercisesTable> {
  $$RoutineExercisesTableFilterComposer({
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

  ColumnFilters<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sets => $composableBuilder(
    column: $table.sets,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reps => $composableBuilder(
    column: $table.reps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weightPerCableKg => $composableBuilder(
    column: $table.weightPerCableKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mode => $composableBuilder(
    column: $table.mode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get eccentricLoad => $composableBuilder(
    column: $table.eccentricLoad,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get echoLevel => $composableBuilder(
    column: $table.echoLevel,
    builder: (column) => ColumnFilters(column),
  );

  $$RoutinesTableFilterComposer get routineId {
    final $$RoutinesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.routineId,
      referencedTable: $db.routines,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoutinesTableFilterComposer(
            $db: $db,
            $table: $db.routines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RoutineExercisesTableOrderingComposer
    extends Composer<_$AppDatabase, $RoutineExercisesTable> {
  $$RoutineExercisesTableOrderingComposer({
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

  ColumnOrderings<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sets => $composableBuilder(
    column: $table.sets,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reps => $composableBuilder(
    column: $table.reps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weightPerCableKg => $composableBuilder(
    column: $table.weightPerCableKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mode => $composableBuilder(
    column: $table.mode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get eccentricLoad => $composableBuilder(
    column: $table.eccentricLoad,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get echoLevel => $composableBuilder(
    column: $table.echoLevel,
    builder: (column) => ColumnOrderings(column),
  );

  $$RoutinesTableOrderingComposer get routineId {
    final $$RoutinesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.routineId,
      referencedTable: $db.routines,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoutinesTableOrderingComposer(
            $db: $db,
            $table: $db.routines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RoutineExercisesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RoutineExercisesTable> {
  $$RoutineExercisesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get order =>
      $composableBuilder(column: $table.order, builder: (column) => column);

  GeneratedColumn<int> get sets =>
      $composableBuilder(column: $table.sets, builder: (column) => column);

  GeneratedColumn<int> get reps =>
      $composableBuilder(column: $table.reps, builder: (column) => column);

  GeneratedColumn<double> get weightPerCableKg => $composableBuilder(
    column: $table.weightPerCableKg,
    builder: (column) => column,
  );

  GeneratedColumn<String> get mode =>
      $composableBuilder(column: $table.mode, builder: (column) => column);

  GeneratedColumn<int> get eccentricLoad => $composableBuilder(
    column: $table.eccentricLoad,
    builder: (column) => column,
  );

  GeneratedColumn<int> get echoLevel =>
      $composableBuilder(column: $table.echoLevel, builder: (column) => column);

  $$RoutinesTableAnnotationComposer get routineId {
    final $$RoutinesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.routineId,
      referencedTable: $db.routines,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoutinesTableAnnotationComposer(
            $db: $db,
            $table: $db.routines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RoutineExercisesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RoutineExercisesTable,
          RoutineExercise,
          $$RoutineExercisesTableFilterComposer,
          $$RoutineExercisesTableOrderingComposer,
          $$RoutineExercisesTableAnnotationComposer,
          $$RoutineExercisesTableCreateCompanionBuilder,
          $$RoutineExercisesTableUpdateCompanionBuilder,
          (RoutineExercise, $$RoutineExercisesTableReferences),
          RoutineExercise,
          PrefetchHooks Function({bool routineId})
        > {
  $$RoutineExercisesTableTableManager(
    _$AppDatabase db,
    $RoutineExercisesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RoutineExercisesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RoutineExercisesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RoutineExercisesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> routineId = const Value.absent(),
                Value<String> exerciseId = const Value.absent(),
                Value<int> order = const Value.absent(),
                Value<int> sets = const Value.absent(),
                Value<int> reps = const Value.absent(),
                Value<double> weightPerCableKg = const Value.absent(),
                Value<String> mode = const Value.absent(),
                Value<int?> eccentricLoad = const Value.absent(),
                Value<int?> echoLevel = const Value.absent(),
              }) => RoutineExercisesCompanion(
                id: id,
                routineId: routineId,
                exerciseId: exerciseId,
                order: order,
                sets: sets,
                reps: reps,
                weightPerCableKg: weightPerCableKg,
                mode: mode,
                eccentricLoad: eccentricLoad,
                echoLevel: echoLevel,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String routineId,
                required String exerciseId,
                required int order,
                required int sets,
                required int reps,
                required double weightPerCableKg,
                required String mode,
                Value<int?> eccentricLoad = const Value.absent(),
                Value<int?> echoLevel = const Value.absent(),
              }) => RoutineExercisesCompanion.insert(
                id: id,
                routineId: routineId,
                exerciseId: exerciseId,
                order: order,
                sets: sets,
                reps: reps,
                weightPerCableKg: weightPerCableKg,
                mode: mode,
                eccentricLoad: eccentricLoad,
                echoLevel: echoLevel,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RoutineExercisesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({routineId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (routineId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.routineId,
                                referencedTable:
                                    $$RoutineExercisesTableReferences
                                        ._routineIdTable(db),
                                referencedColumn:
                                    $$RoutineExercisesTableReferences
                                        ._routineIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RoutineExercisesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RoutineExercisesTable,
      RoutineExercise,
      $$RoutineExercisesTableFilterComposer,
      $$RoutineExercisesTableOrderingComposer,
      $$RoutineExercisesTableAnnotationComposer,
      $$RoutineExercisesTableCreateCompanionBuilder,
      $$RoutineExercisesTableUpdateCompanionBuilder,
      (RoutineExercise, $$RoutineExercisesTableReferences),
      RoutineExercise,
      PrefetchHooks Function({bool routineId})
    >;
typedef $$ExercisesTableCreateCompanionBuilder =
    ExercisesCompanion Function({
      required String id,
      required String name,
      Value<String?> category,
      Value<String?> muscleGroups,
      Value<String?> notes,
      required BigInt createdAt,
      required BigInt lastUsed,
      Value<int> rowid,
    });
typedef $$ExercisesTableUpdateCompanionBuilder =
    ExercisesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String?> category,
      Value<String?> muscleGroups,
      Value<String?> notes,
      Value<BigInt> createdAt,
      Value<BigInt> lastUsed,
      Value<int> rowid,
    });

final class $$ExercisesTableReferences
    extends BaseReferences<_$AppDatabase, $ExercisesTable, Exercise> {
  $$ExercisesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ExerciseVideosTable, List<ExerciseVideo>>
  _exerciseVideosRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.exerciseVideos,
    aliasName: $_aliasNameGenerator(
      db.exercises.id,
      db.exerciseVideos.exerciseId,
    ),
  );

  $$ExerciseVideosTableProcessedTableManager get exerciseVideosRefs {
    final manager = $$ExerciseVideosTableTableManager(
      $_db,
      $_db.exerciseVideos,
    ).filter((f) => f.exerciseId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_exerciseVideosRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ExercisesTableFilterComposer
    extends Composer<_$AppDatabase, $ExercisesTable> {
  $$ExercisesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get muscleGroups => $composableBuilder(
    column: $table.muscleGroups,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<BigInt> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<BigInt> get lastUsed => $composableBuilder(
    column: $table.lastUsed,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> exerciseVideosRefs(
    Expression<bool> Function($$ExerciseVideosTableFilterComposer f) f,
  ) {
    final $$ExerciseVideosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.exerciseVideos,
      getReferencedColumn: (t) => t.exerciseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExerciseVideosTableFilterComposer(
            $db: $db,
            $table: $db.exerciseVideos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ExercisesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExercisesTable> {
  $$ExercisesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get muscleGroups => $composableBuilder(
    column: $table.muscleGroups,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<BigInt> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<BigInt> get lastUsed => $composableBuilder(
    column: $table.lastUsed,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExercisesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExercisesTable> {
  $$ExercisesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get muscleGroups => $composableBuilder(
    column: $table.muscleGroups,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<BigInt> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<BigInt> get lastUsed =>
      $composableBuilder(column: $table.lastUsed, builder: (column) => column);

  Expression<T> exerciseVideosRefs<T extends Object>(
    Expression<T> Function($$ExerciseVideosTableAnnotationComposer a) f,
  ) {
    final $$ExerciseVideosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.exerciseVideos,
      getReferencedColumn: (t) => t.exerciseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExerciseVideosTableAnnotationComposer(
            $db: $db,
            $table: $db.exerciseVideos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ExercisesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExercisesTable,
          Exercise,
          $$ExercisesTableFilterComposer,
          $$ExercisesTableOrderingComposer,
          $$ExercisesTableAnnotationComposer,
          $$ExercisesTableCreateCompanionBuilder,
          $$ExercisesTableUpdateCompanionBuilder,
          (Exercise, $$ExercisesTableReferences),
          Exercise,
          PrefetchHooks Function({bool exerciseVideosRefs})
        > {
  $$ExercisesTableTableManager(_$AppDatabase db, $ExercisesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExercisesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExercisesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExercisesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> category = const Value.absent(),
                Value<String?> muscleGroups = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<BigInt> createdAt = const Value.absent(),
                Value<BigInt> lastUsed = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExercisesCompanion(
                id: id,
                name: name,
                category: category,
                muscleGroups: muscleGroups,
                notes: notes,
                createdAt: createdAt,
                lastUsed: lastUsed,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> category = const Value.absent(),
                Value<String?> muscleGroups = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required BigInt createdAt,
                required BigInt lastUsed,
                Value<int> rowid = const Value.absent(),
              }) => ExercisesCompanion.insert(
                id: id,
                name: name,
                category: category,
                muscleGroups: muscleGroups,
                notes: notes,
                createdAt: createdAt,
                lastUsed: lastUsed,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ExercisesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({exerciseVideosRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (exerciseVideosRefs) db.exerciseVideos,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (exerciseVideosRefs)
                    await $_getPrefetchedData<
                      Exercise,
                      $ExercisesTable,
                      ExerciseVideo
                    >(
                      currentTable: table,
                      referencedTable: $$ExercisesTableReferences
                          ._exerciseVideosRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ExercisesTableReferences(
                            db,
                            table,
                            p0,
                          ).exerciseVideosRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.exerciseId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ExercisesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExercisesTable,
      Exercise,
      $$ExercisesTableFilterComposer,
      $$ExercisesTableOrderingComposer,
      $$ExercisesTableAnnotationComposer,
      $$ExercisesTableCreateCompanionBuilder,
      $$ExercisesTableUpdateCompanionBuilder,
      (Exercise, $$ExercisesTableReferences),
      Exercise,
      PrefetchHooks Function({bool exerciseVideosRefs})
    >;
typedef $$ExerciseVideosTableCreateCompanionBuilder =
    ExerciseVideosCompanion Function({
      Value<int> id,
      required String exerciseId,
      required String videoUrl,
      Value<String?> thumbnailUrl,
      required int order,
    });
typedef $$ExerciseVideosTableUpdateCompanionBuilder =
    ExerciseVideosCompanion Function({
      Value<int> id,
      Value<String> exerciseId,
      Value<String> videoUrl,
      Value<String?> thumbnailUrl,
      Value<int> order,
    });

final class $$ExerciseVideosTableReferences
    extends BaseReferences<_$AppDatabase, $ExerciseVideosTable, ExerciseVideo> {
  $$ExerciseVideosTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ExercisesTable _exerciseIdTable(_$AppDatabase db) =>
      db.exercises.createAlias(
        $_aliasNameGenerator(db.exerciseVideos.exerciseId, db.exercises.id),
      );

  $$ExercisesTableProcessedTableManager get exerciseId {
    final $_column = $_itemColumn<String>('exercise_id')!;

    final manager = $$ExercisesTableTableManager(
      $_db,
      $_db.exercises,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_exerciseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ExerciseVideosTableFilterComposer
    extends Composer<_$AppDatabase, $ExerciseVideosTable> {
  $$ExerciseVideosTableFilterComposer({
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

  ColumnFilters<String> get videoUrl => $composableBuilder(
    column: $table.videoUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get thumbnailUrl => $composableBuilder(
    column: $table.thumbnailUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnFilters(column),
  );

  $$ExercisesTableFilterComposer get exerciseId {
    final $$ExercisesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableFilterComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExerciseVideosTableOrderingComposer
    extends Composer<_$AppDatabase, $ExerciseVideosTable> {
  $$ExerciseVideosTableOrderingComposer({
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

  ColumnOrderings<String> get videoUrl => $composableBuilder(
    column: $table.videoUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get thumbnailUrl => $composableBuilder(
    column: $table.thumbnailUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnOrderings(column),
  );

  $$ExercisesTableOrderingComposer get exerciseId {
    final $$ExercisesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableOrderingComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExerciseVideosTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExerciseVideosTable> {
  $$ExerciseVideosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get videoUrl =>
      $composableBuilder(column: $table.videoUrl, builder: (column) => column);

  GeneratedColumn<String> get thumbnailUrl => $composableBuilder(
    column: $table.thumbnailUrl,
    builder: (column) => column,
  );

  GeneratedColumn<int> get order =>
      $composableBuilder(column: $table.order, builder: (column) => column);

  $$ExercisesTableAnnotationComposer get exerciseId {
    final $$ExercisesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableAnnotationComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExerciseVideosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExerciseVideosTable,
          ExerciseVideo,
          $$ExerciseVideosTableFilterComposer,
          $$ExerciseVideosTableOrderingComposer,
          $$ExerciseVideosTableAnnotationComposer,
          $$ExerciseVideosTableCreateCompanionBuilder,
          $$ExerciseVideosTableUpdateCompanionBuilder,
          (ExerciseVideo, $$ExerciseVideosTableReferences),
          ExerciseVideo,
          PrefetchHooks Function({bool exerciseId})
        > {
  $$ExerciseVideosTableTableManager(
    _$AppDatabase db,
    $ExerciseVideosTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExerciseVideosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExerciseVideosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExerciseVideosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> exerciseId = const Value.absent(),
                Value<String> videoUrl = const Value.absent(),
                Value<String?> thumbnailUrl = const Value.absent(),
                Value<int> order = const Value.absent(),
              }) => ExerciseVideosCompanion(
                id: id,
                exerciseId: exerciseId,
                videoUrl: videoUrl,
                thumbnailUrl: thumbnailUrl,
                order: order,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String exerciseId,
                required String videoUrl,
                Value<String?> thumbnailUrl = const Value.absent(),
                required int order,
              }) => ExerciseVideosCompanion.insert(
                id: id,
                exerciseId: exerciseId,
                videoUrl: videoUrl,
                thumbnailUrl: thumbnailUrl,
                order: order,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ExerciseVideosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({exerciseId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (exerciseId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.exerciseId,
                                referencedTable: $$ExerciseVideosTableReferences
                                    ._exerciseIdTable(db),
                                referencedColumn:
                                    $$ExerciseVideosTableReferences
                                        ._exerciseIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ExerciseVideosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExerciseVideosTable,
      ExerciseVideo,
      $$ExerciseVideosTableFilterComposer,
      $$ExerciseVideosTableOrderingComposer,
      $$ExerciseVideosTableAnnotationComposer,
      $$ExerciseVideosTableCreateCompanionBuilder,
      $$ExerciseVideosTableUpdateCompanionBuilder,
      (ExerciseVideo, $$ExerciseVideosTableReferences),
      ExerciseVideo,
      PrefetchHooks Function({bool exerciseId})
    >;
typedef $$PersonalRecordsTableCreateCompanionBuilder =
    PersonalRecordsCompanion Function({
      Value<int> id,
      required String exerciseId,
      required double weightPerCableKg,
      required int reps,
      required BigInt timestamp,
      required String workoutMode,
    });
typedef $$PersonalRecordsTableUpdateCompanionBuilder =
    PersonalRecordsCompanion Function({
      Value<int> id,
      Value<String> exerciseId,
      Value<double> weightPerCableKg,
      Value<int> reps,
      Value<BigInt> timestamp,
      Value<String> workoutMode,
    });

class $$PersonalRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $PersonalRecordsTable> {
  $$PersonalRecordsTableFilterComposer({
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

  ColumnFilters<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weightPerCableKg => $composableBuilder(
    column: $table.weightPerCableKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reps => $composableBuilder(
    column: $table.reps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<BigInt> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get workoutMode => $composableBuilder(
    column: $table.workoutMode,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PersonalRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $PersonalRecordsTable> {
  $$PersonalRecordsTableOrderingComposer({
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

  ColumnOrderings<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weightPerCableKg => $composableBuilder(
    column: $table.weightPerCableKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reps => $composableBuilder(
    column: $table.reps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<BigInt> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get workoutMode => $composableBuilder(
    column: $table.workoutMode,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PersonalRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PersonalRecordsTable> {
  $$PersonalRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => column,
  );

  GeneratedColumn<double> get weightPerCableKg => $composableBuilder(
    column: $table.weightPerCableKg,
    builder: (column) => column,
  );

  GeneratedColumn<int> get reps =>
      $composableBuilder(column: $table.reps, builder: (column) => column);

  GeneratedColumn<BigInt> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<String> get workoutMode => $composableBuilder(
    column: $table.workoutMode,
    builder: (column) => column,
  );
}

class $$PersonalRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PersonalRecordsTable,
          PersonalRecord,
          $$PersonalRecordsTableFilterComposer,
          $$PersonalRecordsTableOrderingComposer,
          $$PersonalRecordsTableAnnotationComposer,
          $$PersonalRecordsTableCreateCompanionBuilder,
          $$PersonalRecordsTableUpdateCompanionBuilder,
          (
            PersonalRecord,
            BaseReferences<
              _$AppDatabase,
              $PersonalRecordsTable,
              PersonalRecord
            >,
          ),
          PersonalRecord,
          PrefetchHooks Function()
        > {
  $$PersonalRecordsTableTableManager(
    _$AppDatabase db,
    $PersonalRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PersonalRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PersonalRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PersonalRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> exerciseId = const Value.absent(),
                Value<double> weightPerCableKg = const Value.absent(),
                Value<int> reps = const Value.absent(),
                Value<BigInt> timestamp = const Value.absent(),
                Value<String> workoutMode = const Value.absent(),
              }) => PersonalRecordsCompanion(
                id: id,
                exerciseId: exerciseId,
                weightPerCableKg: weightPerCableKg,
                reps: reps,
                timestamp: timestamp,
                workoutMode: workoutMode,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String exerciseId,
                required double weightPerCableKg,
                required int reps,
                required BigInt timestamp,
                required String workoutMode,
              }) => PersonalRecordsCompanion.insert(
                id: id,
                exerciseId: exerciseId,
                weightPerCableKg: weightPerCableKg,
                reps: reps,
                timestamp: timestamp,
                workoutMode: workoutMode,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PersonalRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PersonalRecordsTable,
      PersonalRecord,
      $$PersonalRecordsTableFilterComposer,
      $$PersonalRecordsTableOrderingComposer,
      $$PersonalRecordsTableAnnotationComposer,
      $$PersonalRecordsTableCreateCompanionBuilder,
      $$PersonalRecordsTableUpdateCompanionBuilder,
      (
        PersonalRecord,
        BaseReferences<_$AppDatabase, $PersonalRecordsTable, PersonalRecord>,
      ),
      PersonalRecord,
      PrefetchHooks Function()
    >;
typedef $$WeeklyProgramsTableCreateCompanionBuilder =
    WeeklyProgramsCompanion Function({
      required String id,
      required String name,
      required BigInt createdAt,
      required BigInt lastUsed,
      Value<bool> isActive,
      Value<int> rowid,
    });
typedef $$WeeklyProgramsTableUpdateCompanionBuilder =
    WeeklyProgramsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<BigInt> createdAt,
      Value<BigInt> lastUsed,
      Value<bool> isActive,
      Value<int> rowid,
    });

final class $$WeeklyProgramsTableReferences
    extends BaseReferences<_$AppDatabase, $WeeklyProgramsTable, WeeklyProgram> {
  $$WeeklyProgramsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$ProgramDaysTable, List<ProgramDay>>
  _programDaysRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.programDays,
    aliasName: $_aliasNameGenerator(
      db.weeklyPrograms.id,
      db.programDays.programId,
    ),
  );

  $$ProgramDaysTableProcessedTableManager get programDaysRefs {
    final manager = $$ProgramDaysTableTableManager(
      $_db,
      $_db.programDays,
    ).filter((f) => f.programId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_programDaysRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$WeeklyProgramsTableFilterComposer
    extends Composer<_$AppDatabase, $WeeklyProgramsTable> {
  $$WeeklyProgramsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<BigInt> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<BigInt> get lastUsed => $composableBuilder(
    column: $table.lastUsed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> programDaysRefs(
    Expression<bool> Function($$ProgramDaysTableFilterComposer f) f,
  ) {
    final $$ProgramDaysTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.programDays,
      getReferencedColumn: (t) => t.programId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProgramDaysTableFilterComposer(
            $db: $db,
            $table: $db.programDays,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WeeklyProgramsTableOrderingComposer
    extends Composer<_$AppDatabase, $WeeklyProgramsTable> {
  $$WeeklyProgramsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<BigInt> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<BigInt> get lastUsed => $composableBuilder(
    column: $table.lastUsed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WeeklyProgramsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WeeklyProgramsTable> {
  $$WeeklyProgramsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<BigInt> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<BigInt> get lastUsed =>
      $composableBuilder(column: $table.lastUsed, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  Expression<T> programDaysRefs<T extends Object>(
    Expression<T> Function($$ProgramDaysTableAnnotationComposer a) f,
  ) {
    final $$ProgramDaysTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.programDays,
      getReferencedColumn: (t) => t.programId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProgramDaysTableAnnotationComposer(
            $db: $db,
            $table: $db.programDays,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WeeklyProgramsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WeeklyProgramsTable,
          WeeklyProgram,
          $$WeeklyProgramsTableFilterComposer,
          $$WeeklyProgramsTableOrderingComposer,
          $$WeeklyProgramsTableAnnotationComposer,
          $$WeeklyProgramsTableCreateCompanionBuilder,
          $$WeeklyProgramsTableUpdateCompanionBuilder,
          (WeeklyProgram, $$WeeklyProgramsTableReferences),
          WeeklyProgram,
          PrefetchHooks Function({bool programDaysRefs})
        > {
  $$WeeklyProgramsTableTableManager(
    _$AppDatabase db,
    $WeeklyProgramsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WeeklyProgramsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WeeklyProgramsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WeeklyProgramsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<BigInt> createdAt = const Value.absent(),
                Value<BigInt> lastUsed = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WeeklyProgramsCompanion(
                id: id,
                name: name,
                createdAt: createdAt,
                lastUsed: lastUsed,
                isActive: isActive,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required BigInt createdAt,
                required BigInt lastUsed,
                Value<bool> isActive = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WeeklyProgramsCompanion.insert(
                id: id,
                name: name,
                createdAt: createdAt,
                lastUsed: lastUsed,
                isActive: isActive,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$WeeklyProgramsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({programDaysRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (programDaysRefs) db.programDays],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (programDaysRefs)
                    await $_getPrefetchedData<
                      WeeklyProgram,
                      $WeeklyProgramsTable,
                      ProgramDay
                    >(
                      currentTable: table,
                      referencedTable: $$WeeklyProgramsTableReferences
                          ._programDaysRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$WeeklyProgramsTableReferences(
                            db,
                            table,
                            p0,
                          ).programDaysRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.programId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$WeeklyProgramsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WeeklyProgramsTable,
      WeeklyProgram,
      $$WeeklyProgramsTableFilterComposer,
      $$WeeklyProgramsTableOrderingComposer,
      $$WeeklyProgramsTableAnnotationComposer,
      $$WeeklyProgramsTableCreateCompanionBuilder,
      $$WeeklyProgramsTableUpdateCompanionBuilder,
      (WeeklyProgram, $$WeeklyProgramsTableReferences),
      WeeklyProgram,
      PrefetchHooks Function({bool programDaysRefs})
    >;
typedef $$ProgramDaysTableCreateCompanionBuilder =
    ProgramDaysCompanion Function({
      Value<int> id,
      required String programId,
      required String routineId,
      required int dayOfWeek,
    });
typedef $$ProgramDaysTableUpdateCompanionBuilder =
    ProgramDaysCompanion Function({
      Value<int> id,
      Value<String> programId,
      Value<String> routineId,
      Value<int> dayOfWeek,
    });

final class $$ProgramDaysTableReferences
    extends BaseReferences<_$AppDatabase, $ProgramDaysTable, ProgramDay> {
  $$ProgramDaysTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $WeeklyProgramsTable _programIdTable(_$AppDatabase db) =>
      db.weeklyPrograms.createAlias(
        $_aliasNameGenerator(db.programDays.programId, db.weeklyPrograms.id),
      );

  $$WeeklyProgramsTableProcessedTableManager get programId {
    final $_column = $_itemColumn<String>('program_id')!;

    final manager = $$WeeklyProgramsTableTableManager(
      $_db,
      $_db.weeklyPrograms,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_programIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $RoutinesTable _routineIdTable(_$AppDatabase db) =>
      db.routines.createAlias(
        $_aliasNameGenerator(db.programDays.routineId, db.routines.id),
      );

  $$RoutinesTableProcessedTableManager get routineId {
    final $_column = $_itemColumn<String>('routine_id')!;

    final manager = $$RoutinesTableTableManager(
      $_db,
      $_db.routines,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_routineIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ProgramDaysTableFilterComposer
    extends Composer<_$AppDatabase, $ProgramDaysTable> {
  $$ProgramDaysTableFilterComposer({
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

  ColumnFilters<int> get dayOfWeek => $composableBuilder(
    column: $table.dayOfWeek,
    builder: (column) => ColumnFilters(column),
  );

  $$WeeklyProgramsTableFilterComposer get programId {
    final $$WeeklyProgramsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.programId,
      referencedTable: $db.weeklyPrograms,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeeklyProgramsTableFilterComposer(
            $db: $db,
            $table: $db.weeklyPrograms,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RoutinesTableFilterComposer get routineId {
    final $$RoutinesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.routineId,
      referencedTable: $db.routines,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoutinesTableFilterComposer(
            $db: $db,
            $table: $db.routines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProgramDaysTableOrderingComposer
    extends Composer<_$AppDatabase, $ProgramDaysTable> {
  $$ProgramDaysTableOrderingComposer({
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

  ColumnOrderings<int> get dayOfWeek => $composableBuilder(
    column: $table.dayOfWeek,
    builder: (column) => ColumnOrderings(column),
  );

  $$WeeklyProgramsTableOrderingComposer get programId {
    final $$WeeklyProgramsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.programId,
      referencedTable: $db.weeklyPrograms,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeeklyProgramsTableOrderingComposer(
            $db: $db,
            $table: $db.weeklyPrograms,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RoutinesTableOrderingComposer get routineId {
    final $$RoutinesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.routineId,
      referencedTable: $db.routines,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoutinesTableOrderingComposer(
            $db: $db,
            $table: $db.routines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProgramDaysTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProgramDaysTable> {
  $$ProgramDaysTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get dayOfWeek =>
      $composableBuilder(column: $table.dayOfWeek, builder: (column) => column);

  $$WeeklyProgramsTableAnnotationComposer get programId {
    final $$WeeklyProgramsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.programId,
      referencedTable: $db.weeklyPrograms,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeeklyProgramsTableAnnotationComposer(
            $db: $db,
            $table: $db.weeklyPrograms,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RoutinesTableAnnotationComposer get routineId {
    final $$RoutinesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.routineId,
      referencedTable: $db.routines,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoutinesTableAnnotationComposer(
            $db: $db,
            $table: $db.routines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProgramDaysTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProgramDaysTable,
          ProgramDay,
          $$ProgramDaysTableFilterComposer,
          $$ProgramDaysTableOrderingComposer,
          $$ProgramDaysTableAnnotationComposer,
          $$ProgramDaysTableCreateCompanionBuilder,
          $$ProgramDaysTableUpdateCompanionBuilder,
          (ProgramDay, $$ProgramDaysTableReferences),
          ProgramDay,
          PrefetchHooks Function({bool programId, bool routineId})
        > {
  $$ProgramDaysTableTableManager(_$AppDatabase db, $ProgramDaysTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProgramDaysTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProgramDaysTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProgramDaysTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> programId = const Value.absent(),
                Value<String> routineId = const Value.absent(),
                Value<int> dayOfWeek = const Value.absent(),
              }) => ProgramDaysCompanion(
                id: id,
                programId: programId,
                routineId: routineId,
                dayOfWeek: dayOfWeek,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String programId,
                required String routineId,
                required int dayOfWeek,
              }) => ProgramDaysCompanion.insert(
                id: id,
                programId: programId,
                routineId: routineId,
                dayOfWeek: dayOfWeek,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProgramDaysTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({programId = false, routineId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (programId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.programId,
                                referencedTable: $$ProgramDaysTableReferences
                                    ._programIdTable(db),
                                referencedColumn: $$ProgramDaysTableReferences
                                    ._programIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (routineId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.routineId,
                                referencedTable: $$ProgramDaysTableReferences
                                    ._routineIdTable(db),
                                referencedColumn: $$ProgramDaysTableReferences
                                    ._routineIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ProgramDaysTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProgramDaysTable,
      ProgramDay,
      $$ProgramDaysTableFilterComposer,
      $$ProgramDaysTableOrderingComposer,
      $$ProgramDaysTableAnnotationComposer,
      $$ProgramDaysTableCreateCompanionBuilder,
      $$ProgramDaysTableUpdateCompanionBuilder,
      (ProgramDay, $$ProgramDaysTableReferences),
      ProgramDay,
      PrefetchHooks Function({bool programId, bool routineId})
    >;
typedef $$ConnectionLogsTableCreateCompanionBuilder =
    ConnectionLogsCompanion Function({
      Value<int> id,
      required BigInt timestamp,
      required String eventType,
      required String level,
      required String message,
      Value<String?> deviceAddress,
      Value<String?> deviceName,
      Value<String?> details,
      Value<String?> metadata,
    });
typedef $$ConnectionLogsTableUpdateCompanionBuilder =
    ConnectionLogsCompanion Function({
      Value<int> id,
      Value<BigInt> timestamp,
      Value<String> eventType,
      Value<String> level,
      Value<String> message,
      Value<String?> deviceAddress,
      Value<String?> deviceName,
      Value<String?> details,
      Value<String?> metadata,
    });

class $$ConnectionLogsTableFilterComposer
    extends Composer<_$AppDatabase, $ConnectionLogsTable> {
  $$ConnectionLogsTableFilterComposer({
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

  ColumnFilters<BigInt> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get eventType => $composableBuilder(
    column: $table.eventType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceAddress => $composableBuilder(
    column: $table.deviceAddress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceName => $composableBuilder(
    column: $table.deviceName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get details => $composableBuilder(
    column: $table.details,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metadata => $composableBuilder(
    column: $table.metadata,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ConnectionLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $ConnectionLogsTable> {
  $$ConnectionLogsTableOrderingComposer({
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

  ColumnOrderings<BigInt> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get eventType => $composableBuilder(
    column: $table.eventType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceAddress => $composableBuilder(
    column: $table.deviceAddress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceName => $composableBuilder(
    column: $table.deviceName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get details => $composableBuilder(
    column: $table.details,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metadata => $composableBuilder(
    column: $table.metadata,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ConnectionLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ConnectionLogsTable> {
  $$ConnectionLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<BigInt> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<String> get eventType =>
      $composableBuilder(column: $table.eventType, builder: (column) => column);

  GeneratedColumn<String> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<String> get message =>
      $composableBuilder(column: $table.message, builder: (column) => column);

  GeneratedColumn<String> get deviceAddress => $composableBuilder(
    column: $table.deviceAddress,
    builder: (column) => column,
  );

  GeneratedColumn<String> get deviceName => $composableBuilder(
    column: $table.deviceName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get details =>
      $composableBuilder(column: $table.details, builder: (column) => column);

  GeneratedColumn<String> get metadata =>
      $composableBuilder(column: $table.metadata, builder: (column) => column);
}

class $$ConnectionLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ConnectionLogsTable,
          ConnectionLog,
          $$ConnectionLogsTableFilterComposer,
          $$ConnectionLogsTableOrderingComposer,
          $$ConnectionLogsTableAnnotationComposer,
          $$ConnectionLogsTableCreateCompanionBuilder,
          $$ConnectionLogsTableUpdateCompanionBuilder,
          (
            ConnectionLog,
            BaseReferences<_$AppDatabase, $ConnectionLogsTable, ConnectionLog>,
          ),
          ConnectionLog,
          PrefetchHooks Function()
        > {
  $$ConnectionLogsTableTableManager(
    _$AppDatabase db,
    $ConnectionLogsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ConnectionLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ConnectionLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ConnectionLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<BigInt> timestamp = const Value.absent(),
                Value<String> eventType = const Value.absent(),
                Value<String> level = const Value.absent(),
                Value<String> message = const Value.absent(),
                Value<String?> deviceAddress = const Value.absent(),
                Value<String?> deviceName = const Value.absent(),
                Value<String?> details = const Value.absent(),
                Value<String?> metadata = const Value.absent(),
              }) => ConnectionLogsCompanion(
                id: id,
                timestamp: timestamp,
                eventType: eventType,
                level: level,
                message: message,
                deviceAddress: deviceAddress,
                deviceName: deviceName,
                details: details,
                metadata: metadata,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required BigInt timestamp,
                required String eventType,
                required String level,
                required String message,
                Value<String?> deviceAddress = const Value.absent(),
                Value<String?> deviceName = const Value.absent(),
                Value<String?> details = const Value.absent(),
                Value<String?> metadata = const Value.absent(),
              }) => ConnectionLogsCompanion.insert(
                id: id,
                timestamp: timestamp,
                eventType: eventType,
                level: level,
                message: message,
                deviceAddress: deviceAddress,
                deviceName: deviceName,
                details: details,
                metadata: metadata,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ConnectionLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ConnectionLogsTable,
      ConnectionLog,
      $$ConnectionLogsTableFilterComposer,
      $$ConnectionLogsTableOrderingComposer,
      $$ConnectionLogsTableAnnotationComposer,
      $$ConnectionLogsTableCreateCompanionBuilder,
      $$ConnectionLogsTableUpdateCompanionBuilder,
      (
        ConnectionLog,
        BaseReferences<_$AppDatabase, $ConnectionLogsTable, ConnectionLog>,
      ),
      ConnectionLog,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$WorkoutSessionsTableTableManager get workoutSessions =>
      $$WorkoutSessionsTableTableManager(_db, _db.workoutSessions);
  $$WorkoutMetricsTableTableManager get workoutMetrics =>
      $$WorkoutMetricsTableTableManager(_db, _db.workoutMetrics);
  $$RoutinesTableTableManager get routines =>
      $$RoutinesTableTableManager(_db, _db.routines);
  $$RoutineExercisesTableTableManager get routineExercises =>
      $$RoutineExercisesTableTableManager(_db, _db.routineExercises);
  $$ExercisesTableTableManager get exercises =>
      $$ExercisesTableTableManager(_db, _db.exercises);
  $$ExerciseVideosTableTableManager get exerciseVideos =>
      $$ExerciseVideosTableTableManager(_db, _db.exerciseVideos);
  $$PersonalRecordsTableTableManager get personalRecords =>
      $$PersonalRecordsTableTableManager(_db, _db.personalRecords);
  $$WeeklyProgramsTableTableManager get weeklyPrograms =>
      $$WeeklyProgramsTableTableManager(_db, _db.weeklyPrograms);
  $$ProgramDaysTableTableManager get programDays =>
      $$ProgramDaysTableTableManager(_db, _db.programDays);
  $$ConnectionLogsTableTableManager get connectionLogs =>
      $$ConnectionLogsTableTableManager(_db, _db.connectionLogs);
}
