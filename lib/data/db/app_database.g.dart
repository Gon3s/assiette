// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $TagsTable extends Tags with TableInfo<$TagsTable, Tag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
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
  static const VerificationMeta _isSystemMeta = const VerificationMeta(
    'isSystem',
  );
  @override
  late final GeneratedColumn<bool> isSystem = GeneratedColumn<bool>(
    'is_system',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_system" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    label,
    category,
    isSystem,
    createdAt,
    updatedAt,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tags';
  @override
  VerificationContext validateIntegrity(
    Insertable<Tag> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('is_system')) {
      context.handle(
        _isSystemMeta,
        isSystem.isAcceptableOrUnknown(data['is_system']!, _isSystemMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Tag(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      ),
      isSystem: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_system'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $TagsTable createAlias(String alias) {
    return $TagsTable(attachedDatabase, alias);
  }
}

class Tag extends DataClass implements Insertable<Tag> {
  final String id;
  final String label;
  final String? category;
  final bool isSystem;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  const Tag({
    required this.id,
    required this.label,
    this.category,
    required this.isSystem,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['label'] = Variable<String>(label);
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    map['is_system'] = Variable<bool>(isSystem);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  TagsCompanion toCompanion(bool nullToAbsent) {
    return TagsCompanion(
      id: Value(id),
      label: Value(label),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      isSystem: Value(isSystem),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory Tag.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Tag(
      id: serializer.fromJson<String>(json['id']),
      label: serializer.fromJson<String>(json['label']),
      category: serializer.fromJson<String?>(json['category']),
      isSystem: serializer.fromJson<bool>(json['isSystem']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'label': serializer.toJson<String>(label),
      'category': serializer.toJson<String?>(category),
      'isSystem': serializer.toJson<bool>(isSystem),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  Tag copyWith({
    String? id,
    String? label,
    Value<String?> category = const Value.absent(),
    bool? isSystem,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
  }) => Tag(
    id: id ?? this.id,
    label: label ?? this.label,
    category: category.present ? category.value : this.category,
    isSystem: isSystem ?? this.isSystem,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  Tag copyWithCompanion(TagsCompanion data) {
    return Tag(
      id: data.id.present ? data.id.value : this.id,
      label: data.label.present ? data.label.value : this.label,
      category: data.category.present ? data.category.value : this.category,
      isSystem: data.isSystem.present ? data.isSystem.value : this.isSystem,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Tag(')
          ..write('id: $id, ')
          ..write('label: $label, ')
          ..write('category: $category, ')
          ..write('isSystem: $isSystem, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    label,
    category,
    isSystem,
    createdAt,
    updatedAt,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tag &&
          other.id == this.id &&
          other.label == this.label &&
          other.category == this.category &&
          other.isSystem == this.isSystem &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class TagsCompanion extends UpdateCompanion<Tag> {
  final Value<String> id;
  final Value<String> label;
  final Value<String?> category;
  final Value<bool> isSystem;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const TagsCompanion({
    this.id = const Value.absent(),
    this.label = const Value.absent(),
    this.category = const Value.absent(),
    this.isSystem = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TagsCompanion.insert({
    required String id,
    required String label,
    this.category = const Value.absent(),
    this.isSystem = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       label = Value(label);
  static Insertable<Tag> custom({
    Expression<String>? id,
    Expression<String>? label,
    Expression<String>? category,
    Expression<bool>? isSystem,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (label != null) 'label': label,
      if (category != null) 'category': category,
      if (isSystem != null) 'is_system': isSystem,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TagsCompanion copyWith({
    Value<String>? id,
    Value<String>? label,
    Value<String?>? category,
    Value<bool>? isSystem,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<int>? rowid,
  }) {
    return TagsCompanion(
      id: id ?? this.id,
      label: label ?? this.label,
      category: category ?? this.category,
      isSystem: isSystem ?? this.isSystem,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (isSystem.present) {
      map['is_system'] = Variable<bool>(isSystem.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TagsCompanion(')
          ..write('id: $id, ')
          ..write('label: $label, ')
          ..write('category: $category, ')
          ..write('isSystem: $isSystem, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MealsTable extends Meals with TableInfo<$MealsTable, Meal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MealsTable(this.attachedDatabase, [this._alias]);
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
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<MealType, int> mealType =
      GeneratedColumn<int>(
        'meal_type',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<MealType>($MealsTable.$convertermealType);
  static const VerificationMeta _photoPathMeta = const VerificationMeta(
    'photoPath',
  );
  @override
  late final GeneratedColumn<String> photoPath = GeneratedColumn<String>(
    'photo_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _templateIdMeta = const VerificationMeta(
    'templateId',
  );
  @override
  late final GeneratedColumn<String> templateId = GeneratedColumn<String>(
    'template_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    timestamp,
    mealType,
    photoPath,
    note,
    templateId,
    createdAt,
    updatedAt,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'meals';
  @override
  VerificationContext validateIntegrity(
    Insertable<Meal> instance, {
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
    if (data.containsKey('photo_path')) {
      context.handle(
        _photoPathMeta,
        photoPath.isAcceptableOrUnknown(data['photo_path']!, _photoPathMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('template_id')) {
      context.handle(
        _templateIdMeta,
        templateId.isAcceptableOrUnknown(data['template_id']!, _templateIdMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Meal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Meal(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
      mealType: $MealsTable.$convertermealType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}meal_type'],
        )!,
      ),
      photoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_path'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      templateId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}template_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $MealsTable createAlias(String alias) {
    return $MealsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<MealType, int, int> $convertermealType =
      const EnumIndexConverter<MealType>(MealType.values);
}

class Meal extends DataClass implements Insertable<Meal> {
  final String id;
  final DateTime timestamp;
  final MealType mealType;
  final String? photoPath;
  final String? note;
  final String? templateId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  const Meal({
    required this.id,
    required this.timestamp,
    required this.mealType,
    this.photoPath,
    this.note,
    this.templateId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['timestamp'] = Variable<DateTime>(timestamp);
    {
      map['meal_type'] = Variable<int>(
        $MealsTable.$convertermealType.toSql(mealType),
      );
    }
    if (!nullToAbsent || photoPath != null) {
      map['photo_path'] = Variable<String>(photoPath);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    if (!nullToAbsent || templateId != null) {
      map['template_id'] = Variable<String>(templateId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  MealsCompanion toCompanion(bool nullToAbsent) {
    return MealsCompanion(
      id: Value(id),
      timestamp: Value(timestamp),
      mealType: Value(mealType),
      photoPath: photoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(photoPath),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      templateId: templateId == null && nullToAbsent
          ? const Value.absent()
          : Value(templateId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory Meal.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Meal(
      id: serializer.fromJson<String>(json['id']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      mealType: $MealsTable.$convertermealType.fromJson(
        serializer.fromJson<int>(json['mealType']),
      ),
      photoPath: serializer.fromJson<String?>(json['photoPath']),
      note: serializer.fromJson<String?>(json['note']),
      templateId: serializer.fromJson<String?>(json['templateId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'mealType': serializer.toJson<int>(
        $MealsTable.$convertermealType.toJson(mealType),
      ),
      'photoPath': serializer.toJson<String?>(photoPath),
      'note': serializer.toJson<String?>(note),
      'templateId': serializer.toJson<String?>(templateId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  Meal copyWith({
    String? id,
    DateTime? timestamp,
    MealType? mealType,
    Value<String?> photoPath = const Value.absent(),
    Value<String?> note = const Value.absent(),
    Value<String?> templateId = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
  }) => Meal(
    id: id ?? this.id,
    timestamp: timestamp ?? this.timestamp,
    mealType: mealType ?? this.mealType,
    photoPath: photoPath.present ? photoPath.value : this.photoPath,
    note: note.present ? note.value : this.note,
    templateId: templateId.present ? templateId.value : this.templateId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  Meal copyWithCompanion(MealsCompanion data) {
    return Meal(
      id: data.id.present ? data.id.value : this.id,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      mealType: data.mealType.present ? data.mealType.value : this.mealType,
      photoPath: data.photoPath.present ? data.photoPath.value : this.photoPath,
      note: data.note.present ? data.note.value : this.note,
      templateId: data.templateId.present
          ? data.templateId.value
          : this.templateId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Meal(')
          ..write('id: $id, ')
          ..write('timestamp: $timestamp, ')
          ..write('mealType: $mealType, ')
          ..write('photoPath: $photoPath, ')
          ..write('note: $note, ')
          ..write('templateId: $templateId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    timestamp,
    mealType,
    photoPath,
    note,
    templateId,
    createdAt,
    updatedAt,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Meal &&
          other.id == this.id &&
          other.timestamp == this.timestamp &&
          other.mealType == this.mealType &&
          other.photoPath == this.photoPath &&
          other.note == this.note &&
          other.templateId == this.templateId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class MealsCompanion extends UpdateCompanion<Meal> {
  final Value<String> id;
  final Value<DateTime> timestamp;
  final Value<MealType> mealType;
  final Value<String?> photoPath;
  final Value<String?> note;
  final Value<String?> templateId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const MealsCompanion({
    this.id = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.mealType = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.note = const Value.absent(),
    this.templateId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MealsCompanion.insert({
    required String id,
    required DateTime timestamp,
    required MealType mealType,
    this.photoPath = const Value.absent(),
    this.note = const Value.absent(),
    this.templateId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       timestamp = Value(timestamp),
       mealType = Value(mealType);
  static Insertable<Meal> custom({
    Expression<String>? id,
    Expression<DateTime>? timestamp,
    Expression<int>? mealType,
    Expression<String>? photoPath,
    Expression<String>? note,
    Expression<String>? templateId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (timestamp != null) 'timestamp': timestamp,
      if (mealType != null) 'meal_type': mealType,
      if (photoPath != null) 'photo_path': photoPath,
      if (note != null) 'note': note,
      if (templateId != null) 'template_id': templateId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MealsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? timestamp,
    Value<MealType>? mealType,
    Value<String?>? photoPath,
    Value<String?>? note,
    Value<String?>? templateId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<int>? rowid,
  }) {
    return MealsCompanion(
      id: id ?? this.id,
      timestamp: timestamp ?? this.timestamp,
      mealType: mealType ?? this.mealType,
      photoPath: photoPath ?? this.photoPath,
      note: note ?? this.note,
      templateId: templateId ?? this.templateId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
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
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (mealType.present) {
      map['meal_type'] = Variable<int>(
        $MealsTable.$convertermealType.toSql(mealType.value),
      );
    }
    if (photoPath.present) {
      map['photo_path'] = Variable<String>(photoPath.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (templateId.present) {
      map['template_id'] = Variable<String>(templateId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MealsCompanion(')
          ..write('id: $id, ')
          ..write('timestamp: $timestamp, ')
          ..write('mealType: $mealType, ')
          ..write('photoPath: $photoPath, ')
          ..write('note: $note, ')
          ..write('templateId: $templateId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MealTagsTable extends MealTags with TableInfo<$MealTagsTable, MealTag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MealTagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _mealIdMeta = const VerificationMeta('mealId');
  @override
  late final GeneratedColumn<String> mealId = GeneratedColumn<String>(
    'meal_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tagIdMeta = const VerificationMeta('tagId');
  @override
  late final GeneratedColumn<String> tagId = GeneratedColumn<String>(
    'tag_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [mealId, tagId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'meal_tags';
  @override
  VerificationContext validateIntegrity(
    Insertable<MealTag> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('meal_id')) {
      context.handle(
        _mealIdMeta,
        mealId.isAcceptableOrUnknown(data['meal_id']!, _mealIdMeta),
      );
    } else if (isInserting) {
      context.missing(_mealIdMeta);
    }
    if (data.containsKey('tag_id')) {
      context.handle(
        _tagIdMeta,
        tagId.isAcceptableOrUnknown(data['tag_id']!, _tagIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tagIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {mealId, tagId};
  @override
  MealTag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MealTag(
      mealId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meal_id'],
      )!,
      tagId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tag_id'],
      )!,
    );
  }

  @override
  $MealTagsTable createAlias(String alias) {
    return $MealTagsTable(attachedDatabase, alias);
  }
}

class MealTag extends DataClass implements Insertable<MealTag> {
  final String mealId;
  final String tagId;
  const MealTag({required this.mealId, required this.tagId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['meal_id'] = Variable<String>(mealId);
    map['tag_id'] = Variable<String>(tagId);
    return map;
  }

  MealTagsCompanion toCompanion(bool nullToAbsent) {
    return MealTagsCompanion(mealId: Value(mealId), tagId: Value(tagId));
  }

  factory MealTag.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MealTag(
      mealId: serializer.fromJson<String>(json['mealId']),
      tagId: serializer.fromJson<String>(json['tagId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'mealId': serializer.toJson<String>(mealId),
      'tagId': serializer.toJson<String>(tagId),
    };
  }

  MealTag copyWith({String? mealId, String? tagId}) =>
      MealTag(mealId: mealId ?? this.mealId, tagId: tagId ?? this.tagId);
  MealTag copyWithCompanion(MealTagsCompanion data) {
    return MealTag(
      mealId: data.mealId.present ? data.mealId.value : this.mealId,
      tagId: data.tagId.present ? data.tagId.value : this.tagId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MealTag(')
          ..write('mealId: $mealId, ')
          ..write('tagId: $tagId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(mealId, tagId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MealTag &&
          other.mealId == this.mealId &&
          other.tagId == this.tagId);
}

class MealTagsCompanion extends UpdateCompanion<MealTag> {
  final Value<String> mealId;
  final Value<String> tagId;
  final Value<int> rowid;
  const MealTagsCompanion({
    this.mealId = const Value.absent(),
    this.tagId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MealTagsCompanion.insert({
    required String mealId,
    required String tagId,
    this.rowid = const Value.absent(),
  }) : mealId = Value(mealId),
       tagId = Value(tagId);
  static Insertable<MealTag> custom({
    Expression<String>? mealId,
    Expression<String>? tagId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (mealId != null) 'meal_id': mealId,
      if (tagId != null) 'tag_id': tagId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MealTagsCompanion copyWith({
    Value<String>? mealId,
    Value<String>? tagId,
    Value<int>? rowid,
  }) {
    return MealTagsCompanion(
      mealId: mealId ?? this.mealId,
      tagId: tagId ?? this.tagId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (mealId.present) {
      map['meal_id'] = Variable<String>(mealId.value);
    }
    if (tagId.present) {
      map['tag_id'] = Variable<String>(tagId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MealTagsCompanion(')
          ..write('mealId: $mealId, ')
          ..write('tagId: $tagId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MealTemplatesTable extends MealTemplates
    with TableInfo<$MealTemplatesTable, MealTemplate> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MealTemplatesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _defaultPhotoPathMeta = const VerificationMeta(
    'defaultPhotoPath',
  );
  @override
  late final GeneratedColumn<String> defaultPhotoPath = GeneratedColumn<String>(
    'default_photo_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _defaultMealTypeMeta = const VerificationMeta(
    'defaultMealType',
  );
  @override
  late final GeneratedColumn<String> defaultMealType = GeneratedColumn<String>(
    'default_meal_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    defaultPhotoPath,
    defaultMealType,
    createdAt,
    updatedAt,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'meal_templates';
  @override
  VerificationContext validateIntegrity(
    Insertable<MealTemplate> instance, {
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
    if (data.containsKey('default_photo_path')) {
      context.handle(
        _defaultPhotoPathMeta,
        defaultPhotoPath.isAcceptableOrUnknown(
          data['default_photo_path']!,
          _defaultPhotoPathMeta,
        ),
      );
    }
    if (data.containsKey('default_meal_type')) {
      context.handle(
        _defaultMealTypeMeta,
        defaultMealType.isAcceptableOrUnknown(
          data['default_meal_type']!,
          _defaultMealTypeMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MealTemplate map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MealTemplate(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      defaultPhotoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_photo_path'],
      ),
      defaultMealType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_meal_type'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $MealTemplatesTable createAlias(String alias) {
    return $MealTemplatesTable(attachedDatabase, alias);
  }
}

class MealTemplate extends DataClass implements Insertable<MealTemplate> {
  final String id;
  final String name;
  final String? defaultPhotoPath;
  final String? defaultMealType;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  const MealTemplate({
    required this.id,
    required this.name,
    this.defaultPhotoPath,
    this.defaultMealType,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || defaultPhotoPath != null) {
      map['default_photo_path'] = Variable<String>(defaultPhotoPath);
    }
    if (!nullToAbsent || defaultMealType != null) {
      map['default_meal_type'] = Variable<String>(defaultMealType);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  MealTemplatesCompanion toCompanion(bool nullToAbsent) {
    return MealTemplatesCompanion(
      id: Value(id),
      name: Value(name),
      defaultPhotoPath: defaultPhotoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultPhotoPath),
      defaultMealType: defaultMealType == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultMealType),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory MealTemplate.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MealTemplate(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      defaultPhotoPath: serializer.fromJson<String?>(json['defaultPhotoPath']),
      defaultMealType: serializer.fromJson<String?>(json['defaultMealType']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'defaultPhotoPath': serializer.toJson<String?>(defaultPhotoPath),
      'defaultMealType': serializer.toJson<String?>(defaultMealType),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  MealTemplate copyWith({
    String? id,
    String? name,
    Value<String?> defaultPhotoPath = const Value.absent(),
    Value<String?> defaultMealType = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
  }) => MealTemplate(
    id: id ?? this.id,
    name: name ?? this.name,
    defaultPhotoPath: defaultPhotoPath.present
        ? defaultPhotoPath.value
        : this.defaultPhotoPath,
    defaultMealType: defaultMealType.present
        ? defaultMealType.value
        : this.defaultMealType,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  MealTemplate copyWithCompanion(MealTemplatesCompanion data) {
    return MealTemplate(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      defaultPhotoPath: data.defaultPhotoPath.present
          ? data.defaultPhotoPath.value
          : this.defaultPhotoPath,
      defaultMealType: data.defaultMealType.present
          ? data.defaultMealType.value
          : this.defaultMealType,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MealTemplate(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('defaultPhotoPath: $defaultPhotoPath, ')
          ..write('defaultMealType: $defaultMealType, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    defaultPhotoPath,
    defaultMealType,
    createdAt,
    updatedAt,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MealTemplate &&
          other.id == this.id &&
          other.name == this.name &&
          other.defaultPhotoPath == this.defaultPhotoPath &&
          other.defaultMealType == this.defaultMealType &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class MealTemplatesCompanion extends UpdateCompanion<MealTemplate> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> defaultPhotoPath;
  final Value<String?> defaultMealType;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const MealTemplatesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.defaultPhotoPath = const Value.absent(),
    this.defaultMealType = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MealTemplatesCompanion.insert({
    required String id,
    required String name,
    this.defaultPhotoPath = const Value.absent(),
    this.defaultMealType = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name);
  static Insertable<MealTemplate> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? defaultPhotoPath,
    Expression<String>? defaultMealType,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (defaultPhotoPath != null) 'default_photo_path': defaultPhotoPath,
      if (defaultMealType != null) 'default_meal_type': defaultMealType,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MealTemplatesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? defaultPhotoPath,
    Value<String?>? defaultMealType,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<int>? rowid,
  }) {
    return MealTemplatesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      defaultPhotoPath: defaultPhotoPath ?? this.defaultPhotoPath,
      defaultMealType: defaultMealType ?? this.defaultMealType,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
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
    if (defaultPhotoPath.present) {
      map['default_photo_path'] = Variable<String>(defaultPhotoPath.value);
    }
    if (defaultMealType.present) {
      map['default_meal_type'] = Variable<String>(defaultMealType.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MealTemplatesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('defaultPhotoPath: $defaultPhotoPath, ')
          ..write('defaultMealType: $defaultMealType, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TemplateTagsTable extends TemplateTags
    with TableInfo<$TemplateTagsTable, TemplateTag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TemplateTagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _templateIdMeta = const VerificationMeta(
    'templateId',
  );
  @override
  late final GeneratedColumn<String> templateId = GeneratedColumn<String>(
    'template_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tagIdMeta = const VerificationMeta('tagId');
  @override
  late final GeneratedColumn<String> tagId = GeneratedColumn<String>(
    'tag_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [templateId, tagId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'template_tags';
  @override
  VerificationContext validateIntegrity(
    Insertable<TemplateTag> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('template_id')) {
      context.handle(
        _templateIdMeta,
        templateId.isAcceptableOrUnknown(data['template_id']!, _templateIdMeta),
      );
    } else if (isInserting) {
      context.missing(_templateIdMeta);
    }
    if (data.containsKey('tag_id')) {
      context.handle(
        _tagIdMeta,
        tagId.isAcceptableOrUnknown(data['tag_id']!, _tagIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tagIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {templateId, tagId};
  @override
  TemplateTag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TemplateTag(
      templateId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}template_id'],
      )!,
      tagId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tag_id'],
      )!,
    );
  }

  @override
  $TemplateTagsTable createAlias(String alias) {
    return $TemplateTagsTable(attachedDatabase, alias);
  }
}

class TemplateTag extends DataClass implements Insertable<TemplateTag> {
  final String templateId;
  final String tagId;
  const TemplateTag({required this.templateId, required this.tagId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['template_id'] = Variable<String>(templateId);
    map['tag_id'] = Variable<String>(tagId);
    return map;
  }

  TemplateTagsCompanion toCompanion(bool nullToAbsent) {
    return TemplateTagsCompanion(
      templateId: Value(templateId),
      tagId: Value(tagId),
    );
  }

  factory TemplateTag.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TemplateTag(
      templateId: serializer.fromJson<String>(json['templateId']),
      tagId: serializer.fromJson<String>(json['tagId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'templateId': serializer.toJson<String>(templateId),
      'tagId': serializer.toJson<String>(tagId),
    };
  }

  TemplateTag copyWith({String? templateId, String? tagId}) => TemplateTag(
    templateId: templateId ?? this.templateId,
    tagId: tagId ?? this.tagId,
  );
  TemplateTag copyWithCompanion(TemplateTagsCompanion data) {
    return TemplateTag(
      templateId: data.templateId.present
          ? data.templateId.value
          : this.templateId,
      tagId: data.tagId.present ? data.tagId.value : this.tagId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TemplateTag(')
          ..write('templateId: $templateId, ')
          ..write('tagId: $tagId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(templateId, tagId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TemplateTag &&
          other.templateId == this.templateId &&
          other.tagId == this.tagId);
}

class TemplateTagsCompanion extends UpdateCompanion<TemplateTag> {
  final Value<String> templateId;
  final Value<String> tagId;
  final Value<int> rowid;
  const TemplateTagsCompanion({
    this.templateId = const Value.absent(),
    this.tagId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TemplateTagsCompanion.insert({
    required String templateId,
    required String tagId,
    this.rowid = const Value.absent(),
  }) : templateId = Value(templateId),
       tagId = Value(tagId);
  static Insertable<TemplateTag> custom({
    Expression<String>? templateId,
    Expression<String>? tagId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (templateId != null) 'template_id': templateId,
      if (tagId != null) 'tag_id': tagId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TemplateTagsCompanion copyWith({
    Value<String>? templateId,
    Value<String>? tagId,
    Value<int>? rowid,
  }) {
    return TemplateTagsCompanion(
      templateId: templateId ?? this.templateId,
      tagId: tagId ?? this.tagId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (templateId.present) {
      map['template_id'] = Variable<String>(templateId.value);
    }
    if (tagId.present) {
      map['tag_id'] = Variable<String>(tagId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TemplateTagsCompanion(')
          ..write('templateId: $templateId, ')
          ..write('tagId: $tagId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SymptomsTable extends Symptoms with TableInfo<$SymptomsTable, Symptom> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SymptomsTable(this.attachedDatabase, [this._alias]);
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
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SymptomType, int> type =
      GeneratedColumn<int>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<SymptomType>($SymptomsTable.$convertertype);
  static const VerificationMeta _intensityMeta = const VerificationMeta(
    'intensity',
  );
  @override
  late final GeneratedColumn<int> intensity = GeneratedColumn<int>(
    'intensity',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _detailMeta = const VerificationMeta('detail');
  @override
  late final GeneratedColumn<String> detail = GeneratedColumn<String>(
    'detail',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _endTimeMeta = const VerificationMeta(
    'endTime',
  );
  @override
  late final GeneratedColumn<DateTime> endTime = GeneratedColumn<DateTime>(
    'end_time',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<MigraineStartPrecision?, int>
  startPrecision =
      GeneratedColumn<int>(
        'start_precision',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      ).withConverter<MigraineStartPrecision?>(
        $SymptomsTable.$converterstartPrecisionn,
      );
  static const VerificationMeta _endedAtMeta = const VerificationMeta(
    'endedAt',
  );
  @override
  late final GeneratedColumn<DateTime> endedAt = GeneratedColumn<DateTime>(
    'ended_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _initialIntensityMeta = const VerificationMeta(
    'initialIntensity',
  );
  @override
  late final GeneratedColumn<int> initialIntensity = GeneratedColumn<int>(
    'initial_intensity',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _maximumIntensityMeta = const VerificationMeta(
    'maximumIntensity',
  );
  @override
  late final GeneratedColumn<int> maximumIntensity = GeneratedColumn<int>(
    'maximum_intensity',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dailyDateMeta = const VerificationMeta(
    'dailyDate',
  );
  @override
  late final GeneratedColumn<DateTime> dailyDate = GeneratedColumn<DateTime>(
    'daily_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isDailyNoteMeta = const VerificationMeta(
    'isDailyNote',
  );
  @override
  late final GeneratedColumn<bool> isDailyNote = GeneratedColumn<bool>(
    'is_daily_note',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_daily_note" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    timestamp,
    type,
    intensity,
    detail,
    endTime,
    startedAt,
    startPrecision,
    endedAt,
    initialIntensity,
    maximumIntensity,
    note,
    dailyDate,
    isDailyNote,
    createdAt,
    updatedAt,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'symptoms';
  @override
  VerificationContext validateIntegrity(
    Insertable<Symptom> instance, {
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
    if (data.containsKey('intensity')) {
      context.handle(
        _intensityMeta,
        intensity.isAcceptableOrUnknown(data['intensity']!, _intensityMeta),
      );
    }
    if (data.containsKey('detail')) {
      context.handle(
        _detailMeta,
        detail.isAcceptableOrUnknown(data['detail']!, _detailMeta),
      );
    }
    if (data.containsKey('end_time')) {
      context.handle(
        _endTimeMeta,
        endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta),
      );
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    }
    if (data.containsKey('ended_at')) {
      context.handle(
        _endedAtMeta,
        endedAt.isAcceptableOrUnknown(data['ended_at']!, _endedAtMeta),
      );
    }
    if (data.containsKey('initial_intensity')) {
      context.handle(
        _initialIntensityMeta,
        initialIntensity.isAcceptableOrUnknown(
          data['initial_intensity']!,
          _initialIntensityMeta,
        ),
      );
    }
    if (data.containsKey('maximum_intensity')) {
      context.handle(
        _maximumIntensityMeta,
        maximumIntensity.isAcceptableOrUnknown(
          data['maximum_intensity']!,
          _maximumIntensityMeta,
        ),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('daily_date')) {
      context.handle(
        _dailyDateMeta,
        dailyDate.isAcceptableOrUnknown(data['daily_date']!, _dailyDateMeta),
      );
    }
    if (data.containsKey('is_daily_note')) {
      context.handle(
        _isDailyNoteMeta,
        isDailyNote.isAcceptableOrUnknown(
          data['is_daily_note']!,
          _isDailyNoteMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Symptom map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Symptom(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
      type: $SymptomsTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}type'],
        )!,
      ),
      intensity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}intensity'],
      ),
      detail: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}detail'],
      ),
      endTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_time'],
      ),
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      ),
      startPrecision: $SymptomsTable.$converterstartPrecisionn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}start_precision'],
        ),
      ),
      endedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ended_at'],
      ),
      initialIntensity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}initial_intensity'],
      ),
      maximumIntensity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}maximum_intensity'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      dailyDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}daily_date'],
      ),
      isDailyNote: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_daily_note'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $SymptomsTable createAlias(String alias) {
    return $SymptomsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<SymptomType, int, int> $convertertype =
      const EnumIndexConverter<SymptomType>(SymptomType.values);
  static JsonTypeConverter2<MigraineStartPrecision, int, int>
  $converterstartPrecision = const EnumIndexConverter<MigraineStartPrecision>(
    MigraineStartPrecision.values,
  );
  static JsonTypeConverter2<MigraineStartPrecision?, int?, int?>
  $converterstartPrecisionn = JsonTypeConverter2.asNullable(
    $converterstartPrecision,
  );
}

class Symptom extends DataClass implements Insertable<Symptom> {
  final String id;
  final DateTime timestamp;
  final SymptomType type;
  final int? intensity;
  final String? detail;
  final DateTime? endTime;
  final DateTime? startedAt;
  final MigraineStartPrecision? startPrecision;
  final DateTime? endedAt;
  final int? initialIntensity;
  final int? maximumIntensity;
  final String? note;
  final DateTime? dailyDate;
  final bool isDailyNote;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  const Symptom({
    required this.id,
    required this.timestamp,
    required this.type,
    this.intensity,
    this.detail,
    this.endTime,
    this.startedAt,
    this.startPrecision,
    this.endedAt,
    this.initialIntensity,
    this.maximumIntensity,
    this.note,
    this.dailyDate,
    required this.isDailyNote,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['timestamp'] = Variable<DateTime>(timestamp);
    {
      map['type'] = Variable<int>($SymptomsTable.$convertertype.toSql(type));
    }
    if (!nullToAbsent || intensity != null) {
      map['intensity'] = Variable<int>(intensity);
    }
    if (!nullToAbsent || detail != null) {
      map['detail'] = Variable<String>(detail);
    }
    if (!nullToAbsent || endTime != null) {
      map['end_time'] = Variable<DateTime>(endTime);
    }
    if (!nullToAbsent || startedAt != null) {
      map['started_at'] = Variable<DateTime>(startedAt);
    }
    if (!nullToAbsent || startPrecision != null) {
      map['start_precision'] = Variable<int>(
        $SymptomsTable.$converterstartPrecisionn.toSql(startPrecision),
      );
    }
    if (!nullToAbsent || endedAt != null) {
      map['ended_at'] = Variable<DateTime>(endedAt);
    }
    if (!nullToAbsent || initialIntensity != null) {
      map['initial_intensity'] = Variable<int>(initialIntensity);
    }
    if (!nullToAbsent || maximumIntensity != null) {
      map['maximum_intensity'] = Variable<int>(maximumIntensity);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    if (!nullToAbsent || dailyDate != null) {
      map['daily_date'] = Variable<DateTime>(dailyDate);
    }
    map['is_daily_note'] = Variable<bool>(isDailyNote);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  SymptomsCompanion toCompanion(bool nullToAbsent) {
    return SymptomsCompanion(
      id: Value(id),
      timestamp: Value(timestamp),
      type: Value(type),
      intensity: intensity == null && nullToAbsent
          ? const Value.absent()
          : Value(intensity),
      detail: detail == null && nullToAbsent
          ? const Value.absent()
          : Value(detail),
      endTime: endTime == null && nullToAbsent
          ? const Value.absent()
          : Value(endTime),
      startedAt: startedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(startedAt),
      startPrecision: startPrecision == null && nullToAbsent
          ? const Value.absent()
          : Value(startPrecision),
      endedAt: endedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(endedAt),
      initialIntensity: initialIntensity == null && nullToAbsent
          ? const Value.absent()
          : Value(initialIntensity),
      maximumIntensity: maximumIntensity == null && nullToAbsent
          ? const Value.absent()
          : Value(maximumIntensity),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      dailyDate: dailyDate == null && nullToAbsent
          ? const Value.absent()
          : Value(dailyDate),
      isDailyNote: Value(isDailyNote),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory Symptom.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Symptom(
      id: serializer.fromJson<String>(json['id']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      type: $SymptomsTable.$convertertype.fromJson(
        serializer.fromJson<int>(json['type']),
      ),
      intensity: serializer.fromJson<int?>(json['intensity']),
      detail: serializer.fromJson<String?>(json['detail']),
      endTime: serializer.fromJson<DateTime?>(json['endTime']),
      startedAt: serializer.fromJson<DateTime?>(json['startedAt']),
      startPrecision: $SymptomsTable.$converterstartPrecisionn.fromJson(
        serializer.fromJson<int?>(json['startPrecision']),
      ),
      endedAt: serializer.fromJson<DateTime?>(json['endedAt']),
      initialIntensity: serializer.fromJson<int?>(json['initialIntensity']),
      maximumIntensity: serializer.fromJson<int?>(json['maximumIntensity']),
      note: serializer.fromJson<String?>(json['note']),
      dailyDate: serializer.fromJson<DateTime?>(json['dailyDate']),
      isDailyNote: serializer.fromJson<bool>(json['isDailyNote']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'type': serializer.toJson<int>(
        $SymptomsTable.$convertertype.toJson(type),
      ),
      'intensity': serializer.toJson<int?>(intensity),
      'detail': serializer.toJson<String?>(detail),
      'endTime': serializer.toJson<DateTime?>(endTime),
      'startedAt': serializer.toJson<DateTime?>(startedAt),
      'startPrecision': serializer.toJson<int?>(
        $SymptomsTable.$converterstartPrecisionn.toJson(startPrecision),
      ),
      'endedAt': serializer.toJson<DateTime?>(endedAt),
      'initialIntensity': serializer.toJson<int?>(initialIntensity),
      'maximumIntensity': serializer.toJson<int?>(maximumIntensity),
      'note': serializer.toJson<String?>(note),
      'dailyDate': serializer.toJson<DateTime?>(dailyDate),
      'isDailyNote': serializer.toJson<bool>(isDailyNote),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  Symptom copyWith({
    String? id,
    DateTime? timestamp,
    SymptomType? type,
    Value<int?> intensity = const Value.absent(),
    Value<String?> detail = const Value.absent(),
    Value<DateTime?> endTime = const Value.absent(),
    Value<DateTime?> startedAt = const Value.absent(),
    Value<MigraineStartPrecision?> startPrecision = const Value.absent(),
    Value<DateTime?> endedAt = const Value.absent(),
    Value<int?> initialIntensity = const Value.absent(),
    Value<int?> maximumIntensity = const Value.absent(),
    Value<String?> note = const Value.absent(),
    Value<DateTime?> dailyDate = const Value.absent(),
    bool? isDailyNote,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
  }) => Symptom(
    id: id ?? this.id,
    timestamp: timestamp ?? this.timestamp,
    type: type ?? this.type,
    intensity: intensity.present ? intensity.value : this.intensity,
    detail: detail.present ? detail.value : this.detail,
    endTime: endTime.present ? endTime.value : this.endTime,
    startedAt: startedAt.present ? startedAt.value : this.startedAt,
    startPrecision: startPrecision.present
        ? startPrecision.value
        : this.startPrecision,
    endedAt: endedAt.present ? endedAt.value : this.endedAt,
    initialIntensity: initialIntensity.present
        ? initialIntensity.value
        : this.initialIntensity,
    maximumIntensity: maximumIntensity.present
        ? maximumIntensity.value
        : this.maximumIntensity,
    note: note.present ? note.value : this.note,
    dailyDate: dailyDate.present ? dailyDate.value : this.dailyDate,
    isDailyNote: isDailyNote ?? this.isDailyNote,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  Symptom copyWithCompanion(SymptomsCompanion data) {
    return Symptom(
      id: data.id.present ? data.id.value : this.id,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      type: data.type.present ? data.type.value : this.type,
      intensity: data.intensity.present ? data.intensity.value : this.intensity,
      detail: data.detail.present ? data.detail.value : this.detail,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      startPrecision: data.startPrecision.present
          ? data.startPrecision.value
          : this.startPrecision,
      endedAt: data.endedAt.present ? data.endedAt.value : this.endedAt,
      initialIntensity: data.initialIntensity.present
          ? data.initialIntensity.value
          : this.initialIntensity,
      maximumIntensity: data.maximumIntensity.present
          ? data.maximumIntensity.value
          : this.maximumIntensity,
      note: data.note.present ? data.note.value : this.note,
      dailyDate: data.dailyDate.present ? data.dailyDate.value : this.dailyDate,
      isDailyNote: data.isDailyNote.present
          ? data.isDailyNote.value
          : this.isDailyNote,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Symptom(')
          ..write('id: $id, ')
          ..write('timestamp: $timestamp, ')
          ..write('type: $type, ')
          ..write('intensity: $intensity, ')
          ..write('detail: $detail, ')
          ..write('endTime: $endTime, ')
          ..write('startedAt: $startedAt, ')
          ..write('startPrecision: $startPrecision, ')
          ..write('endedAt: $endedAt, ')
          ..write('initialIntensity: $initialIntensity, ')
          ..write('maximumIntensity: $maximumIntensity, ')
          ..write('note: $note, ')
          ..write('dailyDate: $dailyDate, ')
          ..write('isDailyNote: $isDailyNote, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    timestamp,
    type,
    intensity,
    detail,
    endTime,
    startedAt,
    startPrecision,
    endedAt,
    initialIntensity,
    maximumIntensity,
    note,
    dailyDate,
    isDailyNote,
    createdAt,
    updatedAt,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Symptom &&
          other.id == this.id &&
          other.timestamp == this.timestamp &&
          other.type == this.type &&
          other.intensity == this.intensity &&
          other.detail == this.detail &&
          other.endTime == this.endTime &&
          other.startedAt == this.startedAt &&
          other.startPrecision == this.startPrecision &&
          other.endedAt == this.endedAt &&
          other.initialIntensity == this.initialIntensity &&
          other.maximumIntensity == this.maximumIntensity &&
          other.note == this.note &&
          other.dailyDate == this.dailyDate &&
          other.isDailyNote == this.isDailyNote &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class SymptomsCompanion extends UpdateCompanion<Symptom> {
  final Value<String> id;
  final Value<DateTime> timestamp;
  final Value<SymptomType> type;
  final Value<int?> intensity;
  final Value<String?> detail;
  final Value<DateTime?> endTime;
  final Value<DateTime?> startedAt;
  final Value<MigraineStartPrecision?> startPrecision;
  final Value<DateTime?> endedAt;
  final Value<int?> initialIntensity;
  final Value<int?> maximumIntensity;
  final Value<String?> note;
  final Value<DateTime?> dailyDate;
  final Value<bool> isDailyNote;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const SymptomsCompanion({
    this.id = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.type = const Value.absent(),
    this.intensity = const Value.absent(),
    this.detail = const Value.absent(),
    this.endTime = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.startPrecision = const Value.absent(),
    this.endedAt = const Value.absent(),
    this.initialIntensity = const Value.absent(),
    this.maximumIntensity = const Value.absent(),
    this.note = const Value.absent(),
    this.dailyDate = const Value.absent(),
    this.isDailyNote = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SymptomsCompanion.insert({
    required String id,
    required DateTime timestamp,
    required SymptomType type,
    this.intensity = const Value.absent(),
    this.detail = const Value.absent(),
    this.endTime = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.startPrecision = const Value.absent(),
    this.endedAt = const Value.absent(),
    this.initialIntensity = const Value.absent(),
    this.maximumIntensity = const Value.absent(),
    this.note = const Value.absent(),
    this.dailyDate = const Value.absent(),
    this.isDailyNote = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       timestamp = Value(timestamp),
       type = Value(type);
  static Insertable<Symptom> custom({
    Expression<String>? id,
    Expression<DateTime>? timestamp,
    Expression<int>? type,
    Expression<int>? intensity,
    Expression<String>? detail,
    Expression<DateTime>? endTime,
    Expression<DateTime>? startedAt,
    Expression<int>? startPrecision,
    Expression<DateTime>? endedAt,
    Expression<int>? initialIntensity,
    Expression<int>? maximumIntensity,
    Expression<String>? note,
    Expression<DateTime>? dailyDate,
    Expression<bool>? isDailyNote,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (timestamp != null) 'timestamp': timestamp,
      if (type != null) 'type': type,
      if (intensity != null) 'intensity': intensity,
      if (detail != null) 'detail': detail,
      if (endTime != null) 'end_time': endTime,
      if (startedAt != null) 'started_at': startedAt,
      if (startPrecision != null) 'start_precision': startPrecision,
      if (endedAt != null) 'ended_at': endedAt,
      if (initialIntensity != null) 'initial_intensity': initialIntensity,
      if (maximumIntensity != null) 'maximum_intensity': maximumIntensity,
      if (note != null) 'note': note,
      if (dailyDate != null) 'daily_date': dailyDate,
      if (isDailyNote != null) 'is_daily_note': isDailyNote,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SymptomsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? timestamp,
    Value<SymptomType>? type,
    Value<int?>? intensity,
    Value<String?>? detail,
    Value<DateTime?>? endTime,
    Value<DateTime?>? startedAt,
    Value<MigraineStartPrecision?>? startPrecision,
    Value<DateTime?>? endedAt,
    Value<int?>? initialIntensity,
    Value<int?>? maximumIntensity,
    Value<String?>? note,
    Value<DateTime?>? dailyDate,
    Value<bool>? isDailyNote,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<int>? rowid,
  }) {
    return SymptomsCompanion(
      id: id ?? this.id,
      timestamp: timestamp ?? this.timestamp,
      type: type ?? this.type,
      intensity: intensity ?? this.intensity,
      detail: detail ?? this.detail,
      endTime: endTime ?? this.endTime,
      startedAt: startedAt ?? this.startedAt,
      startPrecision: startPrecision ?? this.startPrecision,
      endedAt: endedAt ?? this.endedAt,
      initialIntensity: initialIntensity ?? this.initialIntensity,
      maximumIntensity: maximumIntensity ?? this.maximumIntensity,
      note: note ?? this.note,
      dailyDate: dailyDate ?? this.dailyDate,
      isDailyNote: isDailyNote ?? this.isDailyNote,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
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
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(
        $SymptomsTable.$convertertype.toSql(type.value),
      );
    }
    if (intensity.present) {
      map['intensity'] = Variable<int>(intensity.value);
    }
    if (detail.present) {
      map['detail'] = Variable<String>(detail.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<DateTime>(endTime.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (startPrecision.present) {
      map['start_precision'] = Variable<int>(
        $SymptomsTable.$converterstartPrecisionn.toSql(startPrecision.value),
      );
    }
    if (endedAt.present) {
      map['ended_at'] = Variable<DateTime>(endedAt.value);
    }
    if (initialIntensity.present) {
      map['initial_intensity'] = Variable<int>(initialIntensity.value);
    }
    if (maximumIntensity.present) {
      map['maximum_intensity'] = Variable<int>(maximumIntensity.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (dailyDate.present) {
      map['daily_date'] = Variable<DateTime>(dailyDate.value);
    }
    if (isDailyNote.present) {
      map['is_daily_note'] = Variable<bool>(isDailyNote.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SymptomsCompanion(')
          ..write('id: $id, ')
          ..write('timestamp: $timestamp, ')
          ..write('type: $type, ')
          ..write('intensity: $intensity, ')
          ..write('detail: $detail, ')
          ..write('endTime: $endTime, ')
          ..write('startedAt: $startedAt, ')
          ..write('startPrecision: $startPrecision, ')
          ..write('endedAt: $endedAt, ')
          ..write('initialIntensity: $initialIntensity, ')
          ..write('maximumIntensity: $maximumIntensity, ')
          ..write('note: $note, ')
          ..write('dailyDate: $dailyDate, ')
          ..write('isDailyNote: $isDailyNote, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MigraineIntensityMeasurementsTable extends MigraineIntensityMeasurements
    with
        TableInfo<
          $MigraineIntensityMeasurementsTable,
          MigraineIntensityMeasurement
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MigraineIntensityMeasurementsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _symptomIdMeta = const VerificationMeta(
    'symptomId',
  );
  @override
  late final GeneratedColumn<String> symptomId = GeneratedColumn<String>(
    'symptom_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES symptoms (id)',
    ),
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _intensityMeta = const VerificationMeta(
    'intensity',
  );
  @override
  late final GeneratedColumn<int> intensity = GeneratedColumn<int>(
    'intensity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<MigraineLaterality?, int>
  laterality =
      GeneratedColumn<int>(
        'laterality',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      ).withConverter<MigraineLaterality?>(
        $MigraineIntensityMeasurementsTable.$converterlateralityn,
      );
  @override
  late final GeneratedColumnWithTypeConverter<MigraineLocation?, int> location =
      GeneratedColumn<int>(
        'location',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      ).withConverter<MigraineLocation?>(
        $MigraineIntensityMeasurementsTable.$converterlocationn,
      );
  static const VerificationMeta _auraMeta = const VerificationMeta('aura');
  @override
  late final GeneratedColumn<bool> aura = GeneratedColumn<bool>(
    'aura',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("aura" IN (0, 1))',
    ),
  );
  static const VerificationMeta _nauseaMeta = const VerificationMeta('nausea');
  @override
  late final GeneratedColumn<bool> nausea = GeneratedColumn<bool>(
    'nausea',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("nausea" IN (0, 1))',
    ),
  );
  static const VerificationMeta _photophobiaMeta = const VerificationMeta(
    'photophobia',
  );
  @override
  late final GeneratedColumn<bool> photophobia = GeneratedColumn<bool>(
    'photophobia',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("photophobia" IN (0, 1))',
    ),
  );
  static const VerificationMeta _phonophobiaMeta = const VerificationMeta(
    'phonophobia',
  );
  @override
  late final GeneratedColumn<bool> phonophobia = GeneratedColumn<bool>(
    'phonophobia',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("phonophobia" IN (0, 1))',
    ),
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    symptomId,
    timestamp,
    intensity,
    laterality,
    location,
    aura,
    nausea,
    photophobia,
    phonophobia,
    note,
    createdAt,
    updatedAt,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'migraine_intensity_measurements';
  @override
  VerificationContext validateIntegrity(
    Insertable<MigraineIntensityMeasurement> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('symptom_id')) {
      context.handle(
        _symptomIdMeta,
        symptomId.isAcceptableOrUnknown(data['symptom_id']!, _symptomIdMeta),
      );
    } else if (isInserting) {
      context.missing(_symptomIdMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('intensity')) {
      context.handle(
        _intensityMeta,
        intensity.isAcceptableOrUnknown(data['intensity']!, _intensityMeta),
      );
    } else if (isInserting) {
      context.missing(_intensityMeta);
    }
    if (data.containsKey('aura')) {
      context.handle(
        _auraMeta,
        aura.isAcceptableOrUnknown(data['aura']!, _auraMeta),
      );
    }
    if (data.containsKey('nausea')) {
      context.handle(
        _nauseaMeta,
        nausea.isAcceptableOrUnknown(data['nausea']!, _nauseaMeta),
      );
    }
    if (data.containsKey('photophobia')) {
      context.handle(
        _photophobiaMeta,
        photophobia.isAcceptableOrUnknown(
          data['photophobia']!,
          _photophobiaMeta,
        ),
      );
    }
    if (data.containsKey('phonophobia')) {
      context.handle(
        _phonophobiaMeta,
        phonophobia.isAcceptableOrUnknown(
          data['phonophobia']!,
          _phonophobiaMeta,
        ),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MigraineIntensityMeasurement map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MigraineIntensityMeasurement(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      symptomId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}symptom_id'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
      intensity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}intensity'],
      )!,
      laterality: $MigraineIntensityMeasurementsTable.$converterlateralityn
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.int,
              data['${effectivePrefix}laterality'],
            ),
          ),
      location: $MigraineIntensityMeasurementsTable.$converterlocationn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}location'],
        ),
      ),
      aura: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}aura'],
      ),
      nausea: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}nausea'],
      ),
      photophobia: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}photophobia'],
      ),
      phonophobia: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}phonophobia'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $MigraineIntensityMeasurementsTable createAlias(String alias) {
    return $MigraineIntensityMeasurementsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<MigraineLaterality, int, int> $converterlaterality =
      const EnumIndexConverter<MigraineLaterality>(MigraineLaterality.values);
  static JsonTypeConverter2<MigraineLaterality?, int?, int?>
  $converterlateralityn = JsonTypeConverter2.asNullable($converterlaterality);
  static JsonTypeConverter2<MigraineLocation, int, int> $converterlocation =
      const EnumIndexConverter<MigraineLocation>(MigraineLocation.values);
  static JsonTypeConverter2<MigraineLocation?, int?, int?> $converterlocationn =
      JsonTypeConverter2.asNullable($converterlocation);
}

class MigraineIntensityMeasurement extends DataClass
    implements Insertable<MigraineIntensityMeasurement> {
  final String id;
  final String symptomId;
  final DateTime timestamp;
  final int intensity;
  final MigraineLaterality? laterality;
  final MigraineLocation? location;
  final bool? aura;
  final bool? nausea;
  final bool? photophobia;
  final bool? phonophobia;
  final String? note;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  const MigraineIntensityMeasurement({
    required this.id,
    required this.symptomId,
    required this.timestamp,
    required this.intensity,
    this.laterality,
    this.location,
    this.aura,
    this.nausea,
    this.photophobia,
    this.phonophobia,
    this.note,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['symptom_id'] = Variable<String>(symptomId);
    map['timestamp'] = Variable<DateTime>(timestamp);
    map['intensity'] = Variable<int>(intensity);
    if (!nullToAbsent || laterality != null) {
      map['laterality'] = Variable<int>(
        $MigraineIntensityMeasurementsTable.$converterlateralityn.toSql(
          laterality,
        ),
      );
    }
    if (!nullToAbsent || location != null) {
      map['location'] = Variable<int>(
        $MigraineIntensityMeasurementsTable.$converterlocationn.toSql(location),
      );
    }
    if (!nullToAbsent || aura != null) {
      map['aura'] = Variable<bool>(aura);
    }
    if (!nullToAbsent || nausea != null) {
      map['nausea'] = Variable<bool>(nausea);
    }
    if (!nullToAbsent || photophobia != null) {
      map['photophobia'] = Variable<bool>(photophobia);
    }
    if (!nullToAbsent || phonophobia != null) {
      map['phonophobia'] = Variable<bool>(phonophobia);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  MigraineIntensityMeasurementsCompanion toCompanion(bool nullToAbsent) {
    return MigraineIntensityMeasurementsCompanion(
      id: Value(id),
      symptomId: Value(symptomId),
      timestamp: Value(timestamp),
      intensity: Value(intensity),
      laterality: laterality == null && nullToAbsent
          ? const Value.absent()
          : Value(laterality),
      location: location == null && nullToAbsent
          ? const Value.absent()
          : Value(location),
      aura: aura == null && nullToAbsent ? const Value.absent() : Value(aura),
      nausea: nausea == null && nullToAbsent
          ? const Value.absent()
          : Value(nausea),
      photophobia: photophobia == null && nullToAbsent
          ? const Value.absent()
          : Value(photophobia),
      phonophobia: phonophobia == null && nullToAbsent
          ? const Value.absent()
          : Value(phonophobia),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory MigraineIntensityMeasurement.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MigraineIntensityMeasurement(
      id: serializer.fromJson<String>(json['id']),
      symptomId: serializer.fromJson<String>(json['symptomId']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      intensity: serializer.fromJson<int>(json['intensity']),
      laterality: $MigraineIntensityMeasurementsTable.$converterlateralityn
          .fromJson(serializer.fromJson<int?>(json['laterality'])),
      location: $MigraineIntensityMeasurementsTable.$converterlocationn
          .fromJson(serializer.fromJson<int?>(json['location'])),
      aura: serializer.fromJson<bool?>(json['aura']),
      nausea: serializer.fromJson<bool?>(json['nausea']),
      photophobia: serializer.fromJson<bool?>(json['photophobia']),
      phonophobia: serializer.fromJson<bool?>(json['phonophobia']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'symptomId': serializer.toJson<String>(symptomId),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'intensity': serializer.toJson<int>(intensity),
      'laterality': serializer.toJson<int?>(
        $MigraineIntensityMeasurementsTable.$converterlateralityn.toJson(
          laterality,
        ),
      ),
      'location': serializer.toJson<int?>(
        $MigraineIntensityMeasurementsTable.$converterlocationn.toJson(
          location,
        ),
      ),
      'aura': serializer.toJson<bool?>(aura),
      'nausea': serializer.toJson<bool?>(nausea),
      'photophobia': serializer.toJson<bool?>(photophobia),
      'phonophobia': serializer.toJson<bool?>(phonophobia),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  MigraineIntensityMeasurement copyWith({
    String? id,
    String? symptomId,
    DateTime? timestamp,
    int? intensity,
    Value<MigraineLaterality?> laterality = const Value.absent(),
    Value<MigraineLocation?> location = const Value.absent(),
    Value<bool?> aura = const Value.absent(),
    Value<bool?> nausea = const Value.absent(),
    Value<bool?> photophobia = const Value.absent(),
    Value<bool?> phonophobia = const Value.absent(),
    Value<String?> note = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
  }) => MigraineIntensityMeasurement(
    id: id ?? this.id,
    symptomId: symptomId ?? this.symptomId,
    timestamp: timestamp ?? this.timestamp,
    intensity: intensity ?? this.intensity,
    laterality: laterality.present ? laterality.value : this.laterality,
    location: location.present ? location.value : this.location,
    aura: aura.present ? aura.value : this.aura,
    nausea: nausea.present ? nausea.value : this.nausea,
    photophobia: photophobia.present ? photophobia.value : this.photophobia,
    phonophobia: phonophobia.present ? phonophobia.value : this.phonophobia,
    note: note.present ? note.value : this.note,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  MigraineIntensityMeasurement copyWithCompanion(
    MigraineIntensityMeasurementsCompanion data,
  ) {
    return MigraineIntensityMeasurement(
      id: data.id.present ? data.id.value : this.id,
      symptomId: data.symptomId.present ? data.symptomId.value : this.symptomId,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      intensity: data.intensity.present ? data.intensity.value : this.intensity,
      laterality: data.laterality.present
          ? data.laterality.value
          : this.laterality,
      location: data.location.present ? data.location.value : this.location,
      aura: data.aura.present ? data.aura.value : this.aura,
      nausea: data.nausea.present ? data.nausea.value : this.nausea,
      photophobia: data.photophobia.present
          ? data.photophobia.value
          : this.photophobia,
      phonophobia: data.phonophobia.present
          ? data.phonophobia.value
          : this.phonophobia,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MigraineIntensityMeasurement(')
          ..write('id: $id, ')
          ..write('symptomId: $symptomId, ')
          ..write('timestamp: $timestamp, ')
          ..write('intensity: $intensity, ')
          ..write('laterality: $laterality, ')
          ..write('location: $location, ')
          ..write('aura: $aura, ')
          ..write('nausea: $nausea, ')
          ..write('photophobia: $photophobia, ')
          ..write('phonophobia: $phonophobia, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    symptomId,
    timestamp,
    intensity,
    laterality,
    location,
    aura,
    nausea,
    photophobia,
    phonophobia,
    note,
    createdAt,
    updatedAt,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MigraineIntensityMeasurement &&
          other.id == this.id &&
          other.symptomId == this.symptomId &&
          other.timestamp == this.timestamp &&
          other.intensity == this.intensity &&
          other.laterality == this.laterality &&
          other.location == this.location &&
          other.aura == this.aura &&
          other.nausea == this.nausea &&
          other.photophobia == this.photophobia &&
          other.phonophobia == this.phonophobia &&
          other.note == this.note &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class MigraineIntensityMeasurementsCompanion
    extends UpdateCompanion<MigraineIntensityMeasurement> {
  final Value<String> id;
  final Value<String> symptomId;
  final Value<DateTime> timestamp;
  final Value<int> intensity;
  final Value<MigraineLaterality?> laterality;
  final Value<MigraineLocation?> location;
  final Value<bool?> aura;
  final Value<bool?> nausea;
  final Value<bool?> photophobia;
  final Value<bool?> phonophobia;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const MigraineIntensityMeasurementsCompanion({
    this.id = const Value.absent(),
    this.symptomId = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.intensity = const Value.absent(),
    this.laterality = const Value.absent(),
    this.location = const Value.absent(),
    this.aura = const Value.absent(),
    this.nausea = const Value.absent(),
    this.photophobia = const Value.absent(),
    this.phonophobia = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MigraineIntensityMeasurementsCompanion.insert({
    required String id,
    required String symptomId,
    required DateTime timestamp,
    required int intensity,
    this.laterality = const Value.absent(),
    this.location = const Value.absent(),
    this.aura = const Value.absent(),
    this.nausea = const Value.absent(),
    this.photophobia = const Value.absent(),
    this.phonophobia = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       symptomId = Value(symptomId),
       timestamp = Value(timestamp),
       intensity = Value(intensity);
  static Insertable<MigraineIntensityMeasurement> custom({
    Expression<String>? id,
    Expression<String>? symptomId,
    Expression<DateTime>? timestamp,
    Expression<int>? intensity,
    Expression<int>? laterality,
    Expression<int>? location,
    Expression<bool>? aura,
    Expression<bool>? nausea,
    Expression<bool>? photophobia,
    Expression<bool>? phonophobia,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (symptomId != null) 'symptom_id': symptomId,
      if (timestamp != null) 'timestamp': timestamp,
      if (intensity != null) 'intensity': intensity,
      if (laterality != null) 'laterality': laterality,
      if (location != null) 'location': location,
      if (aura != null) 'aura': aura,
      if (nausea != null) 'nausea': nausea,
      if (photophobia != null) 'photophobia': photophobia,
      if (phonophobia != null) 'phonophobia': phonophobia,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MigraineIntensityMeasurementsCompanion copyWith({
    Value<String>? id,
    Value<String>? symptomId,
    Value<DateTime>? timestamp,
    Value<int>? intensity,
    Value<MigraineLaterality?>? laterality,
    Value<MigraineLocation?>? location,
    Value<bool?>? aura,
    Value<bool?>? nausea,
    Value<bool?>? photophobia,
    Value<bool?>? phonophobia,
    Value<String?>? note,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<int>? rowid,
  }) {
    return MigraineIntensityMeasurementsCompanion(
      id: id ?? this.id,
      symptomId: symptomId ?? this.symptomId,
      timestamp: timestamp ?? this.timestamp,
      intensity: intensity ?? this.intensity,
      laterality: laterality ?? this.laterality,
      location: location ?? this.location,
      aura: aura ?? this.aura,
      nausea: nausea ?? this.nausea,
      photophobia: photophobia ?? this.photophobia,
      phonophobia: phonophobia ?? this.phonophobia,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (symptomId.present) {
      map['symptom_id'] = Variable<String>(symptomId.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (intensity.present) {
      map['intensity'] = Variable<int>(intensity.value);
    }
    if (laterality.present) {
      map['laterality'] = Variable<int>(
        $MigraineIntensityMeasurementsTable.$converterlateralityn.toSql(
          laterality.value,
        ),
      );
    }
    if (location.present) {
      map['location'] = Variable<int>(
        $MigraineIntensityMeasurementsTable.$converterlocationn.toSql(
          location.value,
        ),
      );
    }
    if (aura.present) {
      map['aura'] = Variable<bool>(aura.value);
    }
    if (nausea.present) {
      map['nausea'] = Variable<bool>(nausea.value);
    }
    if (photophobia.present) {
      map['photophobia'] = Variable<bool>(photophobia.value);
    }
    if (phonophobia.present) {
      map['phonophobia'] = Variable<bool>(phonophobia.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MigraineIntensityMeasurementsCompanion(')
          ..write('id: $id, ')
          ..write('symptomId: $symptomId, ')
          ..write('timestamp: $timestamp, ')
          ..write('intensity: $intensity, ')
          ..write('laterality: $laterality, ')
          ..write('location: $location, ')
          ..write('aura: $aura, ')
          ..write('nausea: $nausea, ')
          ..write('photophobia: $photophobia, ')
          ..write('phonophobia: $phonophobia, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MedicationIntakesTable extends MedicationIntakes
    with TableInfo<$MedicationIntakesTable, MedicationIntake> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MedicationIntakesTable(this.attachedDatabase, [this._alias]);
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
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
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
  static const VerificationMeta _doseMeta = const VerificationMeta('dose');
  @override
  late final GeneratedColumn<String> dose = GeneratedColumn<String>(
    'dose',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _symptomIdMeta = const VerificationMeta(
    'symptomId',
  );
  @override
  late final GeneratedColumn<String> symptomId = GeneratedColumn<String>(
    'symptom_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES symptoms (id)',
    ),
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    timestamp,
    name,
    dose,
    symptomId,
    note,
    createdAt,
    updatedAt,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'medication_intakes';
  @override
  VerificationContext validateIntegrity(
    Insertable<MedicationIntake> instance, {
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
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('dose')) {
      context.handle(
        _doseMeta,
        dose.isAcceptableOrUnknown(data['dose']!, _doseMeta),
      );
    }
    if (data.containsKey('symptom_id')) {
      context.handle(
        _symptomIdMeta,
        symptomId.isAcceptableOrUnknown(data['symptom_id']!, _symptomIdMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MedicationIntake map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MedicationIntake(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      dose: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dose'],
      ),
      symptomId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}symptom_id'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $MedicationIntakesTable createAlias(String alias) {
    return $MedicationIntakesTable(attachedDatabase, alias);
  }
}

class MedicationIntake extends DataClass
    implements Insertable<MedicationIntake> {
  final String id;
  final DateTime timestamp;
  final String name;
  final String? dose;
  final String? symptomId;
  final String? note;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  const MedicationIntake({
    required this.id,
    required this.timestamp,
    required this.name,
    this.dose,
    this.symptomId,
    this.note,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['timestamp'] = Variable<DateTime>(timestamp);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || dose != null) {
      map['dose'] = Variable<String>(dose);
    }
    if (!nullToAbsent || symptomId != null) {
      map['symptom_id'] = Variable<String>(symptomId);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  MedicationIntakesCompanion toCompanion(bool nullToAbsent) {
    return MedicationIntakesCompanion(
      id: Value(id),
      timestamp: Value(timestamp),
      name: Value(name),
      dose: dose == null && nullToAbsent ? const Value.absent() : Value(dose),
      symptomId: symptomId == null && nullToAbsent
          ? const Value.absent()
          : Value(symptomId),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory MedicationIntake.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MedicationIntake(
      id: serializer.fromJson<String>(json['id']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      name: serializer.fromJson<String>(json['name']),
      dose: serializer.fromJson<String?>(json['dose']),
      symptomId: serializer.fromJson<String?>(json['symptomId']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'name': serializer.toJson<String>(name),
      'dose': serializer.toJson<String?>(dose),
      'symptomId': serializer.toJson<String?>(symptomId),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  MedicationIntake copyWith({
    String? id,
    DateTime? timestamp,
    String? name,
    Value<String?> dose = const Value.absent(),
    Value<String?> symptomId = const Value.absent(),
    Value<String?> note = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
  }) => MedicationIntake(
    id: id ?? this.id,
    timestamp: timestamp ?? this.timestamp,
    name: name ?? this.name,
    dose: dose.present ? dose.value : this.dose,
    symptomId: symptomId.present ? symptomId.value : this.symptomId,
    note: note.present ? note.value : this.note,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  MedicationIntake copyWithCompanion(MedicationIntakesCompanion data) {
    return MedicationIntake(
      id: data.id.present ? data.id.value : this.id,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      name: data.name.present ? data.name.value : this.name,
      dose: data.dose.present ? data.dose.value : this.dose,
      symptomId: data.symptomId.present ? data.symptomId.value : this.symptomId,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MedicationIntake(')
          ..write('id: $id, ')
          ..write('timestamp: $timestamp, ')
          ..write('name: $name, ')
          ..write('dose: $dose, ')
          ..write('symptomId: $symptomId, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    timestamp,
    name,
    dose,
    symptomId,
    note,
    createdAt,
    updatedAt,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MedicationIntake &&
          other.id == this.id &&
          other.timestamp == this.timestamp &&
          other.name == this.name &&
          other.dose == this.dose &&
          other.symptomId == this.symptomId &&
          other.note == this.note &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class MedicationIntakesCompanion extends UpdateCompanion<MedicationIntake> {
  final Value<String> id;
  final Value<DateTime> timestamp;
  final Value<String> name;
  final Value<String?> dose;
  final Value<String?> symptomId;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const MedicationIntakesCompanion({
    this.id = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.name = const Value.absent(),
    this.dose = const Value.absent(),
    this.symptomId = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MedicationIntakesCompanion.insert({
    required String id,
    required DateTime timestamp,
    required String name,
    this.dose = const Value.absent(),
    this.symptomId = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       timestamp = Value(timestamp),
       name = Value(name);
  static Insertable<MedicationIntake> custom({
    Expression<String>? id,
    Expression<DateTime>? timestamp,
    Expression<String>? name,
    Expression<String>? dose,
    Expression<String>? symptomId,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (timestamp != null) 'timestamp': timestamp,
      if (name != null) 'name': name,
      if (dose != null) 'dose': dose,
      if (symptomId != null) 'symptom_id': symptomId,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MedicationIntakesCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? timestamp,
    Value<String>? name,
    Value<String?>? dose,
    Value<String?>? symptomId,
    Value<String?>? note,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<int>? rowid,
  }) {
    return MedicationIntakesCompanion(
      id: id ?? this.id,
      timestamp: timestamp ?? this.timestamp,
      name: name ?? this.name,
      dose: dose ?? this.dose,
      symptomId: symptomId ?? this.symptomId,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
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
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (dose.present) {
      map['dose'] = Variable<String>(dose.value);
    }
    if (symptomId.present) {
      map['symptom_id'] = Variable<String>(symptomId.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MedicationIntakesCompanion(')
          ..write('id: $id, ')
          ..write('timestamp: $timestamp, ')
          ..write('name: $name, ')
          ..write('dose: $dose, ')
          ..write('symptomId: $symptomId, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SleepEntriesTable extends SleepEntries
    with TableInfo<$SleepEntriesTable, SleepEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SleepEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nightDateMeta = const VerificationMeta(
    'nightDate',
  );
  @override
  late final GeneratedColumn<DateTime> nightDate = GeneratedColumn<DateTime>(
    'night_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _qualityMeta = const VerificationMeta(
    'quality',
  );
  @override
  late final GeneratedColumn<int> quality = GeneratedColumn<int>(
    'quality',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bedTimeMeta = const VerificationMeta(
    'bedTime',
  );
  @override
  late final GeneratedColumn<DateTime> bedTime = GeneratedColumn<DateTime>(
    'bed_time',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _wakeTimeMeta = const VerificationMeta(
    'wakeTime',
  );
  @override
  late final GeneratedColumn<DateTime> wakeTime = GeneratedColumn<DateTime>(
    'wake_time',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('manual'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nightDate,
    quality,
    bedTime,
    wakeTime,
    source,
    createdAt,
    updatedAt,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sleep_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<SleepEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('night_date')) {
      context.handle(
        _nightDateMeta,
        nightDate.isAcceptableOrUnknown(data['night_date']!, _nightDateMeta),
      );
    } else if (isInserting) {
      context.missing(_nightDateMeta);
    }
    if (data.containsKey('quality')) {
      context.handle(
        _qualityMeta,
        quality.isAcceptableOrUnknown(data['quality']!, _qualityMeta),
      );
    } else if (isInserting) {
      context.missing(_qualityMeta);
    }
    if (data.containsKey('bed_time')) {
      context.handle(
        _bedTimeMeta,
        bedTime.isAcceptableOrUnknown(data['bed_time']!, _bedTimeMeta),
      );
    }
    if (data.containsKey('wake_time')) {
      context.handle(
        _wakeTimeMeta,
        wakeTime.isAcceptableOrUnknown(data['wake_time']!, _wakeTimeMeta),
      );
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {nightDate},
  ];
  @override
  SleepEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SleepEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      nightDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}night_date'],
      )!,
      quality: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quality'],
      )!,
      bedTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}bed_time'],
      ),
      wakeTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}wake_time'],
      ),
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $SleepEntriesTable createAlias(String alias) {
    return $SleepEntriesTable(attachedDatabase, alias);
  }
}

class SleepEntry extends DataClass implements Insertable<SleepEntry> {
  final String id;
  final DateTime nightDate;
  final int quality;
  final DateTime? bedTime;
  final DateTime? wakeTime;
  final String source;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  const SleepEntry({
    required this.id,
    required this.nightDate,
    required this.quality,
    this.bedTime,
    this.wakeTime,
    required this.source,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['night_date'] = Variable<DateTime>(nightDate);
    map['quality'] = Variable<int>(quality);
    if (!nullToAbsent || bedTime != null) {
      map['bed_time'] = Variable<DateTime>(bedTime);
    }
    if (!nullToAbsent || wakeTime != null) {
      map['wake_time'] = Variable<DateTime>(wakeTime);
    }
    map['source'] = Variable<String>(source);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  SleepEntriesCompanion toCompanion(bool nullToAbsent) {
    return SleepEntriesCompanion(
      id: Value(id),
      nightDate: Value(nightDate),
      quality: Value(quality),
      bedTime: bedTime == null && nullToAbsent
          ? const Value.absent()
          : Value(bedTime),
      wakeTime: wakeTime == null && nullToAbsent
          ? const Value.absent()
          : Value(wakeTime),
      source: Value(source),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory SleepEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SleepEntry(
      id: serializer.fromJson<String>(json['id']),
      nightDate: serializer.fromJson<DateTime>(json['nightDate']),
      quality: serializer.fromJson<int>(json['quality']),
      bedTime: serializer.fromJson<DateTime?>(json['bedTime']),
      wakeTime: serializer.fromJson<DateTime?>(json['wakeTime']),
      source: serializer.fromJson<String>(json['source']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nightDate': serializer.toJson<DateTime>(nightDate),
      'quality': serializer.toJson<int>(quality),
      'bedTime': serializer.toJson<DateTime?>(bedTime),
      'wakeTime': serializer.toJson<DateTime?>(wakeTime),
      'source': serializer.toJson<String>(source),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  SleepEntry copyWith({
    String? id,
    DateTime? nightDate,
    int? quality,
    Value<DateTime?> bedTime = const Value.absent(),
    Value<DateTime?> wakeTime = const Value.absent(),
    String? source,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
  }) => SleepEntry(
    id: id ?? this.id,
    nightDate: nightDate ?? this.nightDate,
    quality: quality ?? this.quality,
    bedTime: bedTime.present ? bedTime.value : this.bedTime,
    wakeTime: wakeTime.present ? wakeTime.value : this.wakeTime,
    source: source ?? this.source,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  SleepEntry copyWithCompanion(SleepEntriesCompanion data) {
    return SleepEntry(
      id: data.id.present ? data.id.value : this.id,
      nightDate: data.nightDate.present ? data.nightDate.value : this.nightDate,
      quality: data.quality.present ? data.quality.value : this.quality,
      bedTime: data.bedTime.present ? data.bedTime.value : this.bedTime,
      wakeTime: data.wakeTime.present ? data.wakeTime.value : this.wakeTime,
      source: data.source.present ? data.source.value : this.source,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SleepEntry(')
          ..write('id: $id, ')
          ..write('nightDate: $nightDate, ')
          ..write('quality: $quality, ')
          ..write('bedTime: $bedTime, ')
          ..write('wakeTime: $wakeTime, ')
          ..write('source: $source, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    nightDate,
    quality,
    bedTime,
    wakeTime,
    source,
    createdAt,
    updatedAt,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SleepEntry &&
          other.id == this.id &&
          other.nightDate == this.nightDate &&
          other.quality == this.quality &&
          other.bedTime == this.bedTime &&
          other.wakeTime == this.wakeTime &&
          other.source == this.source &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class SleepEntriesCompanion extends UpdateCompanion<SleepEntry> {
  final Value<String> id;
  final Value<DateTime> nightDate;
  final Value<int> quality;
  final Value<DateTime?> bedTime;
  final Value<DateTime?> wakeTime;
  final Value<String> source;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const SleepEntriesCompanion({
    this.id = const Value.absent(),
    this.nightDate = const Value.absent(),
    this.quality = const Value.absent(),
    this.bedTime = const Value.absent(),
    this.wakeTime = const Value.absent(),
    this.source = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SleepEntriesCompanion.insert({
    required String id,
    required DateTime nightDate,
    required int quality,
    this.bedTime = const Value.absent(),
    this.wakeTime = const Value.absent(),
    this.source = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       nightDate = Value(nightDate),
       quality = Value(quality);
  static Insertable<SleepEntry> custom({
    Expression<String>? id,
    Expression<DateTime>? nightDate,
    Expression<int>? quality,
    Expression<DateTime>? bedTime,
    Expression<DateTime>? wakeTime,
    Expression<String>? source,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nightDate != null) 'night_date': nightDate,
      if (quality != null) 'quality': quality,
      if (bedTime != null) 'bed_time': bedTime,
      if (wakeTime != null) 'wake_time': wakeTime,
      if (source != null) 'source': source,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SleepEntriesCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? nightDate,
    Value<int>? quality,
    Value<DateTime?>? bedTime,
    Value<DateTime?>? wakeTime,
    Value<String>? source,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<int>? rowid,
  }) {
    return SleepEntriesCompanion(
      id: id ?? this.id,
      nightDate: nightDate ?? this.nightDate,
      quality: quality ?? this.quality,
      bedTime: bedTime ?? this.bedTime,
      wakeTime: wakeTime ?? this.wakeTime,
      source: source ?? this.source,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nightDate.present) {
      map['night_date'] = Variable<DateTime>(nightDate.value);
    }
    if (quality.present) {
      map['quality'] = Variable<int>(quality.value);
    }
    if (bedTime.present) {
      map['bed_time'] = Variable<DateTime>(bedTime.value);
    }
    if (wakeTime.present) {
      map['wake_time'] = Variable<DateTime>(wakeTime.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SleepEntriesCompanion(')
          ..write('id: $id, ')
          ..write('nightDate: $nightDate, ')
          ..write('quality: $quality, ')
          ..write('bedTime: $bedTime, ')
          ..write('wakeTime: $wakeTime, ')
          ..write('source: $source, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EnvironmentSnapshotsTable extends EnvironmentSnapshots
    with TableInfo<$EnvironmentSnapshotsTable, EnvironmentSnapshot> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EnvironmentSnapshotsTable(this.attachedDatabase, [this._alias]);
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
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pressureMeta = const VerificationMeta(
    'pressure',
  );
  @override
  late final GeneratedColumn<double> pressure = GeneratedColumn<double>(
    'pressure',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pressureDeltaMeta = const VerificationMeta(
    'pressureDelta',
  );
  @override
  late final GeneratedColumn<double> pressureDelta = GeneratedColumn<double>(
    'pressure_delta',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _temperatureMeta = const VerificationMeta(
    'temperature',
  );
  @override
  late final GeneratedColumn<double> temperature = GeneratedColumn<double>(
    'temperature',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _humidityMeta = const VerificationMeta(
    'humidity',
  );
  @override
  late final GeneratedColumn<double> humidity = GeneratedColumn<double>(
    'humidity',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _latMeta = const VerificationMeta('lat');
  @override
  late final GeneratedColumn<double> lat = GeneratedColumn<double>(
    'lat',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lonMeta = const VerificationMeta('lon');
  @override
  late final GeneratedColumn<double> lon = GeneratedColumn<double>(
    'lon',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _weatherCodeMeta = const VerificationMeta(
    'weatherCode',
  );
  @override
  late final GeneratedColumn<int> weatherCode = GeneratedColumn<int>(
    'weather_code',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _uvIndexMeta = const VerificationMeta(
    'uvIndex',
  );
  @override
  late final GeneratedColumn<double> uvIndex = GeneratedColumn<double>(
    'uv_index',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pm25Meta = const VerificationMeta('pm25');
  @override
  late final GeneratedColumn<double> pm25 = GeneratedColumn<double>(
    'pm25',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pm10Meta = const VerificationMeta('pm10');
  @override
  late final GeneratedColumn<double> pm10 = GeneratedColumn<double>(
    'pm10',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _alderPollenMeta = const VerificationMeta(
    'alderPollen',
  );
  @override
  late final GeneratedColumn<double> alderPollen = GeneratedColumn<double>(
    'alder_pollen',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _birchPollenMeta = const VerificationMeta(
    'birchPollen',
  );
  @override
  late final GeneratedColumn<double> birchPollen = GeneratedColumn<double>(
    'birch_pollen',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _grassPollenMeta = const VerificationMeta(
    'grassPollen',
  );
  @override
  late final GeneratedColumn<double> grassPollen = GeneratedColumn<double>(
    'grass_pollen',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _mugwortPollenMeta = const VerificationMeta(
    'mugwortPollen',
  );
  @override
  late final GeneratedColumn<double> mugwortPollen = GeneratedColumn<double>(
    'mugwort_pollen',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _olivePollenMeta = const VerificationMeta(
    'olivePollen',
  );
  @override
  late final GeneratedColumn<double> olivePollen = GeneratedColumn<double>(
    'olive_pollen',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ragweedPollenMeta = const VerificationMeta(
    'ragweedPollen',
  );
  @override
  late final GeneratedColumn<double> ragweedPollen = GeneratedColumn<double>(
    'ragweed_pollen',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    timestamp,
    pressure,
    pressureDelta,
    temperature,
    humidity,
    lat,
    lon,
    weatherCode,
    uvIndex,
    pm25,
    pm10,
    alderPollen,
    birchPollen,
    grassPollen,
    mugwortPollen,
    olivePollen,
    ragweedPollen,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'environment_snapshots';
  @override
  VerificationContext validateIntegrity(
    Insertable<EnvironmentSnapshot> instance, {
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
    if (data.containsKey('pressure')) {
      context.handle(
        _pressureMeta,
        pressure.isAcceptableOrUnknown(data['pressure']!, _pressureMeta),
      );
    }
    if (data.containsKey('pressure_delta')) {
      context.handle(
        _pressureDeltaMeta,
        pressureDelta.isAcceptableOrUnknown(
          data['pressure_delta']!,
          _pressureDeltaMeta,
        ),
      );
    }
    if (data.containsKey('temperature')) {
      context.handle(
        _temperatureMeta,
        temperature.isAcceptableOrUnknown(
          data['temperature']!,
          _temperatureMeta,
        ),
      );
    }
    if (data.containsKey('humidity')) {
      context.handle(
        _humidityMeta,
        humidity.isAcceptableOrUnknown(data['humidity']!, _humidityMeta),
      );
    }
    if (data.containsKey('lat')) {
      context.handle(
        _latMeta,
        lat.isAcceptableOrUnknown(data['lat']!, _latMeta),
      );
    }
    if (data.containsKey('lon')) {
      context.handle(
        _lonMeta,
        lon.isAcceptableOrUnknown(data['lon']!, _lonMeta),
      );
    }
    if (data.containsKey('weather_code')) {
      context.handle(
        _weatherCodeMeta,
        weatherCode.isAcceptableOrUnknown(
          data['weather_code']!,
          _weatherCodeMeta,
        ),
      );
    }
    if (data.containsKey('uv_index')) {
      context.handle(
        _uvIndexMeta,
        uvIndex.isAcceptableOrUnknown(data['uv_index']!, _uvIndexMeta),
      );
    }
    if (data.containsKey('pm25')) {
      context.handle(
        _pm25Meta,
        pm25.isAcceptableOrUnknown(data['pm25']!, _pm25Meta),
      );
    }
    if (data.containsKey('pm10')) {
      context.handle(
        _pm10Meta,
        pm10.isAcceptableOrUnknown(data['pm10']!, _pm10Meta),
      );
    }
    if (data.containsKey('alder_pollen')) {
      context.handle(
        _alderPollenMeta,
        alderPollen.isAcceptableOrUnknown(
          data['alder_pollen']!,
          _alderPollenMeta,
        ),
      );
    }
    if (data.containsKey('birch_pollen')) {
      context.handle(
        _birchPollenMeta,
        birchPollen.isAcceptableOrUnknown(
          data['birch_pollen']!,
          _birchPollenMeta,
        ),
      );
    }
    if (data.containsKey('grass_pollen')) {
      context.handle(
        _grassPollenMeta,
        grassPollen.isAcceptableOrUnknown(
          data['grass_pollen']!,
          _grassPollenMeta,
        ),
      );
    }
    if (data.containsKey('mugwort_pollen')) {
      context.handle(
        _mugwortPollenMeta,
        mugwortPollen.isAcceptableOrUnknown(
          data['mugwort_pollen']!,
          _mugwortPollenMeta,
        ),
      );
    }
    if (data.containsKey('olive_pollen')) {
      context.handle(
        _olivePollenMeta,
        olivePollen.isAcceptableOrUnknown(
          data['olive_pollen']!,
          _olivePollenMeta,
        ),
      );
    }
    if (data.containsKey('ragweed_pollen')) {
      context.handle(
        _ragweedPollenMeta,
        ragweedPollen.isAcceptableOrUnknown(
          data['ragweed_pollen']!,
          _ragweedPollenMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EnvironmentSnapshot map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EnvironmentSnapshot(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
      pressure: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}pressure'],
      ),
      pressureDelta: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}pressure_delta'],
      ),
      temperature: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}temperature'],
      ),
      humidity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}humidity'],
      ),
      lat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}lat'],
      ),
      lon: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}lon'],
      ),
      weatherCode: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}weather_code'],
      ),
      uvIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}uv_index'],
      ),
      pm25: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}pm25'],
      ),
      pm10: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}pm10'],
      ),
      alderPollen: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}alder_pollen'],
      ),
      birchPollen: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}birch_pollen'],
      ),
      grassPollen: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}grass_pollen'],
      ),
      mugwortPollen: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}mugwort_pollen'],
      ),
      olivePollen: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}olive_pollen'],
      ),
      ragweedPollen: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}ragweed_pollen'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $EnvironmentSnapshotsTable createAlias(String alias) {
    return $EnvironmentSnapshotsTable(attachedDatabase, alias);
  }
}

class EnvironmentSnapshot extends DataClass
    implements Insertable<EnvironmentSnapshot> {
  final String id;
  final DateTime timestamp;
  final double? pressure;
  final double? pressureDelta;
  final double? temperature;
  final double? humidity;
  final double? lat;
  final double? lon;

  /// WMO weather interpretation code (0 = clear sky, 61 = rain, ...).
  final int? weatherCode;
  final double? uvIndex;

  /// Air quality (µg/m³) from the Open-Meteo air-quality API.
  final double? pm25;
  final double? pm10;

  /// Pollen concentrations (grains/m³), European coverage only.
  final double? alderPollen;
  final double? birchPollen;
  final double? grassPollen;
  final double? mugwortPollen;
  final double? olivePollen;
  final double? ragweedPollen;
  final DateTime createdAt;
  const EnvironmentSnapshot({
    required this.id,
    required this.timestamp,
    this.pressure,
    this.pressureDelta,
    this.temperature,
    this.humidity,
    this.lat,
    this.lon,
    this.weatherCode,
    this.uvIndex,
    this.pm25,
    this.pm10,
    this.alderPollen,
    this.birchPollen,
    this.grassPollen,
    this.mugwortPollen,
    this.olivePollen,
    this.ragweedPollen,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['timestamp'] = Variable<DateTime>(timestamp);
    if (!nullToAbsent || pressure != null) {
      map['pressure'] = Variable<double>(pressure);
    }
    if (!nullToAbsent || pressureDelta != null) {
      map['pressure_delta'] = Variable<double>(pressureDelta);
    }
    if (!nullToAbsent || temperature != null) {
      map['temperature'] = Variable<double>(temperature);
    }
    if (!nullToAbsent || humidity != null) {
      map['humidity'] = Variable<double>(humidity);
    }
    if (!nullToAbsent || lat != null) {
      map['lat'] = Variable<double>(lat);
    }
    if (!nullToAbsent || lon != null) {
      map['lon'] = Variable<double>(lon);
    }
    if (!nullToAbsent || weatherCode != null) {
      map['weather_code'] = Variable<int>(weatherCode);
    }
    if (!nullToAbsent || uvIndex != null) {
      map['uv_index'] = Variable<double>(uvIndex);
    }
    if (!nullToAbsent || pm25 != null) {
      map['pm25'] = Variable<double>(pm25);
    }
    if (!nullToAbsent || pm10 != null) {
      map['pm10'] = Variable<double>(pm10);
    }
    if (!nullToAbsent || alderPollen != null) {
      map['alder_pollen'] = Variable<double>(alderPollen);
    }
    if (!nullToAbsent || birchPollen != null) {
      map['birch_pollen'] = Variable<double>(birchPollen);
    }
    if (!nullToAbsent || grassPollen != null) {
      map['grass_pollen'] = Variable<double>(grassPollen);
    }
    if (!nullToAbsent || mugwortPollen != null) {
      map['mugwort_pollen'] = Variable<double>(mugwortPollen);
    }
    if (!nullToAbsent || olivePollen != null) {
      map['olive_pollen'] = Variable<double>(olivePollen);
    }
    if (!nullToAbsent || ragweedPollen != null) {
      map['ragweed_pollen'] = Variable<double>(ragweedPollen);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  EnvironmentSnapshotsCompanion toCompanion(bool nullToAbsent) {
    return EnvironmentSnapshotsCompanion(
      id: Value(id),
      timestamp: Value(timestamp),
      pressure: pressure == null && nullToAbsent
          ? const Value.absent()
          : Value(pressure),
      pressureDelta: pressureDelta == null && nullToAbsent
          ? const Value.absent()
          : Value(pressureDelta),
      temperature: temperature == null && nullToAbsent
          ? const Value.absent()
          : Value(temperature),
      humidity: humidity == null && nullToAbsent
          ? const Value.absent()
          : Value(humidity),
      lat: lat == null && nullToAbsent ? const Value.absent() : Value(lat),
      lon: lon == null && nullToAbsent ? const Value.absent() : Value(lon),
      weatherCode: weatherCode == null && nullToAbsent
          ? const Value.absent()
          : Value(weatherCode),
      uvIndex: uvIndex == null && nullToAbsent
          ? const Value.absent()
          : Value(uvIndex),
      pm25: pm25 == null && nullToAbsent ? const Value.absent() : Value(pm25),
      pm10: pm10 == null && nullToAbsent ? const Value.absent() : Value(pm10),
      alderPollen: alderPollen == null && nullToAbsent
          ? const Value.absent()
          : Value(alderPollen),
      birchPollen: birchPollen == null && nullToAbsent
          ? const Value.absent()
          : Value(birchPollen),
      grassPollen: grassPollen == null && nullToAbsent
          ? const Value.absent()
          : Value(grassPollen),
      mugwortPollen: mugwortPollen == null && nullToAbsent
          ? const Value.absent()
          : Value(mugwortPollen),
      olivePollen: olivePollen == null && nullToAbsent
          ? const Value.absent()
          : Value(olivePollen),
      ragweedPollen: ragweedPollen == null && nullToAbsent
          ? const Value.absent()
          : Value(ragweedPollen),
      createdAt: Value(createdAt),
    );
  }

  factory EnvironmentSnapshot.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EnvironmentSnapshot(
      id: serializer.fromJson<String>(json['id']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      pressure: serializer.fromJson<double?>(json['pressure']),
      pressureDelta: serializer.fromJson<double?>(json['pressureDelta']),
      temperature: serializer.fromJson<double?>(json['temperature']),
      humidity: serializer.fromJson<double?>(json['humidity']),
      lat: serializer.fromJson<double?>(json['lat']),
      lon: serializer.fromJson<double?>(json['lon']),
      weatherCode: serializer.fromJson<int?>(json['weatherCode']),
      uvIndex: serializer.fromJson<double?>(json['uvIndex']),
      pm25: serializer.fromJson<double?>(json['pm25']),
      pm10: serializer.fromJson<double?>(json['pm10']),
      alderPollen: serializer.fromJson<double?>(json['alderPollen']),
      birchPollen: serializer.fromJson<double?>(json['birchPollen']),
      grassPollen: serializer.fromJson<double?>(json['grassPollen']),
      mugwortPollen: serializer.fromJson<double?>(json['mugwortPollen']),
      olivePollen: serializer.fromJson<double?>(json['olivePollen']),
      ragweedPollen: serializer.fromJson<double?>(json['ragweedPollen']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'pressure': serializer.toJson<double?>(pressure),
      'pressureDelta': serializer.toJson<double?>(pressureDelta),
      'temperature': serializer.toJson<double?>(temperature),
      'humidity': serializer.toJson<double?>(humidity),
      'lat': serializer.toJson<double?>(lat),
      'lon': serializer.toJson<double?>(lon),
      'weatherCode': serializer.toJson<int?>(weatherCode),
      'uvIndex': serializer.toJson<double?>(uvIndex),
      'pm25': serializer.toJson<double?>(pm25),
      'pm10': serializer.toJson<double?>(pm10),
      'alderPollen': serializer.toJson<double?>(alderPollen),
      'birchPollen': serializer.toJson<double?>(birchPollen),
      'grassPollen': serializer.toJson<double?>(grassPollen),
      'mugwortPollen': serializer.toJson<double?>(mugwortPollen),
      'olivePollen': serializer.toJson<double?>(olivePollen),
      'ragweedPollen': serializer.toJson<double?>(ragweedPollen),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  EnvironmentSnapshot copyWith({
    String? id,
    DateTime? timestamp,
    Value<double?> pressure = const Value.absent(),
    Value<double?> pressureDelta = const Value.absent(),
    Value<double?> temperature = const Value.absent(),
    Value<double?> humidity = const Value.absent(),
    Value<double?> lat = const Value.absent(),
    Value<double?> lon = const Value.absent(),
    Value<int?> weatherCode = const Value.absent(),
    Value<double?> uvIndex = const Value.absent(),
    Value<double?> pm25 = const Value.absent(),
    Value<double?> pm10 = const Value.absent(),
    Value<double?> alderPollen = const Value.absent(),
    Value<double?> birchPollen = const Value.absent(),
    Value<double?> grassPollen = const Value.absent(),
    Value<double?> mugwortPollen = const Value.absent(),
    Value<double?> olivePollen = const Value.absent(),
    Value<double?> ragweedPollen = const Value.absent(),
    DateTime? createdAt,
  }) => EnvironmentSnapshot(
    id: id ?? this.id,
    timestamp: timestamp ?? this.timestamp,
    pressure: pressure.present ? pressure.value : this.pressure,
    pressureDelta: pressureDelta.present
        ? pressureDelta.value
        : this.pressureDelta,
    temperature: temperature.present ? temperature.value : this.temperature,
    humidity: humidity.present ? humidity.value : this.humidity,
    lat: lat.present ? lat.value : this.lat,
    lon: lon.present ? lon.value : this.lon,
    weatherCode: weatherCode.present ? weatherCode.value : this.weatherCode,
    uvIndex: uvIndex.present ? uvIndex.value : this.uvIndex,
    pm25: pm25.present ? pm25.value : this.pm25,
    pm10: pm10.present ? pm10.value : this.pm10,
    alderPollen: alderPollen.present ? alderPollen.value : this.alderPollen,
    birchPollen: birchPollen.present ? birchPollen.value : this.birchPollen,
    grassPollen: grassPollen.present ? grassPollen.value : this.grassPollen,
    mugwortPollen: mugwortPollen.present
        ? mugwortPollen.value
        : this.mugwortPollen,
    olivePollen: olivePollen.present ? olivePollen.value : this.olivePollen,
    ragweedPollen: ragweedPollen.present
        ? ragweedPollen.value
        : this.ragweedPollen,
    createdAt: createdAt ?? this.createdAt,
  );
  EnvironmentSnapshot copyWithCompanion(EnvironmentSnapshotsCompanion data) {
    return EnvironmentSnapshot(
      id: data.id.present ? data.id.value : this.id,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      pressure: data.pressure.present ? data.pressure.value : this.pressure,
      pressureDelta: data.pressureDelta.present
          ? data.pressureDelta.value
          : this.pressureDelta,
      temperature: data.temperature.present
          ? data.temperature.value
          : this.temperature,
      humidity: data.humidity.present ? data.humidity.value : this.humidity,
      lat: data.lat.present ? data.lat.value : this.lat,
      lon: data.lon.present ? data.lon.value : this.lon,
      weatherCode: data.weatherCode.present
          ? data.weatherCode.value
          : this.weatherCode,
      uvIndex: data.uvIndex.present ? data.uvIndex.value : this.uvIndex,
      pm25: data.pm25.present ? data.pm25.value : this.pm25,
      pm10: data.pm10.present ? data.pm10.value : this.pm10,
      alderPollen: data.alderPollen.present
          ? data.alderPollen.value
          : this.alderPollen,
      birchPollen: data.birchPollen.present
          ? data.birchPollen.value
          : this.birchPollen,
      grassPollen: data.grassPollen.present
          ? data.grassPollen.value
          : this.grassPollen,
      mugwortPollen: data.mugwortPollen.present
          ? data.mugwortPollen.value
          : this.mugwortPollen,
      olivePollen: data.olivePollen.present
          ? data.olivePollen.value
          : this.olivePollen,
      ragweedPollen: data.ragweedPollen.present
          ? data.ragweedPollen.value
          : this.ragweedPollen,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EnvironmentSnapshot(')
          ..write('id: $id, ')
          ..write('timestamp: $timestamp, ')
          ..write('pressure: $pressure, ')
          ..write('pressureDelta: $pressureDelta, ')
          ..write('temperature: $temperature, ')
          ..write('humidity: $humidity, ')
          ..write('lat: $lat, ')
          ..write('lon: $lon, ')
          ..write('weatherCode: $weatherCode, ')
          ..write('uvIndex: $uvIndex, ')
          ..write('pm25: $pm25, ')
          ..write('pm10: $pm10, ')
          ..write('alderPollen: $alderPollen, ')
          ..write('birchPollen: $birchPollen, ')
          ..write('grassPollen: $grassPollen, ')
          ..write('mugwortPollen: $mugwortPollen, ')
          ..write('olivePollen: $olivePollen, ')
          ..write('ragweedPollen: $ragweedPollen, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    timestamp,
    pressure,
    pressureDelta,
    temperature,
    humidity,
    lat,
    lon,
    weatherCode,
    uvIndex,
    pm25,
    pm10,
    alderPollen,
    birchPollen,
    grassPollen,
    mugwortPollen,
    olivePollen,
    ragweedPollen,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EnvironmentSnapshot &&
          other.id == this.id &&
          other.timestamp == this.timestamp &&
          other.pressure == this.pressure &&
          other.pressureDelta == this.pressureDelta &&
          other.temperature == this.temperature &&
          other.humidity == this.humidity &&
          other.lat == this.lat &&
          other.lon == this.lon &&
          other.weatherCode == this.weatherCode &&
          other.uvIndex == this.uvIndex &&
          other.pm25 == this.pm25 &&
          other.pm10 == this.pm10 &&
          other.alderPollen == this.alderPollen &&
          other.birchPollen == this.birchPollen &&
          other.grassPollen == this.grassPollen &&
          other.mugwortPollen == this.mugwortPollen &&
          other.olivePollen == this.olivePollen &&
          other.ragweedPollen == this.ragweedPollen &&
          other.createdAt == this.createdAt);
}

class EnvironmentSnapshotsCompanion
    extends UpdateCompanion<EnvironmentSnapshot> {
  final Value<String> id;
  final Value<DateTime> timestamp;
  final Value<double?> pressure;
  final Value<double?> pressureDelta;
  final Value<double?> temperature;
  final Value<double?> humidity;
  final Value<double?> lat;
  final Value<double?> lon;
  final Value<int?> weatherCode;
  final Value<double?> uvIndex;
  final Value<double?> pm25;
  final Value<double?> pm10;
  final Value<double?> alderPollen;
  final Value<double?> birchPollen;
  final Value<double?> grassPollen;
  final Value<double?> mugwortPollen;
  final Value<double?> olivePollen;
  final Value<double?> ragweedPollen;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const EnvironmentSnapshotsCompanion({
    this.id = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.pressure = const Value.absent(),
    this.pressureDelta = const Value.absent(),
    this.temperature = const Value.absent(),
    this.humidity = const Value.absent(),
    this.lat = const Value.absent(),
    this.lon = const Value.absent(),
    this.weatherCode = const Value.absent(),
    this.uvIndex = const Value.absent(),
    this.pm25 = const Value.absent(),
    this.pm10 = const Value.absent(),
    this.alderPollen = const Value.absent(),
    this.birchPollen = const Value.absent(),
    this.grassPollen = const Value.absent(),
    this.mugwortPollen = const Value.absent(),
    this.olivePollen = const Value.absent(),
    this.ragweedPollen = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EnvironmentSnapshotsCompanion.insert({
    required String id,
    required DateTime timestamp,
    this.pressure = const Value.absent(),
    this.pressureDelta = const Value.absent(),
    this.temperature = const Value.absent(),
    this.humidity = const Value.absent(),
    this.lat = const Value.absent(),
    this.lon = const Value.absent(),
    this.weatherCode = const Value.absent(),
    this.uvIndex = const Value.absent(),
    this.pm25 = const Value.absent(),
    this.pm10 = const Value.absent(),
    this.alderPollen = const Value.absent(),
    this.birchPollen = const Value.absent(),
    this.grassPollen = const Value.absent(),
    this.mugwortPollen = const Value.absent(),
    this.olivePollen = const Value.absent(),
    this.ragweedPollen = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       timestamp = Value(timestamp);
  static Insertable<EnvironmentSnapshot> custom({
    Expression<String>? id,
    Expression<DateTime>? timestamp,
    Expression<double>? pressure,
    Expression<double>? pressureDelta,
    Expression<double>? temperature,
    Expression<double>? humidity,
    Expression<double>? lat,
    Expression<double>? lon,
    Expression<int>? weatherCode,
    Expression<double>? uvIndex,
    Expression<double>? pm25,
    Expression<double>? pm10,
    Expression<double>? alderPollen,
    Expression<double>? birchPollen,
    Expression<double>? grassPollen,
    Expression<double>? mugwortPollen,
    Expression<double>? olivePollen,
    Expression<double>? ragweedPollen,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (timestamp != null) 'timestamp': timestamp,
      if (pressure != null) 'pressure': pressure,
      if (pressureDelta != null) 'pressure_delta': pressureDelta,
      if (temperature != null) 'temperature': temperature,
      if (humidity != null) 'humidity': humidity,
      if (lat != null) 'lat': lat,
      if (lon != null) 'lon': lon,
      if (weatherCode != null) 'weather_code': weatherCode,
      if (uvIndex != null) 'uv_index': uvIndex,
      if (pm25 != null) 'pm25': pm25,
      if (pm10 != null) 'pm10': pm10,
      if (alderPollen != null) 'alder_pollen': alderPollen,
      if (birchPollen != null) 'birch_pollen': birchPollen,
      if (grassPollen != null) 'grass_pollen': grassPollen,
      if (mugwortPollen != null) 'mugwort_pollen': mugwortPollen,
      if (olivePollen != null) 'olive_pollen': olivePollen,
      if (ragweedPollen != null) 'ragweed_pollen': ragweedPollen,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EnvironmentSnapshotsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? timestamp,
    Value<double?>? pressure,
    Value<double?>? pressureDelta,
    Value<double?>? temperature,
    Value<double?>? humidity,
    Value<double?>? lat,
    Value<double?>? lon,
    Value<int?>? weatherCode,
    Value<double?>? uvIndex,
    Value<double?>? pm25,
    Value<double?>? pm10,
    Value<double?>? alderPollen,
    Value<double?>? birchPollen,
    Value<double?>? grassPollen,
    Value<double?>? mugwortPollen,
    Value<double?>? olivePollen,
    Value<double?>? ragweedPollen,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return EnvironmentSnapshotsCompanion(
      id: id ?? this.id,
      timestamp: timestamp ?? this.timestamp,
      pressure: pressure ?? this.pressure,
      pressureDelta: pressureDelta ?? this.pressureDelta,
      temperature: temperature ?? this.temperature,
      humidity: humidity ?? this.humidity,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      weatherCode: weatherCode ?? this.weatherCode,
      uvIndex: uvIndex ?? this.uvIndex,
      pm25: pm25 ?? this.pm25,
      pm10: pm10 ?? this.pm10,
      alderPollen: alderPollen ?? this.alderPollen,
      birchPollen: birchPollen ?? this.birchPollen,
      grassPollen: grassPollen ?? this.grassPollen,
      mugwortPollen: mugwortPollen ?? this.mugwortPollen,
      olivePollen: olivePollen ?? this.olivePollen,
      ragweedPollen: ragweedPollen ?? this.ragweedPollen,
      createdAt: createdAt ?? this.createdAt,
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
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (pressure.present) {
      map['pressure'] = Variable<double>(pressure.value);
    }
    if (pressureDelta.present) {
      map['pressure_delta'] = Variable<double>(pressureDelta.value);
    }
    if (temperature.present) {
      map['temperature'] = Variable<double>(temperature.value);
    }
    if (humidity.present) {
      map['humidity'] = Variable<double>(humidity.value);
    }
    if (lat.present) {
      map['lat'] = Variable<double>(lat.value);
    }
    if (lon.present) {
      map['lon'] = Variable<double>(lon.value);
    }
    if (weatherCode.present) {
      map['weather_code'] = Variable<int>(weatherCode.value);
    }
    if (uvIndex.present) {
      map['uv_index'] = Variable<double>(uvIndex.value);
    }
    if (pm25.present) {
      map['pm25'] = Variable<double>(pm25.value);
    }
    if (pm10.present) {
      map['pm10'] = Variable<double>(pm10.value);
    }
    if (alderPollen.present) {
      map['alder_pollen'] = Variable<double>(alderPollen.value);
    }
    if (birchPollen.present) {
      map['birch_pollen'] = Variable<double>(birchPollen.value);
    }
    if (grassPollen.present) {
      map['grass_pollen'] = Variable<double>(grassPollen.value);
    }
    if (mugwortPollen.present) {
      map['mugwort_pollen'] = Variable<double>(mugwortPollen.value);
    }
    if (olivePollen.present) {
      map['olive_pollen'] = Variable<double>(olivePollen.value);
    }
    if (ragweedPollen.present) {
      map['ragweed_pollen'] = Variable<double>(ragweedPollen.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EnvironmentSnapshotsCompanion(')
          ..write('id: $id, ')
          ..write('timestamp: $timestamp, ')
          ..write('pressure: $pressure, ')
          ..write('pressureDelta: $pressureDelta, ')
          ..write('temperature: $temperature, ')
          ..write('humidity: $humidity, ')
          ..write('lat: $lat, ')
          ..write('lon: $lon, ')
          ..write('weatherCode: $weatherCode, ')
          ..write('uvIndex: $uvIndex, ')
          ..write('pm25: $pm25, ')
          ..write('pm10: $pm10, ')
          ..write('alderPollen: $alderPollen, ')
          ..write('birchPollen: $birchPollen, ')
          ..write('grassPollen: $grassPollen, ')
          ..write('mugwortPollen: $mugwortPollen, ')
          ..write('olivePollen: $olivePollen, ')
          ..write('ragweedPollen: $ragweedPollen, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _onboardingDoneMeta = const VerificationMeta(
    'onboardingDone',
  );
  @override
  late final GeneratedColumn<bool> onboardingDone = GeneratedColumn<bool>(
    'onboarding_done',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("onboarding_done" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _lastPressureAlertDateMeta =
      const VerificationMeta('lastPressureAlertDate');
  @override
  late final GeneratedColumn<DateTime> lastPressureAlertDate =
      GeneratedColumn<DateTime>(
        'last_pressure_alert_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _remindersMealsEnabledMeta =
      const VerificationMeta('remindersMealsEnabled');
  @override
  late final GeneratedColumn<bool> remindersMealsEnabled =
      GeneratedColumn<bool>(
        'reminders_meals_enabled',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("reminders_meals_enabled" IN (0, 1))',
        ),
        defaultValue: const Constant(true),
      );
  static const VerificationMeta _breakfastHourMeta = const VerificationMeta(
    'breakfastHour',
  );
  @override
  late final GeneratedColumn<int> breakfastHour = GeneratedColumn<int>(
    'breakfast_hour',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(8),
  );
  static const VerificationMeta _breakfastMinuteMeta = const VerificationMeta(
    'breakfastMinute',
  );
  @override
  late final GeneratedColumn<int> breakfastMinute = GeneratedColumn<int>(
    'breakfast_minute',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(30),
  );
  static const VerificationMeta _lunchHourMeta = const VerificationMeta(
    'lunchHour',
  );
  @override
  late final GeneratedColumn<int> lunchHour = GeneratedColumn<int>(
    'lunch_hour',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(12),
  );
  static const VerificationMeta _lunchMinuteMeta = const VerificationMeta(
    'lunchMinute',
  );
  @override
  late final GeneratedColumn<int> lunchMinute = GeneratedColumn<int>(
    'lunch_minute',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(30),
  );
  static const VerificationMeta _dinnerHourMeta = const VerificationMeta(
    'dinnerHour',
  );
  @override
  late final GeneratedColumn<int> dinnerHour = GeneratedColumn<int>(
    'dinner_hour',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(19),
  );
  static const VerificationMeta _dinnerMinuteMeta = const VerificationMeta(
    'dinnerMinute',
  );
  @override
  late final GeneratedColumn<int> dinnerMinute = GeneratedColumn<int>(
    'dinner_minute',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(30),
  );
  static const VerificationMeta _remindersSleepEnabledMeta =
      const VerificationMeta('remindersSleepEnabled');
  @override
  late final GeneratedColumn<bool> remindersSleepEnabled =
      GeneratedColumn<bool>(
        'reminders_sleep_enabled',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("reminders_sleep_enabled" IN (0, 1))',
        ),
        defaultValue: const Constant(true),
      );
  static const VerificationMeta _sleepHourMeta = const VerificationMeta(
    'sleepHour',
  );
  @override
  late final GeneratedColumn<int> sleepHour = GeneratedColumn<int>(
    'sleep_hour',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(8),
  );
  static const VerificationMeta _sleepMinuteMeta = const VerificationMeta(
    'sleepMinute',
  );
  @override
  late final GeneratedColumn<int> sleepMinute = GeneratedColumn<int>(
    'sleep_minute',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _remindersWeatherEnabledMeta =
      const VerificationMeta('remindersWeatherEnabled');
  @override
  late final GeneratedColumn<bool> remindersWeatherEnabled =
      GeneratedColumn<bool>(
        'reminders_weather_enabled',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("reminders_weather_enabled" IN (0, 1))',
        ),
        defaultValue: const Constant(true),
      );
  static const VerificationMeta _remindersSymptomsEnabledMeta =
      const VerificationMeta('remindersSymptomsEnabled');
  @override
  late final GeneratedColumn<bool> remindersSymptomsEnabled =
      GeneratedColumn<bool>(
        'reminders_symptoms_enabled',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("reminders_symptoms_enabled" IN (0, 1))',
        ),
        defaultValue: const Constant(false),
      );
  static const VerificationMeta _symptomsHourMeta = const VerificationMeta(
    'symptomsHour',
  );
  @override
  late final GeneratedColumn<int> symptomsHour = GeneratedColumn<int>(
    'symptoms_hour',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(20),
  );
  static const VerificationMeta _symptomsMinuteMeta = const VerificationMeta(
    'symptomsMinute',
  );
  @override
  late final GeneratedColumn<int> symptomsMinute = GeneratedColumn<int>(
    'symptoms_minute',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _photoTagSuggestionsEnabledMeta =
      const VerificationMeta('photoTagSuggestionsEnabled');
  @override
  late final GeneratedColumn<bool> photoTagSuggestionsEnabled =
      GeneratedColumn<bool>(
        'photo_tag_suggestions_enabled',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("photo_tag_suggestions_enabled" IN (0, 1))',
        ),
        defaultValue: const Constant(true),
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    onboardingDone,
    lastPressureAlertDate,
    remindersMealsEnabled,
    breakfastHour,
    breakfastMinute,
    lunchHour,
    lunchMinute,
    dinnerHour,
    dinnerMinute,
    remindersSleepEnabled,
    sleepHour,
    sleepMinute,
    remindersWeatherEnabled,
    remindersSymptomsEnabled,
    symptomsHour,
    symptomsMinute,
    photoTagSuggestionsEnabled,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('onboarding_done')) {
      context.handle(
        _onboardingDoneMeta,
        onboardingDone.isAcceptableOrUnknown(
          data['onboarding_done']!,
          _onboardingDoneMeta,
        ),
      );
    }
    if (data.containsKey('last_pressure_alert_date')) {
      context.handle(
        _lastPressureAlertDateMeta,
        lastPressureAlertDate.isAcceptableOrUnknown(
          data['last_pressure_alert_date']!,
          _lastPressureAlertDateMeta,
        ),
      );
    }
    if (data.containsKey('reminders_meals_enabled')) {
      context.handle(
        _remindersMealsEnabledMeta,
        remindersMealsEnabled.isAcceptableOrUnknown(
          data['reminders_meals_enabled']!,
          _remindersMealsEnabledMeta,
        ),
      );
    }
    if (data.containsKey('breakfast_hour')) {
      context.handle(
        _breakfastHourMeta,
        breakfastHour.isAcceptableOrUnknown(
          data['breakfast_hour']!,
          _breakfastHourMeta,
        ),
      );
    }
    if (data.containsKey('breakfast_minute')) {
      context.handle(
        _breakfastMinuteMeta,
        breakfastMinute.isAcceptableOrUnknown(
          data['breakfast_minute']!,
          _breakfastMinuteMeta,
        ),
      );
    }
    if (data.containsKey('lunch_hour')) {
      context.handle(
        _lunchHourMeta,
        lunchHour.isAcceptableOrUnknown(data['lunch_hour']!, _lunchHourMeta),
      );
    }
    if (data.containsKey('lunch_minute')) {
      context.handle(
        _lunchMinuteMeta,
        lunchMinute.isAcceptableOrUnknown(
          data['lunch_minute']!,
          _lunchMinuteMeta,
        ),
      );
    }
    if (data.containsKey('dinner_hour')) {
      context.handle(
        _dinnerHourMeta,
        dinnerHour.isAcceptableOrUnknown(data['dinner_hour']!, _dinnerHourMeta),
      );
    }
    if (data.containsKey('dinner_minute')) {
      context.handle(
        _dinnerMinuteMeta,
        dinnerMinute.isAcceptableOrUnknown(
          data['dinner_minute']!,
          _dinnerMinuteMeta,
        ),
      );
    }
    if (data.containsKey('reminders_sleep_enabled')) {
      context.handle(
        _remindersSleepEnabledMeta,
        remindersSleepEnabled.isAcceptableOrUnknown(
          data['reminders_sleep_enabled']!,
          _remindersSleepEnabledMeta,
        ),
      );
    }
    if (data.containsKey('sleep_hour')) {
      context.handle(
        _sleepHourMeta,
        sleepHour.isAcceptableOrUnknown(data['sleep_hour']!, _sleepHourMeta),
      );
    }
    if (data.containsKey('sleep_minute')) {
      context.handle(
        _sleepMinuteMeta,
        sleepMinute.isAcceptableOrUnknown(
          data['sleep_minute']!,
          _sleepMinuteMeta,
        ),
      );
    }
    if (data.containsKey('reminders_weather_enabled')) {
      context.handle(
        _remindersWeatherEnabledMeta,
        remindersWeatherEnabled.isAcceptableOrUnknown(
          data['reminders_weather_enabled']!,
          _remindersWeatherEnabledMeta,
        ),
      );
    }
    if (data.containsKey('reminders_symptoms_enabled')) {
      context.handle(
        _remindersSymptomsEnabledMeta,
        remindersSymptomsEnabled.isAcceptableOrUnknown(
          data['reminders_symptoms_enabled']!,
          _remindersSymptomsEnabledMeta,
        ),
      );
    }
    if (data.containsKey('symptoms_hour')) {
      context.handle(
        _symptomsHourMeta,
        symptomsHour.isAcceptableOrUnknown(
          data['symptoms_hour']!,
          _symptomsHourMeta,
        ),
      );
    }
    if (data.containsKey('symptoms_minute')) {
      context.handle(
        _symptomsMinuteMeta,
        symptomsMinute.isAcceptableOrUnknown(
          data['symptoms_minute']!,
          _symptomsMinuteMeta,
        ),
      );
    }
    if (data.containsKey('photo_tag_suggestions_enabled')) {
      context.handle(
        _photoTagSuggestionsEnabledMeta,
        photoTagSuggestionsEnabled.isAcceptableOrUnknown(
          data['photo_tag_suggestions_enabled']!,
          _photoTagSuggestionsEnabledMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSetting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      onboardingDone: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}onboarding_done'],
      )!,
      lastPressureAlertDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_pressure_alert_date'],
      ),
      remindersMealsEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}reminders_meals_enabled'],
      )!,
      breakfastHour: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}breakfast_hour'],
      )!,
      breakfastMinute: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}breakfast_minute'],
      )!,
      lunchHour: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}lunch_hour'],
      )!,
      lunchMinute: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}lunch_minute'],
      )!,
      dinnerHour: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}dinner_hour'],
      )!,
      dinnerMinute: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}dinner_minute'],
      )!,
      remindersSleepEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}reminders_sleep_enabled'],
      )!,
      sleepHour: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sleep_hour'],
      )!,
      sleepMinute: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sleep_minute'],
      )!,
      remindersWeatherEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}reminders_weather_enabled'],
      )!,
      remindersSymptomsEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}reminders_symptoms_enabled'],
      )!,
      symptomsHour: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}symptoms_hour'],
      )!,
      symptomsMinute: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}symptoms_minute'],
      )!,
      photoTagSuggestionsEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}photo_tag_suggestions_enabled'],
      )!,
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class AppSetting extends DataClass implements Insertable<AppSetting> {
  final int id;
  final bool onboardingDone;
  final DateTime? lastPressureAlertDate;
  final bool remindersMealsEnabled;
  final int breakfastHour;
  final int breakfastMinute;
  final int lunchHour;
  final int lunchMinute;
  final int dinnerHour;
  final int dinnerMinute;
  final bool remindersSleepEnabled;
  final int sleepHour;
  final int sleepMinute;
  final bool remindersWeatherEnabled;

  /// Off by default: symptom check-in is more intrusive than the other
  /// reminders, so it's opt-in (US-16 acceptance criteria).
  final bool remindersSymptomsEnabled;
  final int symptomsHour;
  final int symptomsMinute;

  /// Whether photo-based tag suggestions (US-19, on-device) are enabled.
  final bool photoTagSuggestionsEnabled;
  const AppSetting({
    required this.id,
    required this.onboardingDone,
    this.lastPressureAlertDate,
    required this.remindersMealsEnabled,
    required this.breakfastHour,
    required this.breakfastMinute,
    required this.lunchHour,
    required this.lunchMinute,
    required this.dinnerHour,
    required this.dinnerMinute,
    required this.remindersSleepEnabled,
    required this.sleepHour,
    required this.sleepMinute,
    required this.remindersWeatherEnabled,
    required this.remindersSymptomsEnabled,
    required this.symptomsHour,
    required this.symptomsMinute,
    required this.photoTagSuggestionsEnabled,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['onboarding_done'] = Variable<bool>(onboardingDone);
    if (!nullToAbsent || lastPressureAlertDate != null) {
      map['last_pressure_alert_date'] = Variable<DateTime>(
        lastPressureAlertDate,
      );
    }
    map['reminders_meals_enabled'] = Variable<bool>(remindersMealsEnabled);
    map['breakfast_hour'] = Variable<int>(breakfastHour);
    map['breakfast_minute'] = Variable<int>(breakfastMinute);
    map['lunch_hour'] = Variable<int>(lunchHour);
    map['lunch_minute'] = Variable<int>(lunchMinute);
    map['dinner_hour'] = Variable<int>(dinnerHour);
    map['dinner_minute'] = Variable<int>(dinnerMinute);
    map['reminders_sleep_enabled'] = Variable<bool>(remindersSleepEnabled);
    map['sleep_hour'] = Variable<int>(sleepHour);
    map['sleep_minute'] = Variable<int>(sleepMinute);
    map['reminders_weather_enabled'] = Variable<bool>(remindersWeatherEnabled);
    map['reminders_symptoms_enabled'] = Variable<bool>(
      remindersSymptomsEnabled,
    );
    map['symptoms_hour'] = Variable<int>(symptomsHour);
    map['symptoms_minute'] = Variable<int>(symptomsMinute);
    map['photo_tag_suggestions_enabled'] = Variable<bool>(
      photoTagSuggestionsEnabled,
    );
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(
      id: Value(id),
      onboardingDone: Value(onboardingDone),
      lastPressureAlertDate: lastPressureAlertDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastPressureAlertDate),
      remindersMealsEnabled: Value(remindersMealsEnabled),
      breakfastHour: Value(breakfastHour),
      breakfastMinute: Value(breakfastMinute),
      lunchHour: Value(lunchHour),
      lunchMinute: Value(lunchMinute),
      dinnerHour: Value(dinnerHour),
      dinnerMinute: Value(dinnerMinute),
      remindersSleepEnabled: Value(remindersSleepEnabled),
      sleepHour: Value(sleepHour),
      sleepMinute: Value(sleepMinute),
      remindersWeatherEnabled: Value(remindersWeatherEnabled),
      remindersSymptomsEnabled: Value(remindersSymptomsEnabled),
      symptomsHour: Value(symptomsHour),
      symptomsMinute: Value(symptomsMinute),
      photoTagSuggestionsEnabled: Value(photoTagSuggestionsEnabled),
    );
  }

  factory AppSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSetting(
      id: serializer.fromJson<int>(json['id']),
      onboardingDone: serializer.fromJson<bool>(json['onboardingDone']),
      lastPressureAlertDate: serializer.fromJson<DateTime?>(
        json['lastPressureAlertDate'],
      ),
      remindersMealsEnabled: serializer.fromJson<bool>(
        json['remindersMealsEnabled'],
      ),
      breakfastHour: serializer.fromJson<int>(json['breakfastHour']),
      breakfastMinute: serializer.fromJson<int>(json['breakfastMinute']),
      lunchHour: serializer.fromJson<int>(json['lunchHour']),
      lunchMinute: serializer.fromJson<int>(json['lunchMinute']),
      dinnerHour: serializer.fromJson<int>(json['dinnerHour']),
      dinnerMinute: serializer.fromJson<int>(json['dinnerMinute']),
      remindersSleepEnabled: serializer.fromJson<bool>(
        json['remindersSleepEnabled'],
      ),
      sleepHour: serializer.fromJson<int>(json['sleepHour']),
      sleepMinute: serializer.fromJson<int>(json['sleepMinute']),
      remindersWeatherEnabled: serializer.fromJson<bool>(
        json['remindersWeatherEnabled'],
      ),
      remindersSymptomsEnabled: serializer.fromJson<bool>(
        json['remindersSymptomsEnabled'],
      ),
      symptomsHour: serializer.fromJson<int>(json['symptomsHour']),
      symptomsMinute: serializer.fromJson<int>(json['symptomsMinute']),
      photoTagSuggestionsEnabled: serializer.fromJson<bool>(
        json['photoTagSuggestionsEnabled'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'onboardingDone': serializer.toJson<bool>(onboardingDone),
      'lastPressureAlertDate': serializer.toJson<DateTime?>(
        lastPressureAlertDate,
      ),
      'remindersMealsEnabled': serializer.toJson<bool>(remindersMealsEnabled),
      'breakfastHour': serializer.toJson<int>(breakfastHour),
      'breakfastMinute': serializer.toJson<int>(breakfastMinute),
      'lunchHour': serializer.toJson<int>(lunchHour),
      'lunchMinute': serializer.toJson<int>(lunchMinute),
      'dinnerHour': serializer.toJson<int>(dinnerHour),
      'dinnerMinute': serializer.toJson<int>(dinnerMinute),
      'remindersSleepEnabled': serializer.toJson<bool>(remindersSleepEnabled),
      'sleepHour': serializer.toJson<int>(sleepHour),
      'sleepMinute': serializer.toJson<int>(sleepMinute),
      'remindersWeatherEnabled': serializer.toJson<bool>(
        remindersWeatherEnabled,
      ),
      'remindersSymptomsEnabled': serializer.toJson<bool>(
        remindersSymptomsEnabled,
      ),
      'symptomsHour': serializer.toJson<int>(symptomsHour),
      'symptomsMinute': serializer.toJson<int>(symptomsMinute),
      'photoTagSuggestionsEnabled': serializer.toJson<bool>(
        photoTagSuggestionsEnabled,
      ),
    };
  }

  AppSetting copyWith({
    int? id,
    bool? onboardingDone,
    Value<DateTime?> lastPressureAlertDate = const Value.absent(),
    bool? remindersMealsEnabled,
    int? breakfastHour,
    int? breakfastMinute,
    int? lunchHour,
    int? lunchMinute,
    int? dinnerHour,
    int? dinnerMinute,
    bool? remindersSleepEnabled,
    int? sleepHour,
    int? sleepMinute,
    bool? remindersWeatherEnabled,
    bool? remindersSymptomsEnabled,
    int? symptomsHour,
    int? symptomsMinute,
    bool? photoTagSuggestionsEnabled,
  }) => AppSetting(
    id: id ?? this.id,
    onboardingDone: onboardingDone ?? this.onboardingDone,
    lastPressureAlertDate: lastPressureAlertDate.present
        ? lastPressureAlertDate.value
        : this.lastPressureAlertDate,
    remindersMealsEnabled: remindersMealsEnabled ?? this.remindersMealsEnabled,
    breakfastHour: breakfastHour ?? this.breakfastHour,
    breakfastMinute: breakfastMinute ?? this.breakfastMinute,
    lunchHour: lunchHour ?? this.lunchHour,
    lunchMinute: lunchMinute ?? this.lunchMinute,
    dinnerHour: dinnerHour ?? this.dinnerHour,
    dinnerMinute: dinnerMinute ?? this.dinnerMinute,
    remindersSleepEnabled: remindersSleepEnabled ?? this.remindersSleepEnabled,
    sleepHour: sleepHour ?? this.sleepHour,
    sleepMinute: sleepMinute ?? this.sleepMinute,
    remindersWeatherEnabled:
        remindersWeatherEnabled ?? this.remindersWeatherEnabled,
    remindersSymptomsEnabled:
        remindersSymptomsEnabled ?? this.remindersSymptomsEnabled,
    symptomsHour: symptomsHour ?? this.symptomsHour,
    symptomsMinute: symptomsMinute ?? this.symptomsMinute,
    photoTagSuggestionsEnabled:
        photoTagSuggestionsEnabled ?? this.photoTagSuggestionsEnabled,
  );
  AppSetting copyWithCompanion(AppSettingsCompanion data) {
    return AppSetting(
      id: data.id.present ? data.id.value : this.id,
      onboardingDone: data.onboardingDone.present
          ? data.onboardingDone.value
          : this.onboardingDone,
      lastPressureAlertDate: data.lastPressureAlertDate.present
          ? data.lastPressureAlertDate.value
          : this.lastPressureAlertDate,
      remindersMealsEnabled: data.remindersMealsEnabled.present
          ? data.remindersMealsEnabled.value
          : this.remindersMealsEnabled,
      breakfastHour: data.breakfastHour.present
          ? data.breakfastHour.value
          : this.breakfastHour,
      breakfastMinute: data.breakfastMinute.present
          ? data.breakfastMinute.value
          : this.breakfastMinute,
      lunchHour: data.lunchHour.present ? data.lunchHour.value : this.lunchHour,
      lunchMinute: data.lunchMinute.present
          ? data.lunchMinute.value
          : this.lunchMinute,
      dinnerHour: data.dinnerHour.present
          ? data.dinnerHour.value
          : this.dinnerHour,
      dinnerMinute: data.dinnerMinute.present
          ? data.dinnerMinute.value
          : this.dinnerMinute,
      remindersSleepEnabled: data.remindersSleepEnabled.present
          ? data.remindersSleepEnabled.value
          : this.remindersSleepEnabled,
      sleepHour: data.sleepHour.present ? data.sleepHour.value : this.sleepHour,
      sleepMinute: data.sleepMinute.present
          ? data.sleepMinute.value
          : this.sleepMinute,
      remindersWeatherEnabled: data.remindersWeatherEnabled.present
          ? data.remindersWeatherEnabled.value
          : this.remindersWeatherEnabled,
      remindersSymptomsEnabled: data.remindersSymptomsEnabled.present
          ? data.remindersSymptomsEnabled.value
          : this.remindersSymptomsEnabled,
      symptomsHour: data.symptomsHour.present
          ? data.symptomsHour.value
          : this.symptomsHour,
      symptomsMinute: data.symptomsMinute.present
          ? data.symptomsMinute.value
          : this.symptomsMinute,
      photoTagSuggestionsEnabled: data.photoTagSuggestionsEnabled.present
          ? data.photoTagSuggestionsEnabled.value
          : this.photoTagSuggestionsEnabled,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSetting(')
          ..write('id: $id, ')
          ..write('onboardingDone: $onboardingDone, ')
          ..write('lastPressureAlertDate: $lastPressureAlertDate, ')
          ..write('remindersMealsEnabled: $remindersMealsEnabled, ')
          ..write('breakfastHour: $breakfastHour, ')
          ..write('breakfastMinute: $breakfastMinute, ')
          ..write('lunchHour: $lunchHour, ')
          ..write('lunchMinute: $lunchMinute, ')
          ..write('dinnerHour: $dinnerHour, ')
          ..write('dinnerMinute: $dinnerMinute, ')
          ..write('remindersSleepEnabled: $remindersSleepEnabled, ')
          ..write('sleepHour: $sleepHour, ')
          ..write('sleepMinute: $sleepMinute, ')
          ..write('remindersWeatherEnabled: $remindersWeatherEnabled, ')
          ..write('remindersSymptomsEnabled: $remindersSymptomsEnabled, ')
          ..write('symptomsHour: $symptomsHour, ')
          ..write('symptomsMinute: $symptomsMinute, ')
          ..write('photoTagSuggestionsEnabled: $photoTagSuggestionsEnabled')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    onboardingDone,
    lastPressureAlertDate,
    remindersMealsEnabled,
    breakfastHour,
    breakfastMinute,
    lunchHour,
    lunchMinute,
    dinnerHour,
    dinnerMinute,
    remindersSleepEnabled,
    sleepHour,
    sleepMinute,
    remindersWeatherEnabled,
    remindersSymptomsEnabled,
    symptomsHour,
    symptomsMinute,
    photoTagSuggestionsEnabled,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSetting &&
          other.id == this.id &&
          other.onboardingDone == this.onboardingDone &&
          other.lastPressureAlertDate == this.lastPressureAlertDate &&
          other.remindersMealsEnabled == this.remindersMealsEnabled &&
          other.breakfastHour == this.breakfastHour &&
          other.breakfastMinute == this.breakfastMinute &&
          other.lunchHour == this.lunchHour &&
          other.lunchMinute == this.lunchMinute &&
          other.dinnerHour == this.dinnerHour &&
          other.dinnerMinute == this.dinnerMinute &&
          other.remindersSleepEnabled == this.remindersSleepEnabled &&
          other.sleepHour == this.sleepHour &&
          other.sleepMinute == this.sleepMinute &&
          other.remindersWeatherEnabled == this.remindersWeatherEnabled &&
          other.remindersSymptomsEnabled == this.remindersSymptomsEnabled &&
          other.symptomsHour == this.symptomsHour &&
          other.symptomsMinute == this.symptomsMinute &&
          other.photoTagSuggestionsEnabled == this.photoTagSuggestionsEnabled);
}

class AppSettingsCompanion extends UpdateCompanion<AppSetting> {
  final Value<int> id;
  final Value<bool> onboardingDone;
  final Value<DateTime?> lastPressureAlertDate;
  final Value<bool> remindersMealsEnabled;
  final Value<int> breakfastHour;
  final Value<int> breakfastMinute;
  final Value<int> lunchHour;
  final Value<int> lunchMinute;
  final Value<int> dinnerHour;
  final Value<int> dinnerMinute;
  final Value<bool> remindersSleepEnabled;
  final Value<int> sleepHour;
  final Value<int> sleepMinute;
  final Value<bool> remindersWeatherEnabled;
  final Value<bool> remindersSymptomsEnabled;
  final Value<int> symptomsHour;
  final Value<int> symptomsMinute;
  final Value<bool> photoTagSuggestionsEnabled;
  const AppSettingsCompanion({
    this.id = const Value.absent(),
    this.onboardingDone = const Value.absent(),
    this.lastPressureAlertDate = const Value.absent(),
    this.remindersMealsEnabled = const Value.absent(),
    this.breakfastHour = const Value.absent(),
    this.breakfastMinute = const Value.absent(),
    this.lunchHour = const Value.absent(),
    this.lunchMinute = const Value.absent(),
    this.dinnerHour = const Value.absent(),
    this.dinnerMinute = const Value.absent(),
    this.remindersSleepEnabled = const Value.absent(),
    this.sleepHour = const Value.absent(),
    this.sleepMinute = const Value.absent(),
    this.remindersWeatherEnabled = const Value.absent(),
    this.remindersSymptomsEnabled = const Value.absent(),
    this.symptomsHour = const Value.absent(),
    this.symptomsMinute = const Value.absent(),
    this.photoTagSuggestionsEnabled = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    this.id = const Value.absent(),
    this.onboardingDone = const Value.absent(),
    this.lastPressureAlertDate = const Value.absent(),
    this.remindersMealsEnabled = const Value.absent(),
    this.breakfastHour = const Value.absent(),
    this.breakfastMinute = const Value.absent(),
    this.lunchHour = const Value.absent(),
    this.lunchMinute = const Value.absent(),
    this.dinnerHour = const Value.absent(),
    this.dinnerMinute = const Value.absent(),
    this.remindersSleepEnabled = const Value.absent(),
    this.sleepHour = const Value.absent(),
    this.sleepMinute = const Value.absent(),
    this.remindersWeatherEnabled = const Value.absent(),
    this.remindersSymptomsEnabled = const Value.absent(),
    this.symptomsHour = const Value.absent(),
    this.symptomsMinute = const Value.absent(),
    this.photoTagSuggestionsEnabled = const Value.absent(),
  });
  static Insertable<AppSetting> custom({
    Expression<int>? id,
    Expression<bool>? onboardingDone,
    Expression<DateTime>? lastPressureAlertDate,
    Expression<bool>? remindersMealsEnabled,
    Expression<int>? breakfastHour,
    Expression<int>? breakfastMinute,
    Expression<int>? lunchHour,
    Expression<int>? lunchMinute,
    Expression<int>? dinnerHour,
    Expression<int>? dinnerMinute,
    Expression<bool>? remindersSleepEnabled,
    Expression<int>? sleepHour,
    Expression<int>? sleepMinute,
    Expression<bool>? remindersWeatherEnabled,
    Expression<bool>? remindersSymptomsEnabled,
    Expression<int>? symptomsHour,
    Expression<int>? symptomsMinute,
    Expression<bool>? photoTagSuggestionsEnabled,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (onboardingDone != null) 'onboarding_done': onboardingDone,
      if (lastPressureAlertDate != null)
        'last_pressure_alert_date': lastPressureAlertDate,
      if (remindersMealsEnabled != null)
        'reminders_meals_enabled': remindersMealsEnabled,
      if (breakfastHour != null) 'breakfast_hour': breakfastHour,
      if (breakfastMinute != null) 'breakfast_minute': breakfastMinute,
      if (lunchHour != null) 'lunch_hour': lunchHour,
      if (lunchMinute != null) 'lunch_minute': lunchMinute,
      if (dinnerHour != null) 'dinner_hour': dinnerHour,
      if (dinnerMinute != null) 'dinner_minute': dinnerMinute,
      if (remindersSleepEnabled != null)
        'reminders_sleep_enabled': remindersSleepEnabled,
      if (sleepHour != null) 'sleep_hour': sleepHour,
      if (sleepMinute != null) 'sleep_minute': sleepMinute,
      if (remindersWeatherEnabled != null)
        'reminders_weather_enabled': remindersWeatherEnabled,
      if (remindersSymptomsEnabled != null)
        'reminders_symptoms_enabled': remindersSymptomsEnabled,
      if (symptomsHour != null) 'symptoms_hour': symptomsHour,
      if (symptomsMinute != null) 'symptoms_minute': symptomsMinute,
      if (photoTagSuggestionsEnabled != null)
        'photo_tag_suggestions_enabled': photoTagSuggestionsEnabled,
    });
  }

  AppSettingsCompanion copyWith({
    Value<int>? id,
    Value<bool>? onboardingDone,
    Value<DateTime?>? lastPressureAlertDate,
    Value<bool>? remindersMealsEnabled,
    Value<int>? breakfastHour,
    Value<int>? breakfastMinute,
    Value<int>? lunchHour,
    Value<int>? lunchMinute,
    Value<int>? dinnerHour,
    Value<int>? dinnerMinute,
    Value<bool>? remindersSleepEnabled,
    Value<int>? sleepHour,
    Value<int>? sleepMinute,
    Value<bool>? remindersWeatherEnabled,
    Value<bool>? remindersSymptomsEnabled,
    Value<int>? symptomsHour,
    Value<int>? symptomsMinute,
    Value<bool>? photoTagSuggestionsEnabled,
  }) {
    return AppSettingsCompanion(
      id: id ?? this.id,
      onboardingDone: onboardingDone ?? this.onboardingDone,
      lastPressureAlertDate:
          lastPressureAlertDate ?? this.lastPressureAlertDate,
      remindersMealsEnabled:
          remindersMealsEnabled ?? this.remindersMealsEnabled,
      breakfastHour: breakfastHour ?? this.breakfastHour,
      breakfastMinute: breakfastMinute ?? this.breakfastMinute,
      lunchHour: lunchHour ?? this.lunchHour,
      lunchMinute: lunchMinute ?? this.lunchMinute,
      dinnerHour: dinnerHour ?? this.dinnerHour,
      dinnerMinute: dinnerMinute ?? this.dinnerMinute,
      remindersSleepEnabled:
          remindersSleepEnabled ?? this.remindersSleepEnabled,
      sleepHour: sleepHour ?? this.sleepHour,
      sleepMinute: sleepMinute ?? this.sleepMinute,
      remindersWeatherEnabled:
          remindersWeatherEnabled ?? this.remindersWeatherEnabled,
      remindersSymptomsEnabled:
          remindersSymptomsEnabled ?? this.remindersSymptomsEnabled,
      symptomsHour: symptomsHour ?? this.symptomsHour,
      symptomsMinute: symptomsMinute ?? this.symptomsMinute,
      photoTagSuggestionsEnabled:
          photoTagSuggestionsEnabled ?? this.photoTagSuggestionsEnabled,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (onboardingDone.present) {
      map['onboarding_done'] = Variable<bool>(onboardingDone.value);
    }
    if (lastPressureAlertDate.present) {
      map['last_pressure_alert_date'] = Variable<DateTime>(
        lastPressureAlertDate.value,
      );
    }
    if (remindersMealsEnabled.present) {
      map['reminders_meals_enabled'] = Variable<bool>(
        remindersMealsEnabled.value,
      );
    }
    if (breakfastHour.present) {
      map['breakfast_hour'] = Variable<int>(breakfastHour.value);
    }
    if (breakfastMinute.present) {
      map['breakfast_minute'] = Variable<int>(breakfastMinute.value);
    }
    if (lunchHour.present) {
      map['lunch_hour'] = Variable<int>(lunchHour.value);
    }
    if (lunchMinute.present) {
      map['lunch_minute'] = Variable<int>(lunchMinute.value);
    }
    if (dinnerHour.present) {
      map['dinner_hour'] = Variable<int>(dinnerHour.value);
    }
    if (dinnerMinute.present) {
      map['dinner_minute'] = Variable<int>(dinnerMinute.value);
    }
    if (remindersSleepEnabled.present) {
      map['reminders_sleep_enabled'] = Variable<bool>(
        remindersSleepEnabled.value,
      );
    }
    if (sleepHour.present) {
      map['sleep_hour'] = Variable<int>(sleepHour.value);
    }
    if (sleepMinute.present) {
      map['sleep_minute'] = Variable<int>(sleepMinute.value);
    }
    if (remindersWeatherEnabled.present) {
      map['reminders_weather_enabled'] = Variable<bool>(
        remindersWeatherEnabled.value,
      );
    }
    if (remindersSymptomsEnabled.present) {
      map['reminders_symptoms_enabled'] = Variable<bool>(
        remindersSymptomsEnabled.value,
      );
    }
    if (symptomsHour.present) {
      map['symptoms_hour'] = Variable<int>(symptomsHour.value);
    }
    if (symptomsMinute.present) {
      map['symptoms_minute'] = Variable<int>(symptomsMinute.value);
    }
    if (photoTagSuggestionsEnabled.present) {
      map['photo_tag_suggestions_enabled'] = Variable<bool>(
        photoTagSuggestionsEnabled.value,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('id: $id, ')
          ..write('onboardingDone: $onboardingDone, ')
          ..write('lastPressureAlertDate: $lastPressureAlertDate, ')
          ..write('remindersMealsEnabled: $remindersMealsEnabled, ')
          ..write('breakfastHour: $breakfastHour, ')
          ..write('breakfastMinute: $breakfastMinute, ')
          ..write('lunchHour: $lunchHour, ')
          ..write('lunchMinute: $lunchMinute, ')
          ..write('dinnerHour: $dinnerHour, ')
          ..write('dinnerMinute: $dinnerMinute, ')
          ..write('remindersSleepEnabled: $remindersSleepEnabled, ')
          ..write('sleepHour: $sleepHour, ')
          ..write('sleepMinute: $sleepMinute, ')
          ..write('remindersWeatherEnabled: $remindersWeatherEnabled, ')
          ..write('remindersSymptomsEnabled: $remindersSymptomsEnabled, ')
          ..write('symptomsHour: $symptomsHour, ')
          ..write('symptomsMinute: $symptomsMinute, ')
          ..write('photoTagSuggestionsEnabled: $photoTagSuggestionsEnabled')
          ..write(')'))
        .toString();
  }
}

class $CloudBackupStatesTable extends CloudBackupStates
    with TableInfo<$CloudBackupStatesTable, CloudBackupState> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CloudBackupStatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastBackupAtMeta = const VerificationMeta(
    'lastBackupAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastBackupAt = GeneratedColumn<DateTime>(
    'last_backup_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hasRestoredOnThisDeviceMeta =
      const VerificationMeta('hasRestoredOnThisDevice');
  @override
  late final GeneratedColumn<bool> hasRestoredOnThisDevice =
      GeneratedColumn<bool>(
        'has_restored_on_this_device',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("has_restored_on_this_device" IN (0, 1))',
        ),
        defaultValue: const Constant(false),
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    lastBackupAt,
    hasRestoredOnThisDevice,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cloud_backup_states';
  @override
  VerificationContext validateIntegrity(
    Insertable<CloudBackupState> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('last_backup_at')) {
      context.handle(
        _lastBackupAtMeta,
        lastBackupAt.isAcceptableOrUnknown(
          data['last_backup_at']!,
          _lastBackupAtMeta,
        ),
      );
    }
    if (data.containsKey('has_restored_on_this_device')) {
      context.handle(
        _hasRestoredOnThisDeviceMeta,
        hasRestoredOnThisDevice.isAcceptableOrUnknown(
          data['has_restored_on_this_device']!,
          _hasRestoredOnThisDeviceMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CloudBackupState map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CloudBackupState(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      lastBackupAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_backup_at'],
      ),
      hasRestoredOnThisDevice: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}has_restored_on_this_device'],
      )!,
    );
  }

  @override
  $CloudBackupStatesTable createAlias(String alias) {
    return $CloudBackupStatesTable(attachedDatabase, alias);
  }
}

class CloudBackupState extends DataClass
    implements Insertable<CloudBackupState> {
  final int id;
  final DateTime? lastBackupAt;
  final bool hasRestoredOnThisDevice;
  const CloudBackupState({
    required this.id,
    this.lastBackupAt,
    required this.hasRestoredOnThisDevice,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || lastBackupAt != null) {
      map['last_backup_at'] = Variable<DateTime>(lastBackupAt);
    }
    map['has_restored_on_this_device'] = Variable<bool>(
      hasRestoredOnThisDevice,
    );
    return map;
  }

  CloudBackupStatesCompanion toCompanion(bool nullToAbsent) {
    return CloudBackupStatesCompanion(
      id: Value(id),
      lastBackupAt: lastBackupAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastBackupAt),
      hasRestoredOnThisDevice: Value(hasRestoredOnThisDevice),
    );
  }

  factory CloudBackupState.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CloudBackupState(
      id: serializer.fromJson<int>(json['id']),
      lastBackupAt: serializer.fromJson<DateTime?>(json['lastBackupAt']),
      hasRestoredOnThisDevice: serializer.fromJson<bool>(
        json['hasRestoredOnThisDevice'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'lastBackupAt': serializer.toJson<DateTime?>(lastBackupAt),
      'hasRestoredOnThisDevice': serializer.toJson<bool>(
        hasRestoredOnThisDevice,
      ),
    };
  }

  CloudBackupState copyWith({
    int? id,
    Value<DateTime?> lastBackupAt = const Value.absent(),
    bool? hasRestoredOnThisDevice,
  }) => CloudBackupState(
    id: id ?? this.id,
    lastBackupAt: lastBackupAt.present ? lastBackupAt.value : this.lastBackupAt,
    hasRestoredOnThisDevice:
        hasRestoredOnThisDevice ?? this.hasRestoredOnThisDevice,
  );
  CloudBackupState copyWithCompanion(CloudBackupStatesCompanion data) {
    return CloudBackupState(
      id: data.id.present ? data.id.value : this.id,
      lastBackupAt: data.lastBackupAt.present
          ? data.lastBackupAt.value
          : this.lastBackupAt,
      hasRestoredOnThisDevice: data.hasRestoredOnThisDevice.present
          ? data.hasRestoredOnThisDevice.value
          : this.hasRestoredOnThisDevice,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CloudBackupState(')
          ..write('id: $id, ')
          ..write('lastBackupAt: $lastBackupAt, ')
          ..write('hasRestoredOnThisDevice: $hasRestoredOnThisDevice')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, lastBackupAt, hasRestoredOnThisDevice);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CloudBackupState &&
          other.id == this.id &&
          other.lastBackupAt == this.lastBackupAt &&
          other.hasRestoredOnThisDevice == this.hasRestoredOnThisDevice);
}

class CloudBackupStatesCompanion extends UpdateCompanion<CloudBackupState> {
  final Value<int> id;
  final Value<DateTime?> lastBackupAt;
  final Value<bool> hasRestoredOnThisDevice;
  const CloudBackupStatesCompanion({
    this.id = const Value.absent(),
    this.lastBackupAt = const Value.absent(),
    this.hasRestoredOnThisDevice = const Value.absent(),
  });
  CloudBackupStatesCompanion.insert({
    this.id = const Value.absent(),
    this.lastBackupAt = const Value.absent(),
    this.hasRestoredOnThisDevice = const Value.absent(),
  });
  static Insertable<CloudBackupState> custom({
    Expression<int>? id,
    Expression<DateTime>? lastBackupAt,
    Expression<bool>? hasRestoredOnThisDevice,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lastBackupAt != null) 'last_backup_at': lastBackupAt,
      if (hasRestoredOnThisDevice != null)
        'has_restored_on_this_device': hasRestoredOnThisDevice,
    });
  }

  CloudBackupStatesCompanion copyWith({
    Value<int>? id,
    Value<DateTime?>? lastBackupAt,
    Value<bool>? hasRestoredOnThisDevice,
  }) {
    return CloudBackupStatesCompanion(
      id: id ?? this.id,
      lastBackupAt: lastBackupAt ?? this.lastBackupAt,
      hasRestoredOnThisDevice:
          hasRestoredOnThisDevice ?? this.hasRestoredOnThisDevice,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (lastBackupAt.present) {
      map['last_backup_at'] = Variable<DateTime>(lastBackupAt.value);
    }
    if (hasRestoredOnThisDevice.present) {
      map['has_restored_on_this_device'] = Variable<bool>(
        hasRestoredOnThisDevice.value,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CloudBackupStatesCompanion(')
          ..write('id: $id, ')
          ..write('lastBackupAt: $lastBackupAt, ')
          ..write('hasRestoredOnThisDevice: $hasRestoredOnThisDevice')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TagsTable tags = $TagsTable(this);
  late final $MealsTable meals = $MealsTable(this);
  late final $MealTagsTable mealTags = $MealTagsTable(this);
  late final $MealTemplatesTable mealTemplates = $MealTemplatesTable(this);
  late final $TemplateTagsTable templateTags = $TemplateTagsTable(this);
  late final $SymptomsTable symptoms = $SymptomsTable(this);
  late final $MigraineIntensityMeasurementsTable migraineIntensityMeasurements =
      $MigraineIntensityMeasurementsTable(this);
  late final $MedicationIntakesTable medicationIntakes =
      $MedicationIntakesTable(this);
  late final $SleepEntriesTable sleepEntries = $SleepEntriesTable(this);
  late final $EnvironmentSnapshotsTable environmentSnapshots =
      $EnvironmentSnapshotsTable(this);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  late final $CloudBackupStatesTable cloudBackupStates =
      $CloudBackupStatesTable(this);
  late final Index idxMealsTimestamp = Index(
    'idx_meals_timestamp',
    'CREATE INDEX idx_meals_timestamp ON meals (timestamp)',
  );
  late final Index idxSymptomsTimestamp = Index(
    'idx_symptoms_timestamp',
    'CREATE INDEX idx_symptoms_timestamp ON symptoms (timestamp)',
  );
  late final Index idxMigraineMeasurementsSymptomTimestamp = Index(
    'idx_migraine_measurements_symptom_timestamp',
    'CREATE INDEX idx_migraine_measurements_symptom_timestamp ON migraine_intensity_measurements (symptom_id, timestamp)',
  );
  late final Index idxMedicationIntakesTimestamp = Index(
    'idx_medication_intakes_timestamp',
    'CREATE INDEX idx_medication_intakes_timestamp ON medication_intakes (timestamp)',
  );
  late final Index idxEnvTimestamp = Index(
    'idx_env_timestamp',
    'CREATE INDEX idx_env_timestamp ON environment_snapshots (timestamp)',
  );
  late final TagsDao tagsDao = TagsDao(this as AppDatabase);
  late final MealsDao mealsDao = MealsDao(this as AppDatabase);
  late final TemplatesDao templatesDao = TemplatesDao(this as AppDatabase);
  late final SymptomsDao symptomsDao = SymptomsDao(this as AppDatabase);
  late final MigraineIntensityMeasurementsDao migraineIntensityMeasurementsDao =
      MigraineIntensityMeasurementsDao(this as AppDatabase);
  late final MedicationIntakesDao medicationIntakesDao = MedicationIntakesDao(
    this as AppDatabase,
  );
  late final SleepEntriesDao sleepEntriesDao = SleepEntriesDao(
    this as AppDatabase,
  );
  late final EnvironmentDao environmentDao = EnvironmentDao(
    this as AppDatabase,
  );
  late final AppSettingsDao appSettingsDao = AppSettingsDao(
    this as AppDatabase,
  );
  late final CloudBackupStateDao cloudBackupStateDao = CloudBackupStateDao(
    this as AppDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    tags,
    meals,
    mealTags,
    mealTemplates,
    templateTags,
    symptoms,
    migraineIntensityMeasurements,
    medicationIntakes,
    sleepEntries,
    environmentSnapshots,
    appSettings,
    cloudBackupStates,
    idxMealsTimestamp,
    idxSymptomsTimestamp,
    idxMigraineMeasurementsSymptomTimestamp,
    idxMedicationIntakesTimestamp,
    idxEnvTimestamp,
  ];
}

typedef $$TagsTableCreateCompanionBuilder =
    TagsCompanion Function({
      required String id,
      required String label,
      Value<String?> category,
      Value<bool> isSystem,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });
typedef $$TagsTableUpdateCompanionBuilder =
    TagsCompanion Function({
      Value<String> id,
      Value<String> label,
      Value<String?> category,
      Value<bool> isSystem,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });

class $$TagsTableFilterComposer extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableFilterComposer({
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

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSystem => $composableBuilder(
    column: $table.isSystem,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TagsTableOrderingComposer extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableOrderingComposer({
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

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSystem => $composableBuilder(
    column: $table.isSystem,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TagsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<bool> get isSystem =>
      $composableBuilder(column: $table.isSystem, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);
}

class $$TagsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TagsTable,
          Tag,
          $$TagsTableFilterComposer,
          $$TagsTableOrderingComposer,
          $$TagsTableAnnotationComposer,
          $$TagsTableCreateCompanionBuilder,
          $$TagsTableUpdateCompanionBuilder,
          (Tag, BaseReferences<_$AppDatabase, $TagsTable, Tag>),
          Tag,
          PrefetchHooks Function()
        > {
  $$TagsTableTableManager(_$AppDatabase db, $TagsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TagsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TagsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TagsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> label = const Value.absent(),
                Value<String?> category = const Value.absent(),
                Value<bool> isSystem = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TagsCompanion(
                id: id,
                label: label,
                category: category,
                isSystem: isSystem,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String label,
                Value<String?> category = const Value.absent(),
                Value<bool> isSystem = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TagsCompanion.insert(
                id: id,
                label: label,
                category: category,
                isSystem: isSystem,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TagsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TagsTable,
      Tag,
      $$TagsTableFilterComposer,
      $$TagsTableOrderingComposer,
      $$TagsTableAnnotationComposer,
      $$TagsTableCreateCompanionBuilder,
      $$TagsTableUpdateCompanionBuilder,
      (Tag, BaseReferences<_$AppDatabase, $TagsTable, Tag>),
      Tag,
      PrefetchHooks Function()
    >;
typedef $$MealsTableCreateCompanionBuilder =
    MealsCompanion Function({
      required String id,
      required DateTime timestamp,
      required MealType mealType,
      Value<String?> photoPath,
      Value<String?> note,
      Value<String?> templateId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });
typedef $$MealsTableUpdateCompanionBuilder =
    MealsCompanion Function({
      Value<String> id,
      Value<DateTime> timestamp,
      Value<MealType> mealType,
      Value<String?> photoPath,
      Value<String?> note,
      Value<String?> templateId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });

class $$MealsTableFilterComposer extends Composer<_$AppDatabase, $MealsTable> {
  $$MealsTableFilterComposer({
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

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<MealType, MealType, int> get mealType =>
      $composableBuilder(
        column: $table.mealType,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get templateId => $composableBuilder(
    column: $table.templateId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MealsTableOrderingComposer
    extends Composer<_$AppDatabase, $MealsTable> {
  $$MealsTableOrderingComposer({
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

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get mealType => $composableBuilder(
    column: $table.mealType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get templateId => $composableBuilder(
    column: $table.templateId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MealsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MealsTable> {
  $$MealsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumnWithTypeConverter<MealType, int> get mealType =>
      $composableBuilder(column: $table.mealType, builder: (column) => column);

  GeneratedColumn<String> get photoPath =>
      $composableBuilder(column: $table.photoPath, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get templateId => $composableBuilder(
    column: $table.templateId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);
}

class $$MealsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MealsTable,
          Meal,
          $$MealsTableFilterComposer,
          $$MealsTableOrderingComposer,
          $$MealsTableAnnotationComposer,
          $$MealsTableCreateCompanionBuilder,
          $$MealsTableUpdateCompanionBuilder,
          (Meal, BaseReferences<_$AppDatabase, $MealsTable, Meal>),
          Meal,
          PrefetchHooks Function()
        > {
  $$MealsTableTableManager(_$AppDatabase db, $MealsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MealsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MealsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MealsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<MealType> mealType = const Value.absent(),
                Value<String?> photoPath = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String?> templateId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MealsCompanion(
                id: id,
                timestamp: timestamp,
                mealType: mealType,
                photoPath: photoPath,
                note: note,
                templateId: templateId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime timestamp,
                required MealType mealType,
                Value<String?> photoPath = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String?> templateId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MealsCompanion.insert(
                id: id,
                timestamp: timestamp,
                mealType: mealType,
                photoPath: photoPath,
                note: note,
                templateId: templateId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MealsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MealsTable,
      Meal,
      $$MealsTableFilterComposer,
      $$MealsTableOrderingComposer,
      $$MealsTableAnnotationComposer,
      $$MealsTableCreateCompanionBuilder,
      $$MealsTableUpdateCompanionBuilder,
      (Meal, BaseReferences<_$AppDatabase, $MealsTable, Meal>),
      Meal,
      PrefetchHooks Function()
    >;
typedef $$MealTagsTableCreateCompanionBuilder =
    MealTagsCompanion Function({
      required String mealId,
      required String tagId,
      Value<int> rowid,
    });
typedef $$MealTagsTableUpdateCompanionBuilder =
    MealTagsCompanion Function({
      Value<String> mealId,
      Value<String> tagId,
      Value<int> rowid,
    });

class $$MealTagsTableFilterComposer
    extends Composer<_$AppDatabase, $MealTagsTable> {
  $$MealTagsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get mealId => $composableBuilder(
    column: $table.mealId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tagId => $composableBuilder(
    column: $table.tagId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MealTagsTableOrderingComposer
    extends Composer<_$AppDatabase, $MealTagsTable> {
  $$MealTagsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get mealId => $composableBuilder(
    column: $table.mealId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tagId => $composableBuilder(
    column: $table.tagId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MealTagsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MealTagsTable> {
  $$MealTagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get mealId =>
      $composableBuilder(column: $table.mealId, builder: (column) => column);

  GeneratedColumn<String> get tagId =>
      $composableBuilder(column: $table.tagId, builder: (column) => column);
}

class $$MealTagsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MealTagsTable,
          MealTag,
          $$MealTagsTableFilterComposer,
          $$MealTagsTableOrderingComposer,
          $$MealTagsTableAnnotationComposer,
          $$MealTagsTableCreateCompanionBuilder,
          $$MealTagsTableUpdateCompanionBuilder,
          (MealTag, BaseReferences<_$AppDatabase, $MealTagsTable, MealTag>),
          MealTag,
          PrefetchHooks Function()
        > {
  $$MealTagsTableTableManager(_$AppDatabase db, $MealTagsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MealTagsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MealTagsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MealTagsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> mealId = const Value.absent(),
                Value<String> tagId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) =>
                  MealTagsCompanion(mealId: mealId, tagId: tagId, rowid: rowid),
          createCompanionCallback:
              ({
                required String mealId,
                required String tagId,
                Value<int> rowid = const Value.absent(),
              }) => MealTagsCompanion.insert(
                mealId: mealId,
                tagId: tagId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MealTagsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MealTagsTable,
      MealTag,
      $$MealTagsTableFilterComposer,
      $$MealTagsTableOrderingComposer,
      $$MealTagsTableAnnotationComposer,
      $$MealTagsTableCreateCompanionBuilder,
      $$MealTagsTableUpdateCompanionBuilder,
      (MealTag, BaseReferences<_$AppDatabase, $MealTagsTable, MealTag>),
      MealTag,
      PrefetchHooks Function()
    >;
typedef $$MealTemplatesTableCreateCompanionBuilder =
    MealTemplatesCompanion Function({
      required String id,
      required String name,
      Value<String?> defaultPhotoPath,
      Value<String?> defaultMealType,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });
typedef $$MealTemplatesTableUpdateCompanionBuilder =
    MealTemplatesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String?> defaultPhotoPath,
      Value<String?> defaultMealType,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });

class $$MealTemplatesTableFilterComposer
    extends Composer<_$AppDatabase, $MealTemplatesTable> {
  $$MealTemplatesTableFilterComposer({
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

  ColumnFilters<String> get defaultPhotoPath => $composableBuilder(
    column: $table.defaultPhotoPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get defaultMealType => $composableBuilder(
    column: $table.defaultMealType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MealTemplatesTableOrderingComposer
    extends Composer<_$AppDatabase, $MealTemplatesTable> {
  $$MealTemplatesTableOrderingComposer({
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

  ColumnOrderings<String> get defaultPhotoPath => $composableBuilder(
    column: $table.defaultPhotoPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get defaultMealType => $composableBuilder(
    column: $table.defaultMealType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MealTemplatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MealTemplatesTable> {
  $$MealTemplatesTableAnnotationComposer({
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

  GeneratedColumn<String> get defaultPhotoPath => $composableBuilder(
    column: $table.defaultPhotoPath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get defaultMealType => $composableBuilder(
    column: $table.defaultMealType,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);
}

class $$MealTemplatesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MealTemplatesTable,
          MealTemplate,
          $$MealTemplatesTableFilterComposer,
          $$MealTemplatesTableOrderingComposer,
          $$MealTemplatesTableAnnotationComposer,
          $$MealTemplatesTableCreateCompanionBuilder,
          $$MealTemplatesTableUpdateCompanionBuilder,
          (
            MealTemplate,
            BaseReferences<_$AppDatabase, $MealTemplatesTable, MealTemplate>,
          ),
          MealTemplate,
          PrefetchHooks Function()
        > {
  $$MealTemplatesTableTableManager(_$AppDatabase db, $MealTemplatesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MealTemplatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MealTemplatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MealTemplatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> defaultPhotoPath = const Value.absent(),
                Value<String?> defaultMealType = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MealTemplatesCompanion(
                id: id,
                name: name,
                defaultPhotoPath: defaultPhotoPath,
                defaultMealType: defaultMealType,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> defaultPhotoPath = const Value.absent(),
                Value<String?> defaultMealType = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MealTemplatesCompanion.insert(
                id: id,
                name: name,
                defaultPhotoPath: defaultPhotoPath,
                defaultMealType: defaultMealType,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MealTemplatesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MealTemplatesTable,
      MealTemplate,
      $$MealTemplatesTableFilterComposer,
      $$MealTemplatesTableOrderingComposer,
      $$MealTemplatesTableAnnotationComposer,
      $$MealTemplatesTableCreateCompanionBuilder,
      $$MealTemplatesTableUpdateCompanionBuilder,
      (
        MealTemplate,
        BaseReferences<_$AppDatabase, $MealTemplatesTable, MealTemplate>,
      ),
      MealTemplate,
      PrefetchHooks Function()
    >;
typedef $$TemplateTagsTableCreateCompanionBuilder =
    TemplateTagsCompanion Function({
      required String templateId,
      required String tagId,
      Value<int> rowid,
    });
typedef $$TemplateTagsTableUpdateCompanionBuilder =
    TemplateTagsCompanion Function({
      Value<String> templateId,
      Value<String> tagId,
      Value<int> rowid,
    });

class $$TemplateTagsTableFilterComposer
    extends Composer<_$AppDatabase, $TemplateTagsTable> {
  $$TemplateTagsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get templateId => $composableBuilder(
    column: $table.templateId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tagId => $composableBuilder(
    column: $table.tagId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TemplateTagsTableOrderingComposer
    extends Composer<_$AppDatabase, $TemplateTagsTable> {
  $$TemplateTagsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get templateId => $composableBuilder(
    column: $table.templateId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tagId => $composableBuilder(
    column: $table.tagId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TemplateTagsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TemplateTagsTable> {
  $$TemplateTagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get templateId => $composableBuilder(
    column: $table.templateId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tagId =>
      $composableBuilder(column: $table.tagId, builder: (column) => column);
}

class $$TemplateTagsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TemplateTagsTable,
          TemplateTag,
          $$TemplateTagsTableFilterComposer,
          $$TemplateTagsTableOrderingComposer,
          $$TemplateTagsTableAnnotationComposer,
          $$TemplateTagsTableCreateCompanionBuilder,
          $$TemplateTagsTableUpdateCompanionBuilder,
          (
            TemplateTag,
            BaseReferences<_$AppDatabase, $TemplateTagsTable, TemplateTag>,
          ),
          TemplateTag,
          PrefetchHooks Function()
        > {
  $$TemplateTagsTableTableManager(_$AppDatabase db, $TemplateTagsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TemplateTagsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TemplateTagsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TemplateTagsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> templateId = const Value.absent(),
                Value<String> tagId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TemplateTagsCompanion(
                templateId: templateId,
                tagId: tagId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String templateId,
                required String tagId,
                Value<int> rowid = const Value.absent(),
              }) => TemplateTagsCompanion.insert(
                templateId: templateId,
                tagId: tagId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TemplateTagsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TemplateTagsTable,
      TemplateTag,
      $$TemplateTagsTableFilterComposer,
      $$TemplateTagsTableOrderingComposer,
      $$TemplateTagsTableAnnotationComposer,
      $$TemplateTagsTableCreateCompanionBuilder,
      $$TemplateTagsTableUpdateCompanionBuilder,
      (
        TemplateTag,
        BaseReferences<_$AppDatabase, $TemplateTagsTable, TemplateTag>,
      ),
      TemplateTag,
      PrefetchHooks Function()
    >;
typedef $$SymptomsTableCreateCompanionBuilder =
    SymptomsCompanion Function({
      required String id,
      required DateTime timestamp,
      required SymptomType type,
      Value<int?> intensity,
      Value<String?> detail,
      Value<DateTime?> endTime,
      Value<DateTime?> startedAt,
      Value<MigraineStartPrecision?> startPrecision,
      Value<DateTime?> endedAt,
      Value<int?> initialIntensity,
      Value<int?> maximumIntensity,
      Value<String?> note,
      Value<DateTime?> dailyDate,
      Value<bool> isDailyNote,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });
typedef $$SymptomsTableUpdateCompanionBuilder =
    SymptomsCompanion Function({
      Value<String> id,
      Value<DateTime> timestamp,
      Value<SymptomType> type,
      Value<int?> intensity,
      Value<String?> detail,
      Value<DateTime?> endTime,
      Value<DateTime?> startedAt,
      Value<MigraineStartPrecision?> startPrecision,
      Value<DateTime?> endedAt,
      Value<int?> initialIntensity,
      Value<int?> maximumIntensity,
      Value<String?> note,
      Value<DateTime?> dailyDate,
      Value<bool> isDailyNote,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });

final class $$SymptomsTableReferences
    extends BaseReferences<_$AppDatabase, $SymptomsTable, Symptom> {
  $$SymptomsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<
    $MigraineIntensityMeasurementsTable,
    List<MigraineIntensityMeasurement>
  >
  _migraineIntensityMeasurementsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.migraineIntensityMeasurements,
        aliasName: $_aliasNameGenerator(
          db.symptoms.id,
          db.migraineIntensityMeasurements.symptomId,
        ),
      );

  $$MigraineIntensityMeasurementsTableProcessedTableManager
  get migraineIntensityMeasurementsRefs {
    final manager = $$MigraineIntensityMeasurementsTableTableManager(
      $_db,
      $_db.migraineIntensityMeasurements,
    ).filter((f) => f.symptomId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _migraineIntensityMeasurementsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MedicationIntakesTable, List<MedicationIntake>>
  _medicationIntakesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.medicationIntakes,
        aliasName: $_aliasNameGenerator(
          db.symptoms.id,
          db.medicationIntakes.symptomId,
        ),
      );

  $$MedicationIntakesTableProcessedTableManager get medicationIntakesRefs {
    final manager = $$MedicationIntakesTableTableManager(
      $_db,
      $_db.medicationIntakes,
    ).filter((f) => f.symptomId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _medicationIntakesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SymptomsTableFilterComposer
    extends Composer<_$AppDatabase, $SymptomsTable> {
  $$SymptomsTableFilterComposer({
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

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SymptomType, SymptomType, int> get type =>
      $composableBuilder(
        column: $table.type,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get intensity => $composableBuilder(
    column: $table.intensity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get detail => $composableBuilder(
    column: $table.detail,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    MigraineStartPrecision?,
    MigraineStartPrecision,
    int
  >
  get startPrecision => $composableBuilder(
    column: $table.startPrecision,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get initialIntensity => $composableBuilder(
    column: $table.initialIntensity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maximumIntensity => $composableBuilder(
    column: $table.maximumIntensity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dailyDate => $composableBuilder(
    column: $table.dailyDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDailyNote => $composableBuilder(
    column: $table.isDailyNote,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> migraineIntensityMeasurementsRefs(
    Expression<bool> Function(
      $$MigraineIntensityMeasurementsTableFilterComposer f,
    )
    f,
  ) {
    final $$MigraineIntensityMeasurementsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.migraineIntensityMeasurements,
          getReferencedColumn: (t) => t.symptomId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MigraineIntensityMeasurementsTableFilterComposer(
                $db: $db,
                $table: $db.migraineIntensityMeasurements,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> medicationIntakesRefs(
    Expression<bool> Function($$MedicationIntakesTableFilterComposer f) f,
  ) {
    final $$MedicationIntakesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.medicationIntakes,
      getReferencedColumn: (t) => t.symptomId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MedicationIntakesTableFilterComposer(
            $db: $db,
            $table: $db.medicationIntakes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SymptomsTableOrderingComposer
    extends Composer<_$AppDatabase, $SymptomsTable> {
  $$SymptomsTableOrderingComposer({
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

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get intensity => $composableBuilder(
    column: $table.intensity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get detail => $composableBuilder(
    column: $table.detail,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startPrecision => $composableBuilder(
    column: $table.startPrecision,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get initialIntensity => $composableBuilder(
    column: $table.initialIntensity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maximumIntensity => $composableBuilder(
    column: $table.maximumIntensity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dailyDate => $composableBuilder(
    column: $table.dailyDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDailyNote => $composableBuilder(
    column: $table.isDailyNote,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SymptomsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SymptomsTable> {
  $$SymptomsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SymptomType, int> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get intensity =>
      $composableBuilder(column: $table.intensity, builder: (column) => column);

  GeneratedColumn<String> get detail =>
      $composableBuilder(column: $table.detail, builder: (column) => column);

  GeneratedColumn<DateTime> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumnWithTypeConverter<MigraineStartPrecision?, int>
  get startPrecision => $composableBuilder(
    column: $table.startPrecision,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get endedAt =>
      $composableBuilder(column: $table.endedAt, builder: (column) => column);

  GeneratedColumn<int> get initialIntensity => $composableBuilder(
    column: $table.initialIntensity,
    builder: (column) => column,
  );

  GeneratedColumn<int> get maximumIntensity => $composableBuilder(
    column: $table.maximumIntensity,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get dailyDate =>
      $composableBuilder(column: $table.dailyDate, builder: (column) => column);

  GeneratedColumn<bool> get isDailyNote => $composableBuilder(
    column: $table.isDailyNote,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  Expression<T> migraineIntensityMeasurementsRefs<T extends Object>(
    Expression<T> Function(
      $$MigraineIntensityMeasurementsTableAnnotationComposer a,
    )
    f,
  ) {
    final $$MigraineIntensityMeasurementsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.migraineIntensityMeasurements,
          getReferencedColumn: (t) => t.symptomId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MigraineIntensityMeasurementsTableAnnotationComposer(
                $db: $db,
                $table: $db.migraineIntensityMeasurements,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> medicationIntakesRefs<T extends Object>(
    Expression<T> Function($$MedicationIntakesTableAnnotationComposer a) f,
  ) {
    final $$MedicationIntakesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.medicationIntakes,
          getReferencedColumn: (t) => t.symptomId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MedicationIntakesTableAnnotationComposer(
                $db: $db,
                $table: $db.medicationIntakes,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$SymptomsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SymptomsTable,
          Symptom,
          $$SymptomsTableFilterComposer,
          $$SymptomsTableOrderingComposer,
          $$SymptomsTableAnnotationComposer,
          $$SymptomsTableCreateCompanionBuilder,
          $$SymptomsTableUpdateCompanionBuilder,
          (Symptom, $$SymptomsTableReferences),
          Symptom,
          PrefetchHooks Function({
            bool migraineIntensityMeasurementsRefs,
            bool medicationIntakesRefs,
          })
        > {
  $$SymptomsTableTableManager(_$AppDatabase db, $SymptomsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SymptomsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SymptomsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SymptomsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<SymptomType> type = const Value.absent(),
                Value<int?> intensity = const Value.absent(),
                Value<String?> detail = const Value.absent(),
                Value<DateTime?> endTime = const Value.absent(),
                Value<DateTime?> startedAt = const Value.absent(),
                Value<MigraineStartPrecision?> startPrecision =
                    const Value.absent(),
                Value<DateTime?> endedAt = const Value.absent(),
                Value<int?> initialIntensity = const Value.absent(),
                Value<int?> maximumIntensity = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime?> dailyDate = const Value.absent(),
                Value<bool> isDailyNote = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SymptomsCompanion(
                id: id,
                timestamp: timestamp,
                type: type,
                intensity: intensity,
                detail: detail,
                endTime: endTime,
                startedAt: startedAt,
                startPrecision: startPrecision,
                endedAt: endedAt,
                initialIntensity: initialIntensity,
                maximumIntensity: maximumIntensity,
                note: note,
                dailyDate: dailyDate,
                isDailyNote: isDailyNote,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime timestamp,
                required SymptomType type,
                Value<int?> intensity = const Value.absent(),
                Value<String?> detail = const Value.absent(),
                Value<DateTime?> endTime = const Value.absent(),
                Value<DateTime?> startedAt = const Value.absent(),
                Value<MigraineStartPrecision?> startPrecision =
                    const Value.absent(),
                Value<DateTime?> endedAt = const Value.absent(),
                Value<int?> initialIntensity = const Value.absent(),
                Value<int?> maximumIntensity = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime?> dailyDate = const Value.absent(),
                Value<bool> isDailyNote = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SymptomsCompanion.insert(
                id: id,
                timestamp: timestamp,
                type: type,
                intensity: intensity,
                detail: detail,
                endTime: endTime,
                startedAt: startedAt,
                startPrecision: startPrecision,
                endedAt: endedAt,
                initialIntensity: initialIntensity,
                maximumIntensity: maximumIntensity,
                note: note,
                dailyDate: dailyDate,
                isDailyNote: isDailyNote,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SymptomsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                migraineIntensityMeasurementsRefs = false,
                medicationIntakesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (migraineIntensityMeasurementsRefs)
                      db.migraineIntensityMeasurements,
                    if (medicationIntakesRefs) db.medicationIntakes,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (migraineIntensityMeasurementsRefs)
                        await $_getPrefetchedData<
                          Symptom,
                          $SymptomsTable,
                          MigraineIntensityMeasurement
                        >(
                          currentTable: table,
                          referencedTable: $$SymptomsTableReferences
                              ._migraineIntensityMeasurementsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SymptomsTableReferences(
                                db,
                                table,
                                p0,
                              ).migraineIntensityMeasurementsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.symptomId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (medicationIntakesRefs)
                        await $_getPrefetchedData<
                          Symptom,
                          $SymptomsTable,
                          MedicationIntake
                        >(
                          currentTable: table,
                          referencedTable: $$SymptomsTableReferences
                              ._medicationIntakesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SymptomsTableReferences(
                                db,
                                table,
                                p0,
                              ).medicationIntakesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.symptomId == item.id,
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

typedef $$SymptomsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SymptomsTable,
      Symptom,
      $$SymptomsTableFilterComposer,
      $$SymptomsTableOrderingComposer,
      $$SymptomsTableAnnotationComposer,
      $$SymptomsTableCreateCompanionBuilder,
      $$SymptomsTableUpdateCompanionBuilder,
      (Symptom, $$SymptomsTableReferences),
      Symptom,
      PrefetchHooks Function({
        bool migraineIntensityMeasurementsRefs,
        bool medicationIntakesRefs,
      })
    >;
typedef $$MigraineIntensityMeasurementsTableCreateCompanionBuilder =
    MigraineIntensityMeasurementsCompanion Function({
      required String id,
      required String symptomId,
      required DateTime timestamp,
      required int intensity,
      Value<MigraineLaterality?> laterality,
      Value<MigraineLocation?> location,
      Value<bool?> aura,
      Value<bool?> nausea,
      Value<bool?> photophobia,
      Value<bool?> phonophobia,
      Value<String?> note,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });
typedef $$MigraineIntensityMeasurementsTableUpdateCompanionBuilder =
    MigraineIntensityMeasurementsCompanion Function({
      Value<String> id,
      Value<String> symptomId,
      Value<DateTime> timestamp,
      Value<int> intensity,
      Value<MigraineLaterality?> laterality,
      Value<MigraineLocation?> location,
      Value<bool?> aura,
      Value<bool?> nausea,
      Value<bool?> photophobia,
      Value<bool?> phonophobia,
      Value<String?> note,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });

final class $$MigraineIntensityMeasurementsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $MigraineIntensityMeasurementsTable,
          MigraineIntensityMeasurement
        > {
  $$MigraineIntensityMeasurementsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SymptomsTable _symptomIdTable(_$AppDatabase db) =>
      db.symptoms.createAlias(
        $_aliasNameGenerator(
          db.migraineIntensityMeasurements.symptomId,
          db.symptoms.id,
        ),
      );

  $$SymptomsTableProcessedTableManager get symptomId {
    final $_column = $_itemColumn<String>('symptom_id')!;

    final manager = $$SymptomsTableTableManager(
      $_db,
      $_db.symptoms,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_symptomIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MigraineIntensityMeasurementsTableFilterComposer
    extends Composer<_$AppDatabase, $MigraineIntensityMeasurementsTable> {
  $$MigraineIntensityMeasurementsTableFilterComposer({
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

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get intensity => $composableBuilder(
    column: $table.intensity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<MigraineLaterality?, MigraineLaterality, int>
  get laterality => $composableBuilder(
    column: $table.laterality,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<MigraineLocation?, MigraineLocation, int>
  get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<bool> get aura => $composableBuilder(
    column: $table.aura,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get nausea => $composableBuilder(
    column: $table.nausea,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get photophobia => $composableBuilder(
    column: $table.photophobia,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get phonophobia => $composableBuilder(
    column: $table.phonophobia,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$SymptomsTableFilterComposer get symptomId {
    final $$SymptomsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.symptomId,
      referencedTable: $db.symptoms,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SymptomsTableFilterComposer(
            $db: $db,
            $table: $db.symptoms,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MigraineIntensityMeasurementsTableOrderingComposer
    extends Composer<_$AppDatabase, $MigraineIntensityMeasurementsTable> {
  $$MigraineIntensityMeasurementsTableOrderingComposer({
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

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get intensity => $composableBuilder(
    column: $table.intensity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get laterality => $composableBuilder(
    column: $table.laterality,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get aura => $composableBuilder(
    column: $table.aura,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get nausea => $composableBuilder(
    column: $table.nausea,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get photophobia => $composableBuilder(
    column: $table.photophobia,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get phonophobia => $composableBuilder(
    column: $table.phonophobia,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$SymptomsTableOrderingComposer get symptomId {
    final $$SymptomsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.symptomId,
      referencedTable: $db.symptoms,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SymptomsTableOrderingComposer(
            $db: $db,
            $table: $db.symptoms,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MigraineIntensityMeasurementsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MigraineIntensityMeasurementsTable> {
  $$MigraineIntensityMeasurementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<int> get intensity =>
      $composableBuilder(column: $table.intensity, builder: (column) => column);

  GeneratedColumnWithTypeConverter<MigraineLaterality?, int> get laterality =>
      $composableBuilder(
        column: $table.laterality,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<MigraineLocation?, int> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<bool> get aura =>
      $composableBuilder(column: $table.aura, builder: (column) => column);

  GeneratedColumn<bool> get nausea =>
      $composableBuilder(column: $table.nausea, builder: (column) => column);

  GeneratedColumn<bool> get photophobia => $composableBuilder(
    column: $table.photophobia,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get phonophobia => $composableBuilder(
    column: $table.phonophobia,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$SymptomsTableAnnotationComposer get symptomId {
    final $$SymptomsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.symptomId,
      referencedTable: $db.symptoms,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SymptomsTableAnnotationComposer(
            $db: $db,
            $table: $db.symptoms,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MigraineIntensityMeasurementsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MigraineIntensityMeasurementsTable,
          MigraineIntensityMeasurement,
          $$MigraineIntensityMeasurementsTableFilterComposer,
          $$MigraineIntensityMeasurementsTableOrderingComposer,
          $$MigraineIntensityMeasurementsTableAnnotationComposer,
          $$MigraineIntensityMeasurementsTableCreateCompanionBuilder,
          $$MigraineIntensityMeasurementsTableUpdateCompanionBuilder,
          (
            MigraineIntensityMeasurement,
            $$MigraineIntensityMeasurementsTableReferences,
          ),
          MigraineIntensityMeasurement,
          PrefetchHooks Function({bool symptomId})
        > {
  $$MigraineIntensityMeasurementsTableTableManager(
    _$AppDatabase db,
    $MigraineIntensityMeasurementsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MigraineIntensityMeasurementsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$MigraineIntensityMeasurementsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$MigraineIntensityMeasurementsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> symptomId = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<int> intensity = const Value.absent(),
                Value<MigraineLaterality?> laterality = const Value.absent(),
                Value<MigraineLocation?> location = const Value.absent(),
                Value<bool?> aura = const Value.absent(),
                Value<bool?> nausea = const Value.absent(),
                Value<bool?> photophobia = const Value.absent(),
                Value<bool?> phonophobia = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MigraineIntensityMeasurementsCompanion(
                id: id,
                symptomId: symptomId,
                timestamp: timestamp,
                intensity: intensity,
                laterality: laterality,
                location: location,
                aura: aura,
                nausea: nausea,
                photophobia: photophobia,
                phonophobia: phonophobia,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String symptomId,
                required DateTime timestamp,
                required int intensity,
                Value<MigraineLaterality?> laterality = const Value.absent(),
                Value<MigraineLocation?> location = const Value.absent(),
                Value<bool?> aura = const Value.absent(),
                Value<bool?> nausea = const Value.absent(),
                Value<bool?> photophobia = const Value.absent(),
                Value<bool?> phonophobia = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MigraineIntensityMeasurementsCompanion.insert(
                id: id,
                symptomId: symptomId,
                timestamp: timestamp,
                intensity: intensity,
                laterality: laterality,
                location: location,
                aura: aura,
                nausea: nausea,
                photophobia: photophobia,
                phonophobia: phonophobia,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MigraineIntensityMeasurementsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({symptomId = false}) {
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
                    if (symptomId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.symptomId,
                                referencedTable:
                                    $$MigraineIntensityMeasurementsTableReferences
                                        ._symptomIdTable(db),
                                referencedColumn:
                                    $$MigraineIntensityMeasurementsTableReferences
                                        ._symptomIdTable(db)
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

typedef $$MigraineIntensityMeasurementsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MigraineIntensityMeasurementsTable,
      MigraineIntensityMeasurement,
      $$MigraineIntensityMeasurementsTableFilterComposer,
      $$MigraineIntensityMeasurementsTableOrderingComposer,
      $$MigraineIntensityMeasurementsTableAnnotationComposer,
      $$MigraineIntensityMeasurementsTableCreateCompanionBuilder,
      $$MigraineIntensityMeasurementsTableUpdateCompanionBuilder,
      (
        MigraineIntensityMeasurement,
        $$MigraineIntensityMeasurementsTableReferences,
      ),
      MigraineIntensityMeasurement,
      PrefetchHooks Function({bool symptomId})
    >;
typedef $$MedicationIntakesTableCreateCompanionBuilder =
    MedicationIntakesCompanion Function({
      required String id,
      required DateTime timestamp,
      required String name,
      Value<String?> dose,
      Value<String?> symptomId,
      Value<String?> note,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });
typedef $$MedicationIntakesTableUpdateCompanionBuilder =
    MedicationIntakesCompanion Function({
      Value<String> id,
      Value<DateTime> timestamp,
      Value<String> name,
      Value<String?> dose,
      Value<String?> symptomId,
      Value<String?> note,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });

final class $$MedicationIntakesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $MedicationIntakesTable,
          MedicationIntake
        > {
  $$MedicationIntakesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SymptomsTable _symptomIdTable(_$AppDatabase db) =>
      db.symptoms.createAlias(
        $_aliasNameGenerator(db.medicationIntakes.symptomId, db.symptoms.id),
      );

  $$SymptomsTableProcessedTableManager? get symptomId {
    final $_column = $_itemColumn<String>('symptom_id');
    if ($_column == null) return null;
    final manager = $$SymptomsTableTableManager(
      $_db,
      $_db.symptoms,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_symptomIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MedicationIntakesTableFilterComposer
    extends Composer<_$AppDatabase, $MedicationIntakesTable> {
  $$MedicationIntakesTableFilterComposer({
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

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dose => $composableBuilder(
    column: $table.dose,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$SymptomsTableFilterComposer get symptomId {
    final $$SymptomsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.symptomId,
      referencedTable: $db.symptoms,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SymptomsTableFilterComposer(
            $db: $db,
            $table: $db.symptoms,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MedicationIntakesTableOrderingComposer
    extends Composer<_$AppDatabase, $MedicationIntakesTable> {
  $$MedicationIntakesTableOrderingComposer({
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

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dose => $composableBuilder(
    column: $table.dose,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$SymptomsTableOrderingComposer get symptomId {
    final $$SymptomsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.symptomId,
      referencedTable: $db.symptoms,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SymptomsTableOrderingComposer(
            $db: $db,
            $table: $db.symptoms,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MedicationIntakesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MedicationIntakesTable> {
  $$MedicationIntakesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get dose =>
      $composableBuilder(column: $table.dose, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$SymptomsTableAnnotationComposer get symptomId {
    final $$SymptomsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.symptomId,
      referencedTable: $db.symptoms,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SymptomsTableAnnotationComposer(
            $db: $db,
            $table: $db.symptoms,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MedicationIntakesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MedicationIntakesTable,
          MedicationIntake,
          $$MedicationIntakesTableFilterComposer,
          $$MedicationIntakesTableOrderingComposer,
          $$MedicationIntakesTableAnnotationComposer,
          $$MedicationIntakesTableCreateCompanionBuilder,
          $$MedicationIntakesTableUpdateCompanionBuilder,
          (MedicationIntake, $$MedicationIntakesTableReferences),
          MedicationIntake,
          PrefetchHooks Function({bool symptomId})
        > {
  $$MedicationIntakesTableTableManager(
    _$AppDatabase db,
    $MedicationIntakesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MedicationIntakesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MedicationIntakesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MedicationIntakesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> dose = const Value.absent(),
                Value<String?> symptomId = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MedicationIntakesCompanion(
                id: id,
                timestamp: timestamp,
                name: name,
                dose: dose,
                symptomId: symptomId,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime timestamp,
                required String name,
                Value<String?> dose = const Value.absent(),
                Value<String?> symptomId = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MedicationIntakesCompanion.insert(
                id: id,
                timestamp: timestamp,
                name: name,
                dose: dose,
                symptomId: symptomId,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MedicationIntakesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({symptomId = false}) {
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
                    if (symptomId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.symptomId,
                                referencedTable:
                                    $$MedicationIntakesTableReferences
                                        ._symptomIdTable(db),
                                referencedColumn:
                                    $$MedicationIntakesTableReferences
                                        ._symptomIdTable(db)
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

typedef $$MedicationIntakesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MedicationIntakesTable,
      MedicationIntake,
      $$MedicationIntakesTableFilterComposer,
      $$MedicationIntakesTableOrderingComposer,
      $$MedicationIntakesTableAnnotationComposer,
      $$MedicationIntakesTableCreateCompanionBuilder,
      $$MedicationIntakesTableUpdateCompanionBuilder,
      (MedicationIntake, $$MedicationIntakesTableReferences),
      MedicationIntake,
      PrefetchHooks Function({bool symptomId})
    >;
typedef $$SleepEntriesTableCreateCompanionBuilder =
    SleepEntriesCompanion Function({
      required String id,
      required DateTime nightDate,
      required int quality,
      Value<DateTime?> bedTime,
      Value<DateTime?> wakeTime,
      Value<String> source,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });
typedef $$SleepEntriesTableUpdateCompanionBuilder =
    SleepEntriesCompanion Function({
      Value<String> id,
      Value<DateTime> nightDate,
      Value<int> quality,
      Value<DateTime?> bedTime,
      Value<DateTime?> wakeTime,
      Value<String> source,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });

class $$SleepEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $SleepEntriesTable> {
  $$SleepEntriesTableFilterComposer({
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

  ColumnFilters<DateTime> get nightDate => $composableBuilder(
    column: $table.nightDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quality => $composableBuilder(
    column: $table.quality,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get bedTime => $composableBuilder(
    column: $table.bedTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get wakeTime => $composableBuilder(
    column: $table.wakeTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SleepEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $SleepEntriesTable> {
  $$SleepEntriesTableOrderingComposer({
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

  ColumnOrderings<DateTime> get nightDate => $composableBuilder(
    column: $table.nightDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quality => $composableBuilder(
    column: $table.quality,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get bedTime => $composableBuilder(
    column: $table.bedTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get wakeTime => $composableBuilder(
    column: $table.wakeTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SleepEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SleepEntriesTable> {
  $$SleepEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get nightDate =>
      $composableBuilder(column: $table.nightDate, builder: (column) => column);

  GeneratedColumn<int> get quality =>
      $composableBuilder(column: $table.quality, builder: (column) => column);

  GeneratedColumn<DateTime> get bedTime =>
      $composableBuilder(column: $table.bedTime, builder: (column) => column);

  GeneratedColumn<DateTime> get wakeTime =>
      $composableBuilder(column: $table.wakeTime, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);
}

class $$SleepEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SleepEntriesTable,
          SleepEntry,
          $$SleepEntriesTableFilterComposer,
          $$SleepEntriesTableOrderingComposer,
          $$SleepEntriesTableAnnotationComposer,
          $$SleepEntriesTableCreateCompanionBuilder,
          $$SleepEntriesTableUpdateCompanionBuilder,
          (
            SleepEntry,
            BaseReferences<_$AppDatabase, $SleepEntriesTable, SleepEntry>,
          ),
          SleepEntry,
          PrefetchHooks Function()
        > {
  $$SleepEntriesTableTableManager(_$AppDatabase db, $SleepEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SleepEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SleepEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SleepEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> nightDate = const Value.absent(),
                Value<int> quality = const Value.absent(),
                Value<DateTime?> bedTime = const Value.absent(),
                Value<DateTime?> wakeTime = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SleepEntriesCompanion(
                id: id,
                nightDate: nightDate,
                quality: quality,
                bedTime: bedTime,
                wakeTime: wakeTime,
                source: source,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime nightDate,
                required int quality,
                Value<DateTime?> bedTime = const Value.absent(),
                Value<DateTime?> wakeTime = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SleepEntriesCompanion.insert(
                id: id,
                nightDate: nightDate,
                quality: quality,
                bedTime: bedTime,
                wakeTime: wakeTime,
                source: source,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SleepEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SleepEntriesTable,
      SleepEntry,
      $$SleepEntriesTableFilterComposer,
      $$SleepEntriesTableOrderingComposer,
      $$SleepEntriesTableAnnotationComposer,
      $$SleepEntriesTableCreateCompanionBuilder,
      $$SleepEntriesTableUpdateCompanionBuilder,
      (
        SleepEntry,
        BaseReferences<_$AppDatabase, $SleepEntriesTable, SleepEntry>,
      ),
      SleepEntry,
      PrefetchHooks Function()
    >;
typedef $$EnvironmentSnapshotsTableCreateCompanionBuilder =
    EnvironmentSnapshotsCompanion Function({
      required String id,
      required DateTime timestamp,
      Value<double?> pressure,
      Value<double?> pressureDelta,
      Value<double?> temperature,
      Value<double?> humidity,
      Value<double?> lat,
      Value<double?> lon,
      Value<int?> weatherCode,
      Value<double?> uvIndex,
      Value<double?> pm25,
      Value<double?> pm10,
      Value<double?> alderPollen,
      Value<double?> birchPollen,
      Value<double?> grassPollen,
      Value<double?> mugwortPollen,
      Value<double?> olivePollen,
      Value<double?> ragweedPollen,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$EnvironmentSnapshotsTableUpdateCompanionBuilder =
    EnvironmentSnapshotsCompanion Function({
      Value<String> id,
      Value<DateTime> timestamp,
      Value<double?> pressure,
      Value<double?> pressureDelta,
      Value<double?> temperature,
      Value<double?> humidity,
      Value<double?> lat,
      Value<double?> lon,
      Value<int?> weatherCode,
      Value<double?> uvIndex,
      Value<double?> pm25,
      Value<double?> pm10,
      Value<double?> alderPollen,
      Value<double?> birchPollen,
      Value<double?> grassPollen,
      Value<double?> mugwortPollen,
      Value<double?> olivePollen,
      Value<double?> ragweedPollen,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$EnvironmentSnapshotsTableFilterComposer
    extends Composer<_$AppDatabase, $EnvironmentSnapshotsTable> {
  $$EnvironmentSnapshotsTableFilterComposer({
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

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get pressure => $composableBuilder(
    column: $table.pressure,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get pressureDelta => $composableBuilder(
    column: $table.pressureDelta,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get temperature => $composableBuilder(
    column: $table.temperature,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get humidity => $composableBuilder(
    column: $table.humidity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lat => $composableBuilder(
    column: $table.lat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lon => $composableBuilder(
    column: $table.lon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weatherCode => $composableBuilder(
    column: $table.weatherCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get uvIndex => $composableBuilder(
    column: $table.uvIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get pm25 => $composableBuilder(
    column: $table.pm25,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get pm10 => $composableBuilder(
    column: $table.pm10,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get alderPollen => $composableBuilder(
    column: $table.alderPollen,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get birchPollen => $composableBuilder(
    column: $table.birchPollen,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get grassPollen => $composableBuilder(
    column: $table.grassPollen,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get mugwortPollen => $composableBuilder(
    column: $table.mugwortPollen,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get olivePollen => $composableBuilder(
    column: $table.olivePollen,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get ragweedPollen => $composableBuilder(
    column: $table.ragweedPollen,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$EnvironmentSnapshotsTableOrderingComposer
    extends Composer<_$AppDatabase, $EnvironmentSnapshotsTable> {
  $$EnvironmentSnapshotsTableOrderingComposer({
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

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get pressure => $composableBuilder(
    column: $table.pressure,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get pressureDelta => $composableBuilder(
    column: $table.pressureDelta,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get temperature => $composableBuilder(
    column: $table.temperature,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get humidity => $composableBuilder(
    column: $table.humidity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lat => $composableBuilder(
    column: $table.lat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lon => $composableBuilder(
    column: $table.lon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weatherCode => $composableBuilder(
    column: $table.weatherCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get uvIndex => $composableBuilder(
    column: $table.uvIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get pm25 => $composableBuilder(
    column: $table.pm25,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get pm10 => $composableBuilder(
    column: $table.pm10,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get alderPollen => $composableBuilder(
    column: $table.alderPollen,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get birchPollen => $composableBuilder(
    column: $table.birchPollen,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get grassPollen => $composableBuilder(
    column: $table.grassPollen,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get mugwortPollen => $composableBuilder(
    column: $table.mugwortPollen,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get olivePollen => $composableBuilder(
    column: $table.olivePollen,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get ragweedPollen => $composableBuilder(
    column: $table.ragweedPollen,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EnvironmentSnapshotsTableAnnotationComposer
    extends Composer<_$AppDatabase, $EnvironmentSnapshotsTable> {
  $$EnvironmentSnapshotsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<double> get pressure =>
      $composableBuilder(column: $table.pressure, builder: (column) => column);

  GeneratedColumn<double> get pressureDelta => $composableBuilder(
    column: $table.pressureDelta,
    builder: (column) => column,
  );

  GeneratedColumn<double> get temperature => $composableBuilder(
    column: $table.temperature,
    builder: (column) => column,
  );

  GeneratedColumn<double> get humidity =>
      $composableBuilder(column: $table.humidity, builder: (column) => column);

  GeneratedColumn<double> get lat =>
      $composableBuilder(column: $table.lat, builder: (column) => column);

  GeneratedColumn<double> get lon =>
      $composableBuilder(column: $table.lon, builder: (column) => column);

  GeneratedColumn<int> get weatherCode => $composableBuilder(
    column: $table.weatherCode,
    builder: (column) => column,
  );

  GeneratedColumn<double> get uvIndex =>
      $composableBuilder(column: $table.uvIndex, builder: (column) => column);

  GeneratedColumn<double> get pm25 =>
      $composableBuilder(column: $table.pm25, builder: (column) => column);

  GeneratedColumn<double> get pm10 =>
      $composableBuilder(column: $table.pm10, builder: (column) => column);

  GeneratedColumn<double> get alderPollen => $composableBuilder(
    column: $table.alderPollen,
    builder: (column) => column,
  );

  GeneratedColumn<double> get birchPollen => $composableBuilder(
    column: $table.birchPollen,
    builder: (column) => column,
  );

  GeneratedColumn<double> get grassPollen => $composableBuilder(
    column: $table.grassPollen,
    builder: (column) => column,
  );

  GeneratedColumn<double> get mugwortPollen => $composableBuilder(
    column: $table.mugwortPollen,
    builder: (column) => column,
  );

  GeneratedColumn<double> get olivePollen => $composableBuilder(
    column: $table.olivePollen,
    builder: (column) => column,
  );

  GeneratedColumn<double> get ragweedPollen => $composableBuilder(
    column: $table.ragweedPollen,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$EnvironmentSnapshotsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EnvironmentSnapshotsTable,
          EnvironmentSnapshot,
          $$EnvironmentSnapshotsTableFilterComposer,
          $$EnvironmentSnapshotsTableOrderingComposer,
          $$EnvironmentSnapshotsTableAnnotationComposer,
          $$EnvironmentSnapshotsTableCreateCompanionBuilder,
          $$EnvironmentSnapshotsTableUpdateCompanionBuilder,
          (
            EnvironmentSnapshot,
            BaseReferences<
              _$AppDatabase,
              $EnvironmentSnapshotsTable,
              EnvironmentSnapshot
            >,
          ),
          EnvironmentSnapshot,
          PrefetchHooks Function()
        > {
  $$EnvironmentSnapshotsTableTableManager(
    _$AppDatabase db,
    $EnvironmentSnapshotsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EnvironmentSnapshotsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EnvironmentSnapshotsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$EnvironmentSnapshotsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<double?> pressure = const Value.absent(),
                Value<double?> pressureDelta = const Value.absent(),
                Value<double?> temperature = const Value.absent(),
                Value<double?> humidity = const Value.absent(),
                Value<double?> lat = const Value.absent(),
                Value<double?> lon = const Value.absent(),
                Value<int?> weatherCode = const Value.absent(),
                Value<double?> uvIndex = const Value.absent(),
                Value<double?> pm25 = const Value.absent(),
                Value<double?> pm10 = const Value.absent(),
                Value<double?> alderPollen = const Value.absent(),
                Value<double?> birchPollen = const Value.absent(),
                Value<double?> grassPollen = const Value.absent(),
                Value<double?> mugwortPollen = const Value.absent(),
                Value<double?> olivePollen = const Value.absent(),
                Value<double?> ragweedPollen = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EnvironmentSnapshotsCompanion(
                id: id,
                timestamp: timestamp,
                pressure: pressure,
                pressureDelta: pressureDelta,
                temperature: temperature,
                humidity: humidity,
                lat: lat,
                lon: lon,
                weatherCode: weatherCode,
                uvIndex: uvIndex,
                pm25: pm25,
                pm10: pm10,
                alderPollen: alderPollen,
                birchPollen: birchPollen,
                grassPollen: grassPollen,
                mugwortPollen: mugwortPollen,
                olivePollen: olivePollen,
                ragweedPollen: ragweedPollen,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime timestamp,
                Value<double?> pressure = const Value.absent(),
                Value<double?> pressureDelta = const Value.absent(),
                Value<double?> temperature = const Value.absent(),
                Value<double?> humidity = const Value.absent(),
                Value<double?> lat = const Value.absent(),
                Value<double?> lon = const Value.absent(),
                Value<int?> weatherCode = const Value.absent(),
                Value<double?> uvIndex = const Value.absent(),
                Value<double?> pm25 = const Value.absent(),
                Value<double?> pm10 = const Value.absent(),
                Value<double?> alderPollen = const Value.absent(),
                Value<double?> birchPollen = const Value.absent(),
                Value<double?> grassPollen = const Value.absent(),
                Value<double?> mugwortPollen = const Value.absent(),
                Value<double?> olivePollen = const Value.absent(),
                Value<double?> ragweedPollen = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EnvironmentSnapshotsCompanion.insert(
                id: id,
                timestamp: timestamp,
                pressure: pressure,
                pressureDelta: pressureDelta,
                temperature: temperature,
                humidity: humidity,
                lat: lat,
                lon: lon,
                weatherCode: weatherCode,
                uvIndex: uvIndex,
                pm25: pm25,
                pm10: pm10,
                alderPollen: alderPollen,
                birchPollen: birchPollen,
                grassPollen: grassPollen,
                mugwortPollen: mugwortPollen,
                olivePollen: olivePollen,
                ragweedPollen: ragweedPollen,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$EnvironmentSnapshotsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EnvironmentSnapshotsTable,
      EnvironmentSnapshot,
      $$EnvironmentSnapshotsTableFilterComposer,
      $$EnvironmentSnapshotsTableOrderingComposer,
      $$EnvironmentSnapshotsTableAnnotationComposer,
      $$EnvironmentSnapshotsTableCreateCompanionBuilder,
      $$EnvironmentSnapshotsTableUpdateCompanionBuilder,
      (
        EnvironmentSnapshot,
        BaseReferences<
          _$AppDatabase,
          $EnvironmentSnapshotsTable,
          EnvironmentSnapshot
        >,
      ),
      EnvironmentSnapshot,
      PrefetchHooks Function()
    >;
typedef $$AppSettingsTableCreateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<int> id,
      Value<bool> onboardingDone,
      Value<DateTime?> lastPressureAlertDate,
      Value<bool> remindersMealsEnabled,
      Value<int> breakfastHour,
      Value<int> breakfastMinute,
      Value<int> lunchHour,
      Value<int> lunchMinute,
      Value<int> dinnerHour,
      Value<int> dinnerMinute,
      Value<bool> remindersSleepEnabled,
      Value<int> sleepHour,
      Value<int> sleepMinute,
      Value<bool> remindersWeatherEnabled,
      Value<bool> remindersSymptomsEnabled,
      Value<int> symptomsHour,
      Value<int> symptomsMinute,
      Value<bool> photoTagSuggestionsEnabled,
    });
typedef $$AppSettingsTableUpdateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<int> id,
      Value<bool> onboardingDone,
      Value<DateTime?> lastPressureAlertDate,
      Value<bool> remindersMealsEnabled,
      Value<int> breakfastHour,
      Value<int> breakfastMinute,
      Value<int> lunchHour,
      Value<int> lunchMinute,
      Value<int> dinnerHour,
      Value<int> dinnerMinute,
      Value<bool> remindersSleepEnabled,
      Value<int> sleepHour,
      Value<int> sleepMinute,
      Value<bool> remindersWeatherEnabled,
      Value<bool> remindersSymptomsEnabled,
      Value<int> symptomsHour,
      Value<int> symptomsMinute,
      Value<bool> photoTagSuggestionsEnabled,
    });

class $$AppSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
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

  ColumnFilters<bool> get onboardingDone => $composableBuilder(
    column: $table.onboardingDone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastPressureAlertDate => $composableBuilder(
    column: $table.lastPressureAlertDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get remindersMealsEnabled => $composableBuilder(
    column: $table.remindersMealsEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get breakfastHour => $composableBuilder(
    column: $table.breakfastHour,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get breakfastMinute => $composableBuilder(
    column: $table.breakfastMinute,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lunchHour => $composableBuilder(
    column: $table.lunchHour,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lunchMinute => $composableBuilder(
    column: $table.lunchMinute,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dinnerHour => $composableBuilder(
    column: $table.dinnerHour,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dinnerMinute => $composableBuilder(
    column: $table.dinnerMinute,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get remindersSleepEnabled => $composableBuilder(
    column: $table.remindersSleepEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sleepHour => $composableBuilder(
    column: $table.sleepHour,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sleepMinute => $composableBuilder(
    column: $table.sleepMinute,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get remindersWeatherEnabled => $composableBuilder(
    column: $table.remindersWeatherEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get remindersSymptomsEnabled => $composableBuilder(
    column: $table.remindersSymptomsEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get symptomsHour => $composableBuilder(
    column: $table.symptomsHour,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get symptomsMinute => $composableBuilder(
    column: $table.symptomsMinute,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get photoTagSuggestionsEnabled => $composableBuilder(
    column: $table.photoTagSuggestionsEnabled,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
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

  ColumnOrderings<bool> get onboardingDone => $composableBuilder(
    column: $table.onboardingDone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastPressureAlertDate => $composableBuilder(
    column: $table.lastPressureAlertDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get remindersMealsEnabled => $composableBuilder(
    column: $table.remindersMealsEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get breakfastHour => $composableBuilder(
    column: $table.breakfastHour,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get breakfastMinute => $composableBuilder(
    column: $table.breakfastMinute,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lunchHour => $composableBuilder(
    column: $table.lunchHour,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lunchMinute => $composableBuilder(
    column: $table.lunchMinute,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dinnerHour => $composableBuilder(
    column: $table.dinnerHour,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dinnerMinute => $composableBuilder(
    column: $table.dinnerMinute,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get remindersSleepEnabled => $composableBuilder(
    column: $table.remindersSleepEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sleepHour => $composableBuilder(
    column: $table.sleepHour,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sleepMinute => $composableBuilder(
    column: $table.sleepMinute,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get remindersWeatherEnabled => $composableBuilder(
    column: $table.remindersWeatherEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get remindersSymptomsEnabled => $composableBuilder(
    column: $table.remindersSymptomsEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get symptomsHour => $composableBuilder(
    column: $table.symptomsHour,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get symptomsMinute => $composableBuilder(
    column: $table.symptomsMinute,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get photoTagSuggestionsEnabled => $composableBuilder(
    column: $table.photoTagSuggestionsEnabled,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get onboardingDone => $composableBuilder(
    column: $table.onboardingDone,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastPressureAlertDate => $composableBuilder(
    column: $table.lastPressureAlertDate,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get remindersMealsEnabled => $composableBuilder(
    column: $table.remindersMealsEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<int> get breakfastHour => $composableBuilder(
    column: $table.breakfastHour,
    builder: (column) => column,
  );

  GeneratedColumn<int> get breakfastMinute => $composableBuilder(
    column: $table.breakfastMinute,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lunchHour =>
      $composableBuilder(column: $table.lunchHour, builder: (column) => column);

  GeneratedColumn<int> get lunchMinute => $composableBuilder(
    column: $table.lunchMinute,
    builder: (column) => column,
  );

  GeneratedColumn<int> get dinnerHour => $composableBuilder(
    column: $table.dinnerHour,
    builder: (column) => column,
  );

  GeneratedColumn<int> get dinnerMinute => $composableBuilder(
    column: $table.dinnerMinute,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get remindersSleepEnabled => $composableBuilder(
    column: $table.remindersSleepEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sleepHour =>
      $composableBuilder(column: $table.sleepHour, builder: (column) => column);

  GeneratedColumn<int> get sleepMinute => $composableBuilder(
    column: $table.sleepMinute,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get remindersWeatherEnabled => $composableBuilder(
    column: $table.remindersWeatherEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get remindersSymptomsEnabled => $composableBuilder(
    column: $table.remindersSymptomsEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<int> get symptomsHour => $composableBuilder(
    column: $table.symptomsHour,
    builder: (column) => column,
  );

  GeneratedColumn<int> get symptomsMinute => $composableBuilder(
    column: $table.symptomsMinute,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get photoTagSuggestionsEnabled => $composableBuilder(
    column: $table.photoTagSuggestionsEnabled,
    builder: (column) => column,
  );
}

class $$AppSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSettingsTable,
          AppSetting,
          $$AppSettingsTableFilterComposer,
          $$AppSettingsTableOrderingComposer,
          $$AppSettingsTableAnnotationComposer,
          $$AppSettingsTableCreateCompanionBuilder,
          $$AppSettingsTableUpdateCompanionBuilder,
          (
            AppSetting,
            BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
          ),
          AppSetting,
          PrefetchHooks Function()
        > {
  $$AppSettingsTableTableManager(_$AppDatabase db, $AppSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool> onboardingDone = const Value.absent(),
                Value<DateTime?> lastPressureAlertDate = const Value.absent(),
                Value<bool> remindersMealsEnabled = const Value.absent(),
                Value<int> breakfastHour = const Value.absent(),
                Value<int> breakfastMinute = const Value.absent(),
                Value<int> lunchHour = const Value.absent(),
                Value<int> lunchMinute = const Value.absent(),
                Value<int> dinnerHour = const Value.absent(),
                Value<int> dinnerMinute = const Value.absent(),
                Value<bool> remindersSleepEnabled = const Value.absent(),
                Value<int> sleepHour = const Value.absent(),
                Value<int> sleepMinute = const Value.absent(),
                Value<bool> remindersWeatherEnabled = const Value.absent(),
                Value<bool> remindersSymptomsEnabled = const Value.absent(),
                Value<int> symptomsHour = const Value.absent(),
                Value<int> symptomsMinute = const Value.absent(),
                Value<bool> photoTagSuggestionsEnabled = const Value.absent(),
              }) => AppSettingsCompanion(
                id: id,
                onboardingDone: onboardingDone,
                lastPressureAlertDate: lastPressureAlertDate,
                remindersMealsEnabled: remindersMealsEnabled,
                breakfastHour: breakfastHour,
                breakfastMinute: breakfastMinute,
                lunchHour: lunchHour,
                lunchMinute: lunchMinute,
                dinnerHour: dinnerHour,
                dinnerMinute: dinnerMinute,
                remindersSleepEnabled: remindersSleepEnabled,
                sleepHour: sleepHour,
                sleepMinute: sleepMinute,
                remindersWeatherEnabled: remindersWeatherEnabled,
                remindersSymptomsEnabled: remindersSymptomsEnabled,
                symptomsHour: symptomsHour,
                symptomsMinute: symptomsMinute,
                photoTagSuggestionsEnabled: photoTagSuggestionsEnabled,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool> onboardingDone = const Value.absent(),
                Value<DateTime?> lastPressureAlertDate = const Value.absent(),
                Value<bool> remindersMealsEnabled = const Value.absent(),
                Value<int> breakfastHour = const Value.absent(),
                Value<int> breakfastMinute = const Value.absent(),
                Value<int> lunchHour = const Value.absent(),
                Value<int> lunchMinute = const Value.absent(),
                Value<int> dinnerHour = const Value.absent(),
                Value<int> dinnerMinute = const Value.absent(),
                Value<bool> remindersSleepEnabled = const Value.absent(),
                Value<int> sleepHour = const Value.absent(),
                Value<int> sleepMinute = const Value.absent(),
                Value<bool> remindersWeatherEnabled = const Value.absent(),
                Value<bool> remindersSymptomsEnabled = const Value.absent(),
                Value<int> symptomsHour = const Value.absent(),
                Value<int> symptomsMinute = const Value.absent(),
                Value<bool> photoTagSuggestionsEnabled = const Value.absent(),
              }) => AppSettingsCompanion.insert(
                id: id,
                onboardingDone: onboardingDone,
                lastPressureAlertDate: lastPressureAlertDate,
                remindersMealsEnabled: remindersMealsEnabled,
                breakfastHour: breakfastHour,
                breakfastMinute: breakfastMinute,
                lunchHour: lunchHour,
                lunchMinute: lunchMinute,
                dinnerHour: dinnerHour,
                dinnerMinute: dinnerMinute,
                remindersSleepEnabled: remindersSleepEnabled,
                sleepHour: sleepHour,
                sleepMinute: sleepMinute,
                remindersWeatherEnabled: remindersWeatherEnabled,
                remindersSymptomsEnabled: remindersSymptomsEnabled,
                symptomsHour: symptomsHour,
                symptomsMinute: symptomsMinute,
                photoTagSuggestionsEnabled: photoTagSuggestionsEnabled,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSettingsTable,
      AppSetting,
      $$AppSettingsTableFilterComposer,
      $$AppSettingsTableOrderingComposer,
      $$AppSettingsTableAnnotationComposer,
      $$AppSettingsTableCreateCompanionBuilder,
      $$AppSettingsTableUpdateCompanionBuilder,
      (
        AppSetting,
        BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
      ),
      AppSetting,
      PrefetchHooks Function()
    >;
typedef $$CloudBackupStatesTableCreateCompanionBuilder =
    CloudBackupStatesCompanion Function({
      Value<int> id,
      Value<DateTime?> lastBackupAt,
      Value<bool> hasRestoredOnThisDevice,
    });
typedef $$CloudBackupStatesTableUpdateCompanionBuilder =
    CloudBackupStatesCompanion Function({
      Value<int> id,
      Value<DateTime?> lastBackupAt,
      Value<bool> hasRestoredOnThisDevice,
    });

class $$CloudBackupStatesTableFilterComposer
    extends Composer<_$AppDatabase, $CloudBackupStatesTable> {
  $$CloudBackupStatesTableFilterComposer({
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

  ColumnFilters<DateTime> get lastBackupAt => $composableBuilder(
    column: $table.lastBackupAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hasRestoredOnThisDevice => $composableBuilder(
    column: $table.hasRestoredOnThisDevice,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CloudBackupStatesTableOrderingComposer
    extends Composer<_$AppDatabase, $CloudBackupStatesTable> {
  $$CloudBackupStatesTableOrderingComposer({
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

  ColumnOrderings<DateTime> get lastBackupAt => $composableBuilder(
    column: $table.lastBackupAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hasRestoredOnThisDevice => $composableBuilder(
    column: $table.hasRestoredOnThisDevice,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CloudBackupStatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CloudBackupStatesTable> {
  $$CloudBackupStatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get lastBackupAt => $composableBuilder(
    column: $table.lastBackupAt,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get hasRestoredOnThisDevice => $composableBuilder(
    column: $table.hasRestoredOnThisDevice,
    builder: (column) => column,
  );
}

class $$CloudBackupStatesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CloudBackupStatesTable,
          CloudBackupState,
          $$CloudBackupStatesTableFilterComposer,
          $$CloudBackupStatesTableOrderingComposer,
          $$CloudBackupStatesTableAnnotationComposer,
          $$CloudBackupStatesTableCreateCompanionBuilder,
          $$CloudBackupStatesTableUpdateCompanionBuilder,
          (
            CloudBackupState,
            BaseReferences<
              _$AppDatabase,
              $CloudBackupStatesTable,
              CloudBackupState
            >,
          ),
          CloudBackupState,
          PrefetchHooks Function()
        > {
  $$CloudBackupStatesTableTableManager(
    _$AppDatabase db,
    $CloudBackupStatesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CloudBackupStatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CloudBackupStatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CloudBackupStatesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime?> lastBackupAt = const Value.absent(),
                Value<bool> hasRestoredOnThisDevice = const Value.absent(),
              }) => CloudBackupStatesCompanion(
                id: id,
                lastBackupAt: lastBackupAt,
                hasRestoredOnThisDevice: hasRestoredOnThisDevice,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime?> lastBackupAt = const Value.absent(),
                Value<bool> hasRestoredOnThisDevice = const Value.absent(),
              }) => CloudBackupStatesCompanion.insert(
                id: id,
                lastBackupAt: lastBackupAt,
                hasRestoredOnThisDevice: hasRestoredOnThisDevice,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CloudBackupStatesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CloudBackupStatesTable,
      CloudBackupState,
      $$CloudBackupStatesTableFilterComposer,
      $$CloudBackupStatesTableOrderingComposer,
      $$CloudBackupStatesTableAnnotationComposer,
      $$CloudBackupStatesTableCreateCompanionBuilder,
      $$CloudBackupStatesTableUpdateCompanionBuilder,
      (
        CloudBackupState,
        BaseReferences<
          _$AppDatabase,
          $CloudBackupStatesTable,
          CloudBackupState
        >,
      ),
      CloudBackupState,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TagsTableTableManager get tags => $$TagsTableTableManager(_db, _db.tags);
  $$MealsTableTableManager get meals =>
      $$MealsTableTableManager(_db, _db.meals);
  $$MealTagsTableTableManager get mealTags =>
      $$MealTagsTableTableManager(_db, _db.mealTags);
  $$MealTemplatesTableTableManager get mealTemplates =>
      $$MealTemplatesTableTableManager(_db, _db.mealTemplates);
  $$TemplateTagsTableTableManager get templateTags =>
      $$TemplateTagsTableTableManager(_db, _db.templateTags);
  $$SymptomsTableTableManager get symptoms =>
      $$SymptomsTableTableManager(_db, _db.symptoms);
  $$MigraineIntensityMeasurementsTableTableManager
  get migraineIntensityMeasurements =>
      $$MigraineIntensityMeasurementsTableTableManager(
        _db,
        _db.migraineIntensityMeasurements,
      );
  $$MedicationIntakesTableTableManager get medicationIntakes =>
      $$MedicationIntakesTableTableManager(_db, _db.medicationIntakes);
  $$SleepEntriesTableTableManager get sleepEntries =>
      $$SleepEntriesTableTableManager(_db, _db.sleepEntries);
  $$EnvironmentSnapshotsTableTableManager get environmentSnapshots =>
      $$EnvironmentSnapshotsTableTableManager(_db, _db.environmentSnapshots);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
  $$CloudBackupStatesTableTableManager get cloudBackupStates =>
      $$CloudBackupStatesTableTableManager(_db, _db.cloudBackupStates);
}
