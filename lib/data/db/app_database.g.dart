// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $AuditLogsTable extends AuditLogs
    with TableInfo<$AuditLogsTable, AuditLogRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AuditLogsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _actionMeta = const VerificationMeta('action');
  @override
  late final GeneratedColumn<String> action = GeneratedColumn<String>(
    'action',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
    userId,
    action,
    details,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'audit_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<AuditLogRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    }
    if (data.containsKey('action')) {
      context.handle(
        _actionMeta,
        action.isAcceptableOrUnknown(data['action']!, _actionMeta),
      );
    } else if (isInserting) {
      context.missing(_actionMeta);
    }
    if (data.containsKey('details')) {
      context.handle(
        _detailsMeta,
        details.isAcceptableOrUnknown(data['details']!, _detailsMeta),
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
  AuditLogRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AuditLogRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_id'],
      ),
      action: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}action'],
      )!,
      details: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}details'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $AuditLogsTable createAlias(String alias) {
    return $AuditLogsTable(attachedDatabase, alias);
  }
}

class AuditLogRow extends DataClass implements Insertable<AuditLogRow> {
  final int id;
  final int? userId;
  final String action;
  final String? details;
  final DateTime createdAt;
  const AuditLogRow({
    required this.id,
    this.userId,
    required this.action,
    this.details,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<int>(userId);
    }
    map['action'] = Variable<String>(action);
    if (!nullToAbsent || details != null) {
      map['details'] = Variable<String>(details);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  AuditLogsCompanion toCompanion(bool nullToAbsent) {
    return AuditLogsCompanion(
      id: Value(id),
      userId: userId == null && nullToAbsent
          ? const Value.absent()
          : Value(userId),
      action: Value(action),
      details: details == null && nullToAbsent
          ? const Value.absent()
          : Value(details),
      createdAt: Value(createdAt),
    );
  }

  factory AuditLogRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AuditLogRow(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int?>(json['userId']),
      action: serializer.fromJson<String>(json['action']),
      details: serializer.fromJson<String?>(json['details']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int?>(userId),
      'action': serializer.toJson<String>(action),
      'details': serializer.toJson<String?>(details),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  AuditLogRow copyWith({
    int? id,
    Value<int?> userId = const Value.absent(),
    String? action,
    Value<String?> details = const Value.absent(),
    DateTime? createdAt,
  }) => AuditLogRow(
    id: id ?? this.id,
    userId: userId.present ? userId.value : this.userId,
    action: action ?? this.action,
    details: details.present ? details.value : this.details,
    createdAt: createdAt ?? this.createdAt,
  );
  AuditLogRow copyWithCompanion(AuditLogsCompanion data) {
    return AuditLogRow(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      action: data.action.present ? data.action.value : this.action,
      details: data.details.present ? data.details.value : this.details,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AuditLogRow(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('action: $action, ')
          ..write('details: $details, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, action, details, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AuditLogRow &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.action == this.action &&
          other.details == this.details &&
          other.createdAt == this.createdAt);
}

class AuditLogsCompanion extends UpdateCompanion<AuditLogRow> {
  final Value<int> id;
  final Value<int?> userId;
  final Value<String> action;
  final Value<String?> details;
  final Value<DateTime> createdAt;
  const AuditLogsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.action = const Value.absent(),
    this.details = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  AuditLogsCompanion.insert({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    required String action,
    this.details = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : action = Value(action);
  static Insertable<AuditLogRow> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<String>? action,
    Expression<String>? details,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (action != null) 'action': action,
      if (details != null) 'details': details,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  AuditLogsCompanion copyWith({
    Value<int>? id,
    Value<int?>? userId,
    Value<String>? action,
    Value<String?>? details,
    Value<DateTime>? createdAt,
  }) {
    return AuditLogsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      action: action ?? this.action,
      details: details ?? this.details,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (action.present) {
      map['action'] = Variable<String>(action.value);
    }
    if (details.present) {
      map['details'] = Variable<String>(details.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AuditLogsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('action: $action, ')
          ..write('details: $details, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $CustomersTable extends Customers
    with TableInfo<$CustomersTable, CustomerRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomersTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _tierMeta = const VerificationMeta('tier');
  @override
  late final GeneratedColumn<String> tier = GeneratedColumn<String>(
    'tier',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pointsMeta = const VerificationMeta('points');
  @override
  late final GeneratedColumn<int> points = GeneratedColumn<int>(
    'points',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, phone, email, tier, points];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'customers';
  @override
  VerificationContext validateIntegrity(
    Insertable<CustomerRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('tier')) {
      context.handle(
        _tierMeta,
        tier.isAcceptableOrUnknown(data['tier']!, _tierMeta),
      );
    }
    if (data.containsKey('points')) {
      context.handle(
        _pointsMeta,
        points.isAcceptableOrUnknown(data['points']!, _pointsMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CustomerRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CustomerRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      tier: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tier'],
      ),
      points: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}points'],
      )!,
    );
  }

  @override
  $CustomersTable createAlias(String alias) {
    return $CustomersTable(attachedDatabase, alias);
  }
}

class CustomerRow extends DataClass implements Insertable<CustomerRow> {
  final int id;
  final String name;
  final String? phone;
  final String? email;
  final String? tier;
  final int points;
  const CustomerRow({
    required this.id,
    required this.name,
    this.phone,
    this.email,
    this.tier,
    required this.points,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || tier != null) {
      map['tier'] = Variable<String>(tier);
    }
    map['points'] = Variable<int>(points);
    return map;
  }

  CustomersCompanion toCompanion(bool nullToAbsent) {
    return CustomersCompanion(
      id: Value(id),
      name: Value(name),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      tier: tier == null && nullToAbsent ? const Value.absent() : Value(tier),
      points: Value(points),
    );
  }

  factory CustomerRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CustomerRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      phone: serializer.fromJson<String?>(json['phone']),
      email: serializer.fromJson<String?>(json['email']),
      tier: serializer.fromJson<String?>(json['tier']),
      points: serializer.fromJson<int>(json['points']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'phone': serializer.toJson<String?>(phone),
      'email': serializer.toJson<String?>(email),
      'tier': serializer.toJson<String?>(tier),
      'points': serializer.toJson<int>(points),
    };
  }

  CustomerRow copyWith({
    int? id,
    String? name,
    Value<String?> phone = const Value.absent(),
    Value<String?> email = const Value.absent(),
    Value<String?> tier = const Value.absent(),
    int? points,
  }) => CustomerRow(
    id: id ?? this.id,
    name: name ?? this.name,
    phone: phone.present ? phone.value : this.phone,
    email: email.present ? email.value : this.email,
    tier: tier.present ? tier.value : this.tier,
    points: points ?? this.points,
  );
  CustomerRow copyWithCompanion(CustomersCompanion data) {
    return CustomerRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      phone: data.phone.present ? data.phone.value : this.phone,
      email: data.email.present ? data.email.value : this.email,
      tier: data.tier.present ? data.tier.value : this.tier,
      points: data.points.present ? data.points.value : this.points,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CustomerRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('tier: $tier, ')
          ..write('points: $points')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, phone, email, tier, points);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CustomerRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.email == this.email &&
          other.tier == this.tier &&
          other.points == this.points);
}

class CustomersCompanion extends UpdateCompanion<CustomerRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> phone;
  final Value<String?> email;
  final Value<String?> tier;
  final Value<int> points;
  const CustomersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.tier = const Value.absent(),
    this.points = const Value.absent(),
  });
  CustomersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.tier = const Value.absent(),
    this.points = const Value.absent(),
  }) : name = Value(name);
  static Insertable<CustomerRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? phone,
    Expression<String>? email,
    Expression<String>? tier,
    Expression<int>? points,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (tier != null) 'tier': tier,
      if (points != null) 'points': points,
    });
  }

  CustomersCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? phone,
    Value<String?>? email,
    Value<String?>? tier,
    Value<int>? points,
  }) {
    return CustomersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      tier: tier ?? this.tier,
      points: points ?? this.points,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (tier.present) {
      map['tier'] = Variable<String>(tier.value);
    }
    if (points.present) {
      map['points'] = Variable<int>(points.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('tier: $tier, ')
          ..write('points: $points')
          ..write(')'))
        .toString();
  }
}

class $GoodsReceiptsTable extends GoodsReceipts
    with TableInfo<$GoodsReceiptsTable, GoodsReceiptRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GoodsReceiptsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _supplierIdMeta = const VerificationMeta(
    'supplierId',
  );
  @override
  late final GeneratedColumn<int> supplierId = GeneratedColumn<int>(
    'supplier_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _purchaseOrderIdMeta = const VerificationMeta(
    'purchaseOrderId',
  );
  @override
  late final GeneratedColumn<int> purchaseOrderId = GeneratedColumn<int>(
    'purchase_order_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _receivedAtMeta = const VerificationMeta(
    'receivedAt',
  );
  @override
  late final GeneratedColumn<DateTime> receivedAt = GeneratedColumn<DateTime>(
    'received_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _itemsJsonMeta = const VerificationMeta(
    'itemsJson',
  );
  @override
  late final GeneratedColumn<String> itemsJson = GeneratedColumn<String>(
    'items_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    supplierId,
    purchaseOrderId,
    receivedAt,
    itemsJson,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'goods_receipts';
  @override
  VerificationContext validateIntegrity(
    Insertable<GoodsReceiptRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('supplier_id')) {
      context.handle(
        _supplierIdMeta,
        supplierId.isAcceptableOrUnknown(data['supplier_id']!, _supplierIdMeta),
      );
    } else if (isInserting) {
      context.missing(_supplierIdMeta);
    }
    if (data.containsKey('purchase_order_id')) {
      context.handle(
        _purchaseOrderIdMeta,
        purchaseOrderId.isAcceptableOrUnknown(
          data['purchase_order_id']!,
          _purchaseOrderIdMeta,
        ),
      );
    }
    if (data.containsKey('received_at')) {
      context.handle(
        _receivedAtMeta,
        receivedAt.isAcceptableOrUnknown(data['received_at']!, _receivedAtMeta),
      );
    }
    if (data.containsKey('items_json')) {
      context.handle(
        _itemsJsonMeta,
        itemsJson.isAcceptableOrUnknown(data['items_json']!, _itemsJsonMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GoodsReceiptRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GoodsReceiptRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      supplierId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}supplier_id'],
      )!,
      purchaseOrderId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}purchase_order_id'],
      ),
      receivedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}received_at'],
      )!,
      itemsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}items_json'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $GoodsReceiptsTable createAlias(String alias) {
    return $GoodsReceiptsTable(attachedDatabase, alias);
  }
}

class GoodsReceiptRow extends DataClass implements Insertable<GoodsReceiptRow> {
  final int id;
  final int supplierId;
  final int? purchaseOrderId;
  final DateTime receivedAt;
  final String itemsJson;
  final String? notes;
  const GoodsReceiptRow({
    required this.id,
    required this.supplierId,
    this.purchaseOrderId,
    required this.receivedAt,
    required this.itemsJson,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['supplier_id'] = Variable<int>(supplierId);
    if (!nullToAbsent || purchaseOrderId != null) {
      map['purchase_order_id'] = Variable<int>(purchaseOrderId);
    }
    map['received_at'] = Variable<DateTime>(receivedAt);
    map['items_json'] = Variable<String>(itemsJson);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  GoodsReceiptsCompanion toCompanion(bool nullToAbsent) {
    return GoodsReceiptsCompanion(
      id: Value(id),
      supplierId: Value(supplierId),
      purchaseOrderId: purchaseOrderId == null && nullToAbsent
          ? const Value.absent()
          : Value(purchaseOrderId),
      receivedAt: Value(receivedAt),
      itemsJson: Value(itemsJson),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory GoodsReceiptRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GoodsReceiptRow(
      id: serializer.fromJson<int>(json['id']),
      supplierId: serializer.fromJson<int>(json['supplierId']),
      purchaseOrderId: serializer.fromJson<int?>(json['purchaseOrderId']),
      receivedAt: serializer.fromJson<DateTime>(json['receivedAt']),
      itemsJson: serializer.fromJson<String>(json['itemsJson']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'supplierId': serializer.toJson<int>(supplierId),
      'purchaseOrderId': serializer.toJson<int?>(purchaseOrderId),
      'receivedAt': serializer.toJson<DateTime>(receivedAt),
      'itemsJson': serializer.toJson<String>(itemsJson),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  GoodsReceiptRow copyWith({
    int? id,
    int? supplierId,
    Value<int?> purchaseOrderId = const Value.absent(),
    DateTime? receivedAt,
    String? itemsJson,
    Value<String?> notes = const Value.absent(),
  }) => GoodsReceiptRow(
    id: id ?? this.id,
    supplierId: supplierId ?? this.supplierId,
    purchaseOrderId: purchaseOrderId.present
        ? purchaseOrderId.value
        : this.purchaseOrderId,
    receivedAt: receivedAt ?? this.receivedAt,
    itemsJson: itemsJson ?? this.itemsJson,
    notes: notes.present ? notes.value : this.notes,
  );
  GoodsReceiptRow copyWithCompanion(GoodsReceiptsCompanion data) {
    return GoodsReceiptRow(
      id: data.id.present ? data.id.value : this.id,
      supplierId: data.supplierId.present
          ? data.supplierId.value
          : this.supplierId,
      purchaseOrderId: data.purchaseOrderId.present
          ? data.purchaseOrderId.value
          : this.purchaseOrderId,
      receivedAt: data.receivedAt.present
          ? data.receivedAt.value
          : this.receivedAt,
      itemsJson: data.itemsJson.present ? data.itemsJson.value : this.itemsJson,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GoodsReceiptRow(')
          ..write('id: $id, ')
          ..write('supplierId: $supplierId, ')
          ..write('purchaseOrderId: $purchaseOrderId, ')
          ..write('receivedAt: $receivedAt, ')
          ..write('itemsJson: $itemsJson, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    supplierId,
    purchaseOrderId,
    receivedAt,
    itemsJson,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GoodsReceiptRow &&
          other.id == this.id &&
          other.supplierId == this.supplierId &&
          other.purchaseOrderId == this.purchaseOrderId &&
          other.receivedAt == this.receivedAt &&
          other.itemsJson == this.itemsJson &&
          other.notes == this.notes);
}

class GoodsReceiptsCompanion extends UpdateCompanion<GoodsReceiptRow> {
  final Value<int> id;
  final Value<int> supplierId;
  final Value<int?> purchaseOrderId;
  final Value<DateTime> receivedAt;
  final Value<String> itemsJson;
  final Value<String?> notes;
  const GoodsReceiptsCompanion({
    this.id = const Value.absent(),
    this.supplierId = const Value.absent(),
    this.purchaseOrderId = const Value.absent(),
    this.receivedAt = const Value.absent(),
    this.itemsJson = const Value.absent(),
    this.notes = const Value.absent(),
  });
  GoodsReceiptsCompanion.insert({
    this.id = const Value.absent(),
    required int supplierId,
    this.purchaseOrderId = const Value.absent(),
    this.receivedAt = const Value.absent(),
    this.itemsJson = const Value.absent(),
    this.notes = const Value.absent(),
  }) : supplierId = Value(supplierId);
  static Insertable<GoodsReceiptRow> custom({
    Expression<int>? id,
    Expression<int>? supplierId,
    Expression<int>? purchaseOrderId,
    Expression<DateTime>? receivedAt,
    Expression<String>? itemsJson,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (supplierId != null) 'supplier_id': supplierId,
      if (purchaseOrderId != null) 'purchase_order_id': purchaseOrderId,
      if (receivedAt != null) 'received_at': receivedAt,
      if (itemsJson != null) 'items_json': itemsJson,
      if (notes != null) 'notes': notes,
    });
  }

  GoodsReceiptsCompanion copyWith({
    Value<int>? id,
    Value<int>? supplierId,
    Value<int?>? purchaseOrderId,
    Value<DateTime>? receivedAt,
    Value<String>? itemsJson,
    Value<String?>? notes,
  }) {
    return GoodsReceiptsCompanion(
      id: id ?? this.id,
      supplierId: supplierId ?? this.supplierId,
      purchaseOrderId: purchaseOrderId ?? this.purchaseOrderId,
      receivedAt: receivedAt ?? this.receivedAt,
      itemsJson: itemsJson ?? this.itemsJson,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (supplierId.present) {
      map['supplier_id'] = Variable<int>(supplierId.value);
    }
    if (purchaseOrderId.present) {
      map['purchase_order_id'] = Variable<int>(purchaseOrderId.value);
    }
    if (receivedAt.present) {
      map['received_at'] = Variable<DateTime>(receivedAt.value);
    }
    if (itemsJson.present) {
      map['items_json'] = Variable<String>(itemsJson.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GoodsReceiptsCompanion(')
          ..write('id: $id, ')
          ..write('supplierId: $supplierId, ')
          ..write('purchaseOrderId: $purchaseOrderId, ')
          ..write('receivedAt: $receivedAt, ')
          ..write('itemsJson: $itemsJson, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $OrdersTable extends Orders with TableInfo<$OrdersTable, OrderRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrdersTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _totalAmountMeta = const VerificationMeta(
    'totalAmount',
  );
  @override
  late final GeneratedColumn<double> totalAmount = GeneratedColumn<double>(
    'total_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _customerIdMeta = const VerificationMeta(
    'customerId',
  );
  @override
  late final GeneratedColumn<int> customerId = GeneratedColumn<int>(
    'customer_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pointsDeltaMeta = const VerificationMeta(
    'pointsDelta',
  );
  @override
  late final GeneratedColumn<int> pointsDelta = GeneratedColumn<int>(
    'points_delta',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _itemsJsonMeta = const VerificationMeta(
    'itemsJson',
  );
  @override
  late final GeneratedColumn<String> itemsJson = GeneratedColumn<String>(
    'items_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _changeAmountMeta = const VerificationMeta(
    'changeAmount',
  );
  @override
  late final GeneratedColumn<double> changeAmount = GeneratedColumn<double>(
    'change_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    totalAmount,
    customerId,
    pointsDelta,
    itemsJson,
    changeAmount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'orders';
  @override
  VerificationContext validateIntegrity(
    Insertable<OrderRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('total_amount')) {
      context.handle(
        _totalAmountMeta,
        totalAmount.isAcceptableOrUnknown(
          data['total_amount']!,
          _totalAmountMeta,
        ),
      );
    }
    if (data.containsKey('customer_id')) {
      context.handle(
        _customerIdMeta,
        customerId.isAcceptableOrUnknown(data['customer_id']!, _customerIdMeta),
      );
    }
    if (data.containsKey('points_delta')) {
      context.handle(
        _pointsDeltaMeta,
        pointsDelta.isAcceptableOrUnknown(
          data['points_delta']!,
          _pointsDeltaMeta,
        ),
      );
    }
    if (data.containsKey('items_json')) {
      context.handle(
        _itemsJsonMeta,
        itemsJson.isAcceptableOrUnknown(data['items_json']!, _itemsJsonMeta),
      );
    }
    if (data.containsKey('change_amount')) {
      context.handle(
        _changeAmountMeta,
        changeAmount.isAcceptableOrUnknown(
          data['change_amount']!,
          _changeAmountMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OrderRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OrderRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      totalAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_amount'],
      )!,
      customerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}customer_id'],
      ),
      pointsDelta: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}points_delta'],
      )!,
      itemsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}items_json'],
      )!,
      changeAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}change_amount'],
      )!,
    );
  }

  @override
  $OrdersTable createAlias(String alias) {
    return $OrdersTable(attachedDatabase, alias);
  }
}

class OrderRow extends DataClass implements Insertable<OrderRow> {
  final int id;
  final DateTime createdAt;
  final double totalAmount;
  final int? customerId;
  final int pointsDelta;
  final String itemsJson;
  final double changeAmount;
  const OrderRow({
    required this.id,
    required this.createdAt,
    required this.totalAmount,
    this.customerId,
    required this.pointsDelta,
    required this.itemsJson,
    required this.changeAmount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['total_amount'] = Variable<double>(totalAmount);
    if (!nullToAbsent || customerId != null) {
      map['customer_id'] = Variable<int>(customerId);
    }
    map['points_delta'] = Variable<int>(pointsDelta);
    map['items_json'] = Variable<String>(itemsJson);
    map['change_amount'] = Variable<double>(changeAmount);
    return map;
  }

  OrdersCompanion toCompanion(bool nullToAbsent) {
    return OrdersCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      totalAmount: Value(totalAmount),
      customerId: customerId == null && nullToAbsent
          ? const Value.absent()
          : Value(customerId),
      pointsDelta: Value(pointsDelta),
      itemsJson: Value(itemsJson),
      changeAmount: Value(changeAmount),
    );
  }

  factory OrderRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OrderRow(
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      totalAmount: serializer.fromJson<double>(json['totalAmount']),
      customerId: serializer.fromJson<int?>(json['customerId']),
      pointsDelta: serializer.fromJson<int>(json['pointsDelta']),
      itemsJson: serializer.fromJson<String>(json['itemsJson']),
      changeAmount: serializer.fromJson<double>(json['changeAmount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'totalAmount': serializer.toJson<double>(totalAmount),
      'customerId': serializer.toJson<int?>(customerId),
      'pointsDelta': serializer.toJson<int>(pointsDelta),
      'itemsJson': serializer.toJson<String>(itemsJson),
      'changeAmount': serializer.toJson<double>(changeAmount),
    };
  }

  OrderRow copyWith({
    int? id,
    DateTime? createdAt,
    double? totalAmount,
    Value<int?> customerId = const Value.absent(),
    int? pointsDelta,
    String? itemsJson,
    double? changeAmount,
  }) => OrderRow(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    totalAmount: totalAmount ?? this.totalAmount,
    customerId: customerId.present ? customerId.value : this.customerId,
    pointsDelta: pointsDelta ?? this.pointsDelta,
    itemsJson: itemsJson ?? this.itemsJson,
    changeAmount: changeAmount ?? this.changeAmount,
  );
  OrderRow copyWithCompanion(OrdersCompanion data) {
    return OrderRow(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      totalAmount: data.totalAmount.present
          ? data.totalAmount.value
          : this.totalAmount,
      customerId: data.customerId.present
          ? data.customerId.value
          : this.customerId,
      pointsDelta: data.pointsDelta.present
          ? data.pointsDelta.value
          : this.pointsDelta,
      itemsJson: data.itemsJson.present ? data.itemsJson.value : this.itemsJson,
      changeAmount: data.changeAmount.present
          ? data.changeAmount.value
          : this.changeAmount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OrderRow(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('customerId: $customerId, ')
          ..write('pointsDelta: $pointsDelta, ')
          ..write('itemsJson: $itemsJson, ')
          ..write('changeAmount: $changeAmount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    totalAmount,
    customerId,
    pointsDelta,
    itemsJson,
    changeAmount,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrderRow &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.totalAmount == this.totalAmount &&
          other.customerId == this.customerId &&
          other.pointsDelta == this.pointsDelta &&
          other.itemsJson == this.itemsJson &&
          other.changeAmount == this.changeAmount);
}

class OrdersCompanion extends UpdateCompanion<OrderRow> {
  final Value<int> id;
  final Value<DateTime> createdAt;
  final Value<double> totalAmount;
  final Value<int?> customerId;
  final Value<int> pointsDelta;
  final Value<String> itemsJson;
  final Value<double> changeAmount;
  const OrdersCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.customerId = const Value.absent(),
    this.pointsDelta = const Value.absent(),
    this.itemsJson = const Value.absent(),
    this.changeAmount = const Value.absent(),
  });
  OrdersCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.customerId = const Value.absent(),
    this.pointsDelta = const Value.absent(),
    this.itemsJson = const Value.absent(),
    this.changeAmount = const Value.absent(),
  });
  static Insertable<OrderRow> custom({
    Expression<int>? id,
    Expression<DateTime>? createdAt,
    Expression<double>? totalAmount,
    Expression<int>? customerId,
    Expression<int>? pointsDelta,
    Expression<String>? itemsJson,
    Expression<double>? changeAmount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (totalAmount != null) 'total_amount': totalAmount,
      if (customerId != null) 'customer_id': customerId,
      if (pointsDelta != null) 'points_delta': pointsDelta,
      if (itemsJson != null) 'items_json': itemsJson,
      if (changeAmount != null) 'change_amount': changeAmount,
    });
  }

  OrdersCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? createdAt,
    Value<double>? totalAmount,
    Value<int?>? customerId,
    Value<int>? pointsDelta,
    Value<String>? itemsJson,
    Value<double>? changeAmount,
  }) {
    return OrdersCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      totalAmount: totalAmount ?? this.totalAmount,
      customerId: customerId ?? this.customerId,
      pointsDelta: pointsDelta ?? this.pointsDelta,
      itemsJson: itemsJson ?? this.itemsJson,
      changeAmount: changeAmount ?? this.changeAmount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (totalAmount.present) {
      map['total_amount'] = Variable<double>(totalAmount.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<int>(customerId.value);
    }
    if (pointsDelta.present) {
      map['points_delta'] = Variable<int>(pointsDelta.value);
    }
    if (itemsJson.present) {
      map['items_json'] = Variable<String>(itemsJson.value);
    }
    if (changeAmount.present) {
      map['change_amount'] = Variable<double>(changeAmount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrdersCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('customerId: $customerId, ')
          ..write('pointsDelta: $pointsDelta, ')
          ..write('itemsJson: $itemsJson, ')
          ..write('changeAmount: $changeAmount')
          ..write(')'))
        .toString();
  }
}

class $PaymentsTable extends Payments
    with TableInfo<$PaymentsTable, PaymentRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaymentsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _orderIdMeta = const VerificationMeta(
    'orderId',
  );
  @override
  late final GeneratedColumn<int> orderId = GeneratedColumn<int>(
    'order_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _methodValueMeta = const VerificationMeta(
    'methodValue',
  );
  @override
  late final GeneratedColumn<int> methodValue = GeneratedColumn<int>(
    'method_value',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<double> value = GeneratedColumn<double>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
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
    orderId,
    methodValue,
    value,
    amount,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'payments';
  @override
  VerificationContext validateIntegrity(
    Insertable<PaymentRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('order_id')) {
      context.handle(
        _orderIdMeta,
        orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta),
      );
    } else if (isInserting) {
      context.missing(_orderIdMeta);
    }
    if (data.containsKey('method_value')) {
      context.handle(
        _methodValueMeta,
        methodValue.isAcceptableOrUnknown(
          data['method_value']!,
          _methodValueMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_methodValueMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
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
  PaymentRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PaymentRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      orderId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order_id'],
      )!,
      methodValue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}method_value'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}value'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PaymentsTable createAlias(String alias) {
    return $PaymentsTable(attachedDatabase, alias);
  }
}

class PaymentRow extends DataClass implements Insertable<PaymentRow> {
  final int id;
  final int orderId;
  final int methodValue;
  final double value;
  final double amount;
  final DateTime createdAt;
  const PaymentRow({
    required this.id,
    required this.orderId,
    required this.methodValue,
    required this.value,
    required this.amount,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['order_id'] = Variable<int>(orderId);
    map['method_value'] = Variable<int>(methodValue);
    map['value'] = Variable<double>(value);
    map['amount'] = Variable<double>(amount);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PaymentsCompanion toCompanion(bool nullToAbsent) {
    return PaymentsCompanion(
      id: Value(id),
      orderId: Value(orderId),
      methodValue: Value(methodValue),
      value: Value(value),
      amount: Value(amount),
      createdAt: Value(createdAt),
    );
  }

  factory PaymentRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PaymentRow(
      id: serializer.fromJson<int>(json['id']),
      orderId: serializer.fromJson<int>(json['orderId']),
      methodValue: serializer.fromJson<int>(json['methodValue']),
      value: serializer.fromJson<double>(json['value']),
      amount: serializer.fromJson<double>(json['amount']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'orderId': serializer.toJson<int>(orderId),
      'methodValue': serializer.toJson<int>(methodValue),
      'value': serializer.toJson<double>(value),
      'amount': serializer.toJson<double>(amount),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  PaymentRow copyWith({
    int? id,
    int? orderId,
    int? methodValue,
    double? value,
    double? amount,
    DateTime? createdAt,
  }) => PaymentRow(
    id: id ?? this.id,
    orderId: orderId ?? this.orderId,
    methodValue: methodValue ?? this.methodValue,
    value: value ?? this.value,
    amount: amount ?? this.amount,
    createdAt: createdAt ?? this.createdAt,
  );
  PaymentRow copyWithCompanion(PaymentsCompanion data) {
    return PaymentRow(
      id: data.id.present ? data.id.value : this.id,
      orderId: data.orderId.present ? data.orderId.value : this.orderId,
      methodValue: data.methodValue.present
          ? data.methodValue.value
          : this.methodValue,
      value: data.value.present ? data.value.value : this.value,
      amount: data.amount.present ? data.amount.value : this.amount,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PaymentRow(')
          ..write('id: $id, ')
          ..write('orderId: $orderId, ')
          ..write('methodValue: $methodValue, ')
          ..write('value: $value, ')
          ..write('amount: $amount, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, orderId, methodValue, value, amount, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PaymentRow &&
          other.id == this.id &&
          other.orderId == this.orderId &&
          other.methodValue == this.methodValue &&
          other.value == this.value &&
          other.amount == this.amount &&
          other.createdAt == this.createdAt);
}

class PaymentsCompanion extends UpdateCompanion<PaymentRow> {
  final Value<int> id;
  final Value<int> orderId;
  final Value<int> methodValue;
  final Value<double> value;
  final Value<double> amount;
  final Value<DateTime> createdAt;
  const PaymentsCompanion({
    this.id = const Value.absent(),
    this.orderId = const Value.absent(),
    this.methodValue = const Value.absent(),
    this.value = const Value.absent(),
    this.amount = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  PaymentsCompanion.insert({
    this.id = const Value.absent(),
    required int orderId,
    required int methodValue,
    this.value = const Value.absent(),
    this.amount = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : orderId = Value(orderId),
       methodValue = Value(methodValue);
  static Insertable<PaymentRow> custom({
    Expression<int>? id,
    Expression<int>? orderId,
    Expression<int>? methodValue,
    Expression<double>? value,
    Expression<double>? amount,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (orderId != null) 'order_id': orderId,
      if (methodValue != null) 'method_value': methodValue,
      if (value != null) 'value': value,
      if (amount != null) 'amount': amount,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  PaymentsCompanion copyWith({
    Value<int>? id,
    Value<int>? orderId,
    Value<int>? methodValue,
    Value<double>? value,
    Value<double>? amount,
    Value<DateTime>? createdAt,
  }) {
    return PaymentsCompanion(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      methodValue: methodValue ?? this.methodValue,
      value: value ?? this.value,
      amount: amount ?? this.amount,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (orderId.present) {
      map['order_id'] = Variable<int>(orderId.value);
    }
    if (methodValue.present) {
      map['method_value'] = Variable<int>(methodValue.value);
    }
    if (value.present) {
      map['value'] = Variable<double>(value.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaymentsCompanion(')
          ..write('id: $id, ')
          ..write('orderId: $orderId, ')
          ..write('methodValue: $methodValue, ')
          ..write('value: $value, ')
          ..write('amount: $amount, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ProductBundlesTable extends ProductBundles
    with TableInfo<$ProductBundlesTable, ProductBundleRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductBundlesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _skuMeta = const VerificationMeta('sku');
  @override
  late final GeneratedColumn<String> sku = GeneratedColumn<String>(
    'sku',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
    'price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _itemsJsonMeta = const VerificationMeta(
    'itemsJson',
  );
  @override
  late final GeneratedColumn<String> itemsJson = GeneratedColumn<String>(
    'items_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
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
    defaultValue: const Constant(true),
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
    name,
    sku,
    price,
    itemsJson,
    isActive,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_bundles';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProductBundleRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('sku')) {
      context.handle(
        _skuMeta,
        sku.isAcceptableOrUnknown(data['sku']!, _skuMeta),
      );
    }
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    }
    if (data.containsKey('items_json')) {
      context.handle(
        _itemsJsonMeta,
        itemsJson.isAcceptableOrUnknown(data['items_json']!, _itemsJsonMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
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
  ProductBundleRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductBundleRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      sku: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sku'],
      ),
      price: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price'],
      )!,
      itemsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}items_json'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ProductBundlesTable createAlias(String alias) {
    return $ProductBundlesTable(attachedDatabase, alias);
  }
}

class ProductBundleRow extends DataClass
    implements Insertable<ProductBundleRow> {
  final int id;
  final String name;
  final String? sku;
  final double price;
  final String itemsJson;
  final bool isActive;
  final DateTime createdAt;
  const ProductBundleRow({
    required this.id,
    required this.name,
    this.sku,
    required this.price,
    required this.itemsJson,
    required this.isActive,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || sku != null) {
      map['sku'] = Variable<String>(sku);
    }
    map['price'] = Variable<double>(price);
    map['items_json'] = Variable<String>(itemsJson);
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ProductBundlesCompanion toCompanion(bool nullToAbsent) {
    return ProductBundlesCompanion(
      id: Value(id),
      name: Value(name),
      sku: sku == null && nullToAbsent ? const Value.absent() : Value(sku),
      price: Value(price),
      itemsJson: Value(itemsJson),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
    );
  }

  factory ProductBundleRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductBundleRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      sku: serializer.fromJson<String?>(json['sku']),
      price: serializer.fromJson<double>(json['price']),
      itemsJson: serializer.fromJson<String>(json['itemsJson']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'sku': serializer.toJson<String?>(sku),
      'price': serializer.toJson<double>(price),
      'itemsJson': serializer.toJson<String>(itemsJson),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ProductBundleRow copyWith({
    int? id,
    String? name,
    Value<String?> sku = const Value.absent(),
    double? price,
    String? itemsJson,
    bool? isActive,
    DateTime? createdAt,
  }) => ProductBundleRow(
    id: id ?? this.id,
    name: name ?? this.name,
    sku: sku.present ? sku.value : this.sku,
    price: price ?? this.price,
    itemsJson: itemsJson ?? this.itemsJson,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
  );
  ProductBundleRow copyWithCompanion(ProductBundlesCompanion data) {
    return ProductBundleRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      sku: data.sku.present ? data.sku.value : this.sku,
      price: data.price.present ? data.price.value : this.price,
      itemsJson: data.itemsJson.present ? data.itemsJson.value : this.itemsJson,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductBundleRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('sku: $sku, ')
          ..write('price: $price, ')
          ..write('itemsJson: $itemsJson, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, sku, price, itemsJson, isActive, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductBundleRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.sku == this.sku &&
          other.price == this.price &&
          other.itemsJson == this.itemsJson &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt);
}

class ProductBundlesCompanion extends UpdateCompanion<ProductBundleRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> sku;
  final Value<double> price;
  final Value<String> itemsJson;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  const ProductBundlesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.sku = const Value.absent(),
    this.price = const Value.absent(),
    this.itemsJson = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ProductBundlesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.sku = const Value.absent(),
    this.price = const Value.absent(),
    this.itemsJson = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<ProductBundleRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? sku,
    Expression<double>? price,
    Expression<String>? itemsJson,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (sku != null) 'sku': sku,
      if (price != null) 'price': price,
      if (itemsJson != null) 'items_json': itemsJson,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ProductBundlesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? sku,
    Value<double>? price,
    Value<String>? itemsJson,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
  }) {
    return ProductBundlesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      sku: sku ?? this.sku,
      price: price ?? this.price,
      itemsJson: itemsJson ?? this.itemsJson,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (sku.present) {
      map['sku'] = Variable<String>(sku.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (itemsJson.present) {
      map['items_json'] = Variable<String>(itemsJson.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductBundlesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('sku: $sku, ')
          ..write('price: $price, ')
          ..write('itemsJson: $itemsJson, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ProductPricesTable extends ProductPrices
    with TableInfo<$ProductPricesTable, ProductPriceRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductPricesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _storeIdMeta = const VerificationMeta(
    'storeId',
  );
  @override
  late final GeneratedColumn<int> storeId = GeneratedColumn<int>(
    'store_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
    'price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
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
  static const VerificationMeta _validFromMeta = const VerificationMeta(
    'validFrom',
  );
  @override
  late final GeneratedColumn<DateTime> validFrom = GeneratedColumn<DateTime>(
    'valid_from',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _validToMeta = const VerificationMeta(
    'validTo',
  );
  @override
  late final GeneratedColumn<DateTime> validTo = GeneratedColumn<DateTime>(
    'valid_to',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    productId,
    storeId,
    price,
    createdAt,
    validFrom,
    validTo,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_prices';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProductPriceRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('store_id')) {
      context.handle(
        _storeIdMeta,
        storeId.isAcceptableOrUnknown(data['store_id']!, _storeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_storeIdMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('valid_from')) {
      context.handle(
        _validFromMeta,
        validFrom.isAcceptableOrUnknown(data['valid_from']!, _validFromMeta),
      );
    }
    if (data.containsKey('valid_to')) {
      context.handle(
        _validToMeta,
        validTo.isAcceptableOrUnknown(data['valid_to']!, _validToMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductPriceRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductPriceRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_id'],
      )!,
      storeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}store_id'],
      )!,
      price: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      validFrom: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}valid_from'],
      ),
      validTo: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}valid_to'],
      ),
    );
  }

  @override
  $ProductPricesTable createAlias(String alias) {
    return $ProductPricesTable(attachedDatabase, alias);
  }
}

class ProductPriceRow extends DataClass implements Insertable<ProductPriceRow> {
  final int id;
  final int productId;
  final int storeId;
  final double price;
  final DateTime createdAt;
  final DateTime? validFrom;
  final DateTime? validTo;
  const ProductPriceRow({
    required this.id,
    required this.productId,
    required this.storeId,
    required this.price,
    required this.createdAt,
    this.validFrom,
    this.validTo,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['product_id'] = Variable<int>(productId);
    map['store_id'] = Variable<int>(storeId);
    map['price'] = Variable<double>(price);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || validFrom != null) {
      map['valid_from'] = Variable<DateTime>(validFrom);
    }
    if (!nullToAbsent || validTo != null) {
      map['valid_to'] = Variable<DateTime>(validTo);
    }
    return map;
  }

  ProductPricesCompanion toCompanion(bool nullToAbsent) {
    return ProductPricesCompanion(
      id: Value(id),
      productId: Value(productId),
      storeId: Value(storeId),
      price: Value(price),
      createdAt: Value(createdAt),
      validFrom: validFrom == null && nullToAbsent
          ? const Value.absent()
          : Value(validFrom),
      validTo: validTo == null && nullToAbsent
          ? const Value.absent()
          : Value(validTo),
    );
  }

  factory ProductPriceRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductPriceRow(
      id: serializer.fromJson<int>(json['id']),
      productId: serializer.fromJson<int>(json['productId']),
      storeId: serializer.fromJson<int>(json['storeId']),
      price: serializer.fromJson<double>(json['price']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      validFrom: serializer.fromJson<DateTime?>(json['validFrom']),
      validTo: serializer.fromJson<DateTime?>(json['validTo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productId': serializer.toJson<int>(productId),
      'storeId': serializer.toJson<int>(storeId),
      'price': serializer.toJson<double>(price),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'validFrom': serializer.toJson<DateTime?>(validFrom),
      'validTo': serializer.toJson<DateTime?>(validTo),
    };
  }

  ProductPriceRow copyWith({
    int? id,
    int? productId,
    int? storeId,
    double? price,
    DateTime? createdAt,
    Value<DateTime?> validFrom = const Value.absent(),
    Value<DateTime?> validTo = const Value.absent(),
  }) => ProductPriceRow(
    id: id ?? this.id,
    productId: productId ?? this.productId,
    storeId: storeId ?? this.storeId,
    price: price ?? this.price,
    createdAt: createdAt ?? this.createdAt,
    validFrom: validFrom.present ? validFrom.value : this.validFrom,
    validTo: validTo.present ? validTo.value : this.validTo,
  );
  ProductPriceRow copyWithCompanion(ProductPricesCompanion data) {
    return ProductPriceRow(
      id: data.id.present ? data.id.value : this.id,
      productId: data.productId.present ? data.productId.value : this.productId,
      storeId: data.storeId.present ? data.storeId.value : this.storeId,
      price: data.price.present ? data.price.value : this.price,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      validFrom: data.validFrom.present ? data.validFrom.value : this.validFrom,
      validTo: data.validTo.present ? data.validTo.value : this.validTo,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductPriceRow(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('storeId: $storeId, ')
          ..write('price: $price, ')
          ..write('createdAt: $createdAt, ')
          ..write('validFrom: $validFrom, ')
          ..write('validTo: $validTo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, productId, storeId, price, createdAt, validFrom, validTo);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductPriceRow &&
          other.id == this.id &&
          other.productId == this.productId &&
          other.storeId == this.storeId &&
          other.price == this.price &&
          other.createdAt == this.createdAt &&
          other.validFrom == this.validFrom &&
          other.validTo == this.validTo);
}

class ProductPricesCompanion extends UpdateCompanion<ProductPriceRow> {
  final Value<int> id;
  final Value<int> productId;
  final Value<int> storeId;
  final Value<double> price;
  final Value<DateTime> createdAt;
  final Value<DateTime?> validFrom;
  final Value<DateTime?> validTo;
  const ProductPricesCompanion({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.storeId = const Value.absent(),
    this.price = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.validFrom = const Value.absent(),
    this.validTo = const Value.absent(),
  });
  ProductPricesCompanion.insert({
    this.id = const Value.absent(),
    required int productId,
    required int storeId,
    this.price = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.validFrom = const Value.absent(),
    this.validTo = const Value.absent(),
  }) : productId = Value(productId),
       storeId = Value(storeId);
  static Insertable<ProductPriceRow> custom({
    Expression<int>? id,
    Expression<int>? productId,
    Expression<int>? storeId,
    Expression<double>? price,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? validFrom,
    Expression<DateTime>? validTo,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productId != null) 'product_id': productId,
      if (storeId != null) 'store_id': storeId,
      if (price != null) 'price': price,
      if (createdAt != null) 'created_at': createdAt,
      if (validFrom != null) 'valid_from': validFrom,
      if (validTo != null) 'valid_to': validTo,
    });
  }

  ProductPricesCompanion copyWith({
    Value<int>? id,
    Value<int>? productId,
    Value<int>? storeId,
    Value<double>? price,
    Value<DateTime>? createdAt,
    Value<DateTime?>? validFrom,
    Value<DateTime?>? validTo,
  }) {
    return ProductPricesCompanion(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      storeId: storeId ?? this.storeId,
      price: price ?? this.price,
      createdAt: createdAt ?? this.createdAt,
      validFrom: validFrom ?? this.validFrom,
      validTo: validTo ?? this.validTo,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (storeId.present) {
      map['store_id'] = Variable<int>(storeId.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (validFrom.present) {
      map['valid_from'] = Variable<DateTime>(validFrom.value);
    }
    if (validTo.present) {
      map['valid_to'] = Variable<DateTime>(validTo.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductPricesCompanion(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('storeId: $storeId, ')
          ..write('price: $price, ')
          ..write('createdAt: $createdAt, ')
          ..write('validFrom: $validFrom, ')
          ..write('validTo: $validTo')
          ..write(')'))
        .toString();
  }
}

class $ProductsTable extends Products
    with TableInfo<$ProductsTable, ProductRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _skuMeta = const VerificationMeta('sku');
  @override
  late final GeneratedColumn<String> sku = GeneratedColumn<String>(
    'sku',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _costPriceMeta = const VerificationMeta(
    'costPrice',
  );
  @override
  late final GeneratedColumn<double> costPrice = GeneratedColumn<double>(
    'cost_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _salePriceMeta = const VerificationMeta(
    'salePrice',
  );
  @override
  late final GeneratedColumn<double> salePrice = GeneratedColumn<double>(
    'sale_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _stockMeta = const VerificationMeta('stock');
  @override
  late final GeneratedColumn<int> stock = GeneratedColumn<int>(
    'stock',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lowStockThresholdMeta = const VerificationMeta(
    'lowStockThreshold',
  );
  @override
  late final GeneratedColumn<int> lowStockThreshold = GeneratedColumn<int>(
    'low_stock_threshold',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
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
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _barcodeMeta = const VerificationMeta(
    'barcode',
  );
  @override
  late final GeneratedColumn<String> barcode = GeneratedColumn<String>(
    'barcode',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    sku,
    costPrice,
    salePrice,
    stock,
    lowStockThreshold,
    category,
    description,
    barcode,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'products';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProductRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('sku')) {
      context.handle(
        _skuMeta,
        sku.isAcceptableOrUnknown(data['sku']!, _skuMeta),
      );
    } else if (isInserting) {
      context.missing(_skuMeta);
    }
    if (data.containsKey('cost_price')) {
      context.handle(
        _costPriceMeta,
        costPrice.isAcceptableOrUnknown(data['cost_price']!, _costPriceMeta),
      );
    }
    if (data.containsKey('sale_price')) {
      context.handle(
        _salePriceMeta,
        salePrice.isAcceptableOrUnknown(data['sale_price']!, _salePriceMeta),
      );
    }
    if (data.containsKey('stock')) {
      context.handle(
        _stockMeta,
        stock.isAcceptableOrUnknown(data['stock']!, _stockMeta),
      );
    }
    if (data.containsKey('low_stock_threshold')) {
      context.handle(
        _lowStockThresholdMeta,
        lowStockThreshold.isAcceptableOrUnknown(
          data['low_stock_threshold']!,
          _lowStockThresholdMeta,
        ),
      );
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('barcode')) {
      context.handle(
        _barcodeMeta,
        barcode.isAcceptableOrUnknown(data['barcode']!, _barcodeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      sku: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sku'],
      )!,
      costPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cost_price'],
      )!,
      salePrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}sale_price'],
      )!,
      stock: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}stock'],
      )!,
      lowStockThreshold: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}low_stock_threshold'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      barcode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}barcode'],
      ),
    );
  }

  @override
  $ProductsTable createAlias(String alias) {
    return $ProductsTable(attachedDatabase, alias);
  }
}

class ProductRow extends DataClass implements Insertable<ProductRow> {
  final int id;
  final String name;
  final String sku;
  final double costPrice;
  final double salePrice;
  final int stock;
  final int lowStockThreshold;
  final String? category;
  final String? description;
  final String? barcode;
  const ProductRow({
    required this.id,
    required this.name,
    required this.sku,
    required this.costPrice,
    required this.salePrice,
    required this.stock,
    required this.lowStockThreshold,
    this.category,
    this.description,
    this.barcode,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['sku'] = Variable<String>(sku);
    map['cost_price'] = Variable<double>(costPrice);
    map['sale_price'] = Variable<double>(salePrice);
    map['stock'] = Variable<int>(stock);
    map['low_stock_threshold'] = Variable<int>(lowStockThreshold);
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || barcode != null) {
      map['barcode'] = Variable<String>(barcode);
    }
    return map;
  }

  ProductsCompanion toCompanion(bool nullToAbsent) {
    return ProductsCompanion(
      id: Value(id),
      name: Value(name),
      sku: Value(sku),
      costPrice: Value(costPrice),
      salePrice: Value(salePrice),
      stock: Value(stock),
      lowStockThreshold: Value(lowStockThreshold),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      barcode: barcode == null && nullToAbsent
          ? const Value.absent()
          : Value(barcode),
    );
  }

  factory ProductRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      sku: serializer.fromJson<String>(json['sku']),
      costPrice: serializer.fromJson<double>(json['costPrice']),
      salePrice: serializer.fromJson<double>(json['salePrice']),
      stock: serializer.fromJson<int>(json['stock']),
      lowStockThreshold: serializer.fromJson<int>(json['lowStockThreshold']),
      category: serializer.fromJson<String?>(json['category']),
      description: serializer.fromJson<String?>(json['description']),
      barcode: serializer.fromJson<String?>(json['barcode']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'sku': serializer.toJson<String>(sku),
      'costPrice': serializer.toJson<double>(costPrice),
      'salePrice': serializer.toJson<double>(salePrice),
      'stock': serializer.toJson<int>(stock),
      'lowStockThreshold': serializer.toJson<int>(lowStockThreshold),
      'category': serializer.toJson<String?>(category),
      'description': serializer.toJson<String?>(description),
      'barcode': serializer.toJson<String?>(barcode),
    };
  }

  ProductRow copyWith({
    int? id,
    String? name,
    String? sku,
    double? costPrice,
    double? salePrice,
    int? stock,
    int? lowStockThreshold,
    Value<String?> category = const Value.absent(),
    Value<String?> description = const Value.absent(),
    Value<String?> barcode = const Value.absent(),
  }) => ProductRow(
    id: id ?? this.id,
    name: name ?? this.name,
    sku: sku ?? this.sku,
    costPrice: costPrice ?? this.costPrice,
    salePrice: salePrice ?? this.salePrice,
    stock: stock ?? this.stock,
    lowStockThreshold: lowStockThreshold ?? this.lowStockThreshold,
    category: category.present ? category.value : this.category,
    description: description.present ? description.value : this.description,
    barcode: barcode.present ? barcode.value : this.barcode,
  );
  ProductRow copyWithCompanion(ProductsCompanion data) {
    return ProductRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      sku: data.sku.present ? data.sku.value : this.sku,
      costPrice: data.costPrice.present ? data.costPrice.value : this.costPrice,
      salePrice: data.salePrice.present ? data.salePrice.value : this.salePrice,
      stock: data.stock.present ? data.stock.value : this.stock,
      lowStockThreshold: data.lowStockThreshold.present
          ? data.lowStockThreshold.value
          : this.lowStockThreshold,
      category: data.category.present ? data.category.value : this.category,
      description: data.description.present
          ? data.description.value
          : this.description,
      barcode: data.barcode.present ? data.barcode.value : this.barcode,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('sku: $sku, ')
          ..write('costPrice: $costPrice, ')
          ..write('salePrice: $salePrice, ')
          ..write('stock: $stock, ')
          ..write('lowStockThreshold: $lowStockThreshold, ')
          ..write('category: $category, ')
          ..write('description: $description, ')
          ..write('barcode: $barcode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    sku,
    costPrice,
    salePrice,
    stock,
    lowStockThreshold,
    category,
    description,
    barcode,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.sku == this.sku &&
          other.costPrice == this.costPrice &&
          other.salePrice == this.salePrice &&
          other.stock == this.stock &&
          other.lowStockThreshold == this.lowStockThreshold &&
          other.category == this.category &&
          other.description == this.description &&
          other.barcode == this.barcode);
}

class ProductsCompanion extends UpdateCompanion<ProductRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> sku;
  final Value<double> costPrice;
  final Value<double> salePrice;
  final Value<int> stock;
  final Value<int> lowStockThreshold;
  final Value<String?> category;
  final Value<String?> description;
  final Value<String?> barcode;
  const ProductsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.sku = const Value.absent(),
    this.costPrice = const Value.absent(),
    this.salePrice = const Value.absent(),
    this.stock = const Value.absent(),
    this.lowStockThreshold = const Value.absent(),
    this.category = const Value.absent(),
    this.description = const Value.absent(),
    this.barcode = const Value.absent(),
  });
  ProductsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String sku,
    this.costPrice = const Value.absent(),
    this.salePrice = const Value.absent(),
    this.stock = const Value.absent(),
    this.lowStockThreshold = const Value.absent(),
    this.category = const Value.absent(),
    this.description = const Value.absent(),
    this.barcode = const Value.absent(),
  }) : name = Value(name),
       sku = Value(sku);
  static Insertable<ProductRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? sku,
    Expression<double>? costPrice,
    Expression<double>? salePrice,
    Expression<int>? stock,
    Expression<int>? lowStockThreshold,
    Expression<String>? category,
    Expression<String>? description,
    Expression<String>? barcode,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (sku != null) 'sku': sku,
      if (costPrice != null) 'cost_price': costPrice,
      if (salePrice != null) 'sale_price': salePrice,
      if (stock != null) 'stock': stock,
      if (lowStockThreshold != null) 'low_stock_threshold': lowStockThreshold,
      if (category != null) 'category': category,
      if (description != null) 'description': description,
      if (barcode != null) 'barcode': barcode,
    });
  }

  ProductsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? sku,
    Value<double>? costPrice,
    Value<double>? salePrice,
    Value<int>? stock,
    Value<int>? lowStockThreshold,
    Value<String?>? category,
    Value<String?>? description,
    Value<String?>? barcode,
  }) {
    return ProductsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      sku: sku ?? this.sku,
      costPrice: costPrice ?? this.costPrice,
      salePrice: salePrice ?? this.salePrice,
      stock: stock ?? this.stock,
      lowStockThreshold: lowStockThreshold ?? this.lowStockThreshold,
      category: category ?? this.category,
      description: description ?? this.description,
      barcode: barcode ?? this.barcode,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (sku.present) {
      map['sku'] = Variable<String>(sku.value);
    }
    if (costPrice.present) {
      map['cost_price'] = Variable<double>(costPrice.value);
    }
    if (salePrice.present) {
      map['sale_price'] = Variable<double>(salePrice.value);
    }
    if (stock.present) {
      map['stock'] = Variable<int>(stock.value);
    }
    if (lowStockThreshold.present) {
      map['low_stock_threshold'] = Variable<int>(lowStockThreshold.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (barcode.present) {
      map['barcode'] = Variable<String>(barcode.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('sku: $sku, ')
          ..write('costPrice: $costPrice, ')
          ..write('salePrice: $salePrice, ')
          ..write('stock: $stock, ')
          ..write('lowStockThreshold: $lowStockThreshold, ')
          ..write('category: $category, ')
          ..write('description: $description, ')
          ..write('barcode: $barcode')
          ..write(')'))
        .toString();
  }
}

class $UnitsTable extends Units with TableInfo<$UnitsTable, UnitRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UnitsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
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
    defaultValue: const Constant(true),
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
  List<GeneratedColumn> get $columns => [id, name, key, isActive, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'units';
  @override
  VerificationContext validateIntegrity(
    Insertable<UnitRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
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
  UnitRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UnitRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $UnitsTable createAlias(String alias) {
    return $UnitsTable(attachedDatabase, alias);
  }
}

class UnitRow extends DataClass implements Insertable<UnitRow> {
  final int id;
  final String name;

  /// Normalized key (e.g. "thung", "lon", "cai") used for matching/search.
  final String key;
  final bool isActive;
  final DateTime createdAt;
  const UnitRow({
    required this.id,
    required this.name,
    required this.key,
    required this.isActive,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['key'] = Variable<String>(key);
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  UnitsCompanion toCompanion(bool nullToAbsent) {
    return UnitsCompanion(
      id: Value(id),
      name: Value(name),
      key: Value(key),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
    );
  }

  factory UnitRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UnitRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      key: serializer.fromJson<String>(json['key']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'key': serializer.toJson<String>(key),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  UnitRow copyWith({
    int? id,
    String? name,
    String? key,
    bool? isActive,
    DateTime? createdAt,
  }) => UnitRow(
    id: id ?? this.id,
    name: name ?? this.name,
    key: key ?? this.key,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
  );
  UnitRow copyWithCompanion(UnitsCompanion data) {
    return UnitRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      key: data.key.present ? data.key.value : this.key,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UnitRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('key: $key, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, key, isActive, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UnitRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.key == this.key &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt);
}

class UnitsCompanion extends UpdateCompanion<UnitRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> key;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  const UnitsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.key = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  UnitsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String key,
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : name = Value(name),
       key = Value(key);
  static Insertable<UnitRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? key,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (key != null) 'key': key,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  UnitsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? key,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
  }) {
    return UnitsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      key: key ?? this.key,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UnitsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('key: $key, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ProductUnitsTable extends ProductUnits
    with TableInfo<$ProductUnitsTable, ProductUnitRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductUnitsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES products (id)',
    ),
  );
  static const VerificationMeta _unitIdMeta = const VerificationMeta('unitId');
  @override
  late final GeneratedColumn<int> unitId = GeneratedColumn<int>(
    'unit_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES units (id)',
    ),
  );
  static const VerificationMeta _factorMeta = const VerificationMeta('factor');
  @override
  late final GeneratedColumn<double> factor = GeneratedColumn<double>(
    'factor',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1.0),
  );
  static const VerificationMeta _isBaseMeta = const VerificationMeta('isBase');
  @override
  late final GeneratedColumn<bool> isBase = GeneratedColumn<bool>(
    'is_base',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_base" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isDefaultMeta = const VerificationMeta(
    'isDefault',
  );
  @override
  late final GeneratedColumn<bool> isDefault = GeneratedColumn<bool>(
    'is_default',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_default" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _priceOverrideMeta = const VerificationMeta(
    'priceOverride',
  );
  @override
  late final GeneratedColumn<double> priceOverride = GeneratedColumn<double>(
    'price_override',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _skuMeta = const VerificationMeta('sku');
  @override
  late final GeneratedColumn<String> sku = GeneratedColumn<String>(
    'sku',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _barcodeMeta = const VerificationMeta(
    'barcode',
  );
  @override
  late final GeneratedColumn<String> barcode = GeneratedColumn<String>(
    'barcode',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
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
    productId,
    unitId,
    factor,
    isBase,
    isDefault,
    priceOverride,
    sku,
    barcode,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_units';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProductUnitRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('unit_id')) {
      context.handle(
        _unitIdMeta,
        unitId.isAcceptableOrUnknown(data['unit_id']!, _unitIdMeta),
      );
    } else if (isInserting) {
      context.missing(_unitIdMeta);
    }
    if (data.containsKey('factor')) {
      context.handle(
        _factorMeta,
        factor.isAcceptableOrUnknown(data['factor']!, _factorMeta),
      );
    }
    if (data.containsKey('is_base')) {
      context.handle(
        _isBaseMeta,
        isBase.isAcceptableOrUnknown(data['is_base']!, _isBaseMeta),
      );
    }
    if (data.containsKey('is_default')) {
      context.handle(
        _isDefaultMeta,
        isDefault.isAcceptableOrUnknown(data['is_default']!, _isDefaultMeta),
      );
    }
    if (data.containsKey('price_override')) {
      context.handle(
        _priceOverrideMeta,
        priceOverride.isAcceptableOrUnknown(
          data['price_override']!,
          _priceOverrideMeta,
        ),
      );
    }
    if (data.containsKey('sku')) {
      context.handle(
        _skuMeta,
        sku.isAcceptableOrUnknown(data['sku']!, _skuMeta),
      );
    }
    if (data.containsKey('barcode')) {
      context.handle(
        _barcodeMeta,
        barcode.isAcceptableOrUnknown(data['barcode']!, _barcodeMeta),
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
  Set<GeneratedColumn> get $primaryKey => {productId, unitId};
  @override
  ProductUnitRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductUnitRow(
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_id'],
      )!,
      unitId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}unit_id'],
      )!,
      factor: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}factor'],
      )!,
      isBase: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_base'],
      )!,
      isDefault: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_default'],
      )!,
      priceOverride: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price_override'],
      ),
      sku: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sku'],
      ),
      barcode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}barcode'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ProductUnitsTable createAlias(String alias) {
    return $ProductUnitsTable(attachedDatabase, alias);
  }
}

class ProductUnitRow extends DataClass implements Insertable<ProductUnitRow> {
  final int productId;
  final int unitId;

  /// Number of base units per 1 of this unit.
  final double factor;
  final bool isBase;
  final bool isDefault;

  /// Optional override sale price for this unit.
  final double? priceOverride;

  /// Optional per-unit SKU/barcode for scanning.
  final String? sku;
  final String? barcode;
  final DateTime createdAt;
  const ProductUnitRow({
    required this.productId,
    required this.unitId,
    required this.factor,
    required this.isBase,
    required this.isDefault,
    this.priceOverride,
    this.sku,
    this.barcode,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['product_id'] = Variable<int>(productId);
    map['unit_id'] = Variable<int>(unitId);
    map['factor'] = Variable<double>(factor);
    map['is_base'] = Variable<bool>(isBase);
    map['is_default'] = Variable<bool>(isDefault);
    if (!nullToAbsent || priceOverride != null) {
      map['price_override'] = Variable<double>(priceOverride);
    }
    if (!nullToAbsent || sku != null) {
      map['sku'] = Variable<String>(sku);
    }
    if (!nullToAbsent || barcode != null) {
      map['barcode'] = Variable<String>(barcode);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ProductUnitsCompanion toCompanion(bool nullToAbsent) {
    return ProductUnitsCompanion(
      productId: Value(productId),
      unitId: Value(unitId),
      factor: Value(factor),
      isBase: Value(isBase),
      isDefault: Value(isDefault),
      priceOverride: priceOverride == null && nullToAbsent
          ? const Value.absent()
          : Value(priceOverride),
      sku: sku == null && nullToAbsent ? const Value.absent() : Value(sku),
      barcode: barcode == null && nullToAbsent
          ? const Value.absent()
          : Value(barcode),
      createdAt: Value(createdAt),
    );
  }

  factory ProductUnitRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductUnitRow(
      productId: serializer.fromJson<int>(json['productId']),
      unitId: serializer.fromJson<int>(json['unitId']),
      factor: serializer.fromJson<double>(json['factor']),
      isBase: serializer.fromJson<bool>(json['isBase']),
      isDefault: serializer.fromJson<bool>(json['isDefault']),
      priceOverride: serializer.fromJson<double?>(json['priceOverride']),
      sku: serializer.fromJson<String?>(json['sku']),
      barcode: serializer.fromJson<String?>(json['barcode']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'productId': serializer.toJson<int>(productId),
      'unitId': serializer.toJson<int>(unitId),
      'factor': serializer.toJson<double>(factor),
      'isBase': serializer.toJson<bool>(isBase),
      'isDefault': serializer.toJson<bool>(isDefault),
      'priceOverride': serializer.toJson<double?>(priceOverride),
      'sku': serializer.toJson<String?>(sku),
      'barcode': serializer.toJson<String?>(barcode),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ProductUnitRow copyWith({
    int? productId,
    int? unitId,
    double? factor,
    bool? isBase,
    bool? isDefault,
    Value<double?> priceOverride = const Value.absent(),
    Value<String?> sku = const Value.absent(),
    Value<String?> barcode = const Value.absent(),
    DateTime? createdAt,
  }) => ProductUnitRow(
    productId: productId ?? this.productId,
    unitId: unitId ?? this.unitId,
    factor: factor ?? this.factor,
    isBase: isBase ?? this.isBase,
    isDefault: isDefault ?? this.isDefault,
    priceOverride: priceOverride.present
        ? priceOverride.value
        : this.priceOverride,
    sku: sku.present ? sku.value : this.sku,
    barcode: barcode.present ? barcode.value : this.barcode,
    createdAt: createdAt ?? this.createdAt,
  );
  ProductUnitRow copyWithCompanion(ProductUnitsCompanion data) {
    return ProductUnitRow(
      productId: data.productId.present ? data.productId.value : this.productId,
      unitId: data.unitId.present ? data.unitId.value : this.unitId,
      factor: data.factor.present ? data.factor.value : this.factor,
      isBase: data.isBase.present ? data.isBase.value : this.isBase,
      isDefault: data.isDefault.present ? data.isDefault.value : this.isDefault,
      priceOverride: data.priceOverride.present
          ? data.priceOverride.value
          : this.priceOverride,
      sku: data.sku.present ? data.sku.value : this.sku,
      barcode: data.barcode.present ? data.barcode.value : this.barcode,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductUnitRow(')
          ..write('productId: $productId, ')
          ..write('unitId: $unitId, ')
          ..write('factor: $factor, ')
          ..write('isBase: $isBase, ')
          ..write('isDefault: $isDefault, ')
          ..write('priceOverride: $priceOverride, ')
          ..write('sku: $sku, ')
          ..write('barcode: $barcode, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    productId,
    unitId,
    factor,
    isBase,
    isDefault,
    priceOverride,
    sku,
    barcode,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductUnitRow &&
          other.productId == this.productId &&
          other.unitId == this.unitId &&
          other.factor == this.factor &&
          other.isBase == this.isBase &&
          other.isDefault == this.isDefault &&
          other.priceOverride == this.priceOverride &&
          other.sku == this.sku &&
          other.barcode == this.barcode &&
          other.createdAt == this.createdAt);
}

class ProductUnitsCompanion extends UpdateCompanion<ProductUnitRow> {
  final Value<int> productId;
  final Value<int> unitId;
  final Value<double> factor;
  final Value<bool> isBase;
  final Value<bool> isDefault;
  final Value<double?> priceOverride;
  final Value<String?> sku;
  final Value<String?> barcode;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const ProductUnitsCompanion({
    this.productId = const Value.absent(),
    this.unitId = const Value.absent(),
    this.factor = const Value.absent(),
    this.isBase = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.priceOverride = const Value.absent(),
    this.sku = const Value.absent(),
    this.barcode = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductUnitsCompanion.insert({
    required int productId,
    required int unitId,
    this.factor = const Value.absent(),
    this.isBase = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.priceOverride = const Value.absent(),
    this.sku = const Value.absent(),
    this.barcode = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : productId = Value(productId),
       unitId = Value(unitId);
  static Insertable<ProductUnitRow> custom({
    Expression<int>? productId,
    Expression<int>? unitId,
    Expression<double>? factor,
    Expression<bool>? isBase,
    Expression<bool>? isDefault,
    Expression<double>? priceOverride,
    Expression<String>? sku,
    Expression<String>? barcode,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (productId != null) 'product_id': productId,
      if (unitId != null) 'unit_id': unitId,
      if (factor != null) 'factor': factor,
      if (isBase != null) 'is_base': isBase,
      if (isDefault != null) 'is_default': isDefault,
      if (priceOverride != null) 'price_override': priceOverride,
      if (sku != null) 'sku': sku,
      if (barcode != null) 'barcode': barcode,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductUnitsCompanion copyWith({
    Value<int>? productId,
    Value<int>? unitId,
    Value<double>? factor,
    Value<bool>? isBase,
    Value<bool>? isDefault,
    Value<double?>? priceOverride,
    Value<String?>? sku,
    Value<String?>? barcode,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return ProductUnitsCompanion(
      productId: productId ?? this.productId,
      unitId: unitId ?? this.unitId,
      factor: factor ?? this.factor,
      isBase: isBase ?? this.isBase,
      isDefault: isDefault ?? this.isDefault,
      priceOverride: priceOverride ?? this.priceOverride,
      sku: sku ?? this.sku,
      barcode: barcode ?? this.barcode,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (unitId.present) {
      map['unit_id'] = Variable<int>(unitId.value);
    }
    if (factor.present) {
      map['factor'] = Variable<double>(factor.value);
    }
    if (isBase.present) {
      map['is_base'] = Variable<bool>(isBase.value);
    }
    if (isDefault.present) {
      map['is_default'] = Variable<bool>(isDefault.value);
    }
    if (priceOverride.present) {
      map['price_override'] = Variable<double>(priceOverride.value);
    }
    if (sku.present) {
      map['sku'] = Variable<String>(sku.value);
    }
    if (barcode.present) {
      map['barcode'] = Variable<String>(barcode.value);
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
    return (StringBuffer('ProductUnitsCompanion(')
          ..write('productId: $productId, ')
          ..write('unitId: $unitId, ')
          ..write('factor: $factor, ')
          ..write('isBase: $isBase, ')
          ..write('isDefault: $isDefault, ')
          ..write('priceOverride: $priceOverride, ')
          ..write('sku: $sku, ')
          ..write('barcode: $barcode, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProductVariantsTable extends ProductVariants
    with TableInfo<$ProductVariantsTable, ProductVariantRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductVariantsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sizeMeta = const VerificationMeta('size');
  @override
  late final GeneratedColumn<String> size = GeneratedColumn<String>(
    'size',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
    'color',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _skuMeta = const VerificationMeta('sku');
  @override
  late final GeneratedColumn<String> sku = GeneratedColumn<String>(
    'sku',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _priceOverrideMeta = const VerificationMeta(
    'priceOverride',
  );
  @override
  late final GeneratedColumn<double> priceOverride = GeneratedColumn<double>(
    'price_override',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stockMeta = const VerificationMeta('stock');
  @override
  late final GeneratedColumn<int> stock = GeneratedColumn<int>(
    'stock',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
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
    defaultValue: const Constant(true),
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
    productId,
    size,
    color,
    sku,
    priceOverride,
    stock,
    isActive,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_variants';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProductVariantRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('size')) {
      context.handle(
        _sizeMeta,
        size.isAcceptableOrUnknown(data['size']!, _sizeMeta),
      );
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    }
    if (data.containsKey('sku')) {
      context.handle(
        _skuMeta,
        sku.isAcceptableOrUnknown(data['sku']!, _skuMeta),
      );
    }
    if (data.containsKey('price_override')) {
      context.handle(
        _priceOverrideMeta,
        priceOverride.isAcceptableOrUnknown(
          data['price_override']!,
          _priceOverrideMeta,
        ),
      );
    }
    if (data.containsKey('stock')) {
      context.handle(
        _stockMeta,
        stock.isAcceptableOrUnknown(data['stock']!, _stockMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
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
  ProductVariantRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductVariantRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_id'],
      )!,
      size: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}size'],
      ),
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color'],
      ),
      sku: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sku'],
      ),
      priceOverride: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price_override'],
      ),
      stock: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}stock'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ProductVariantsTable createAlias(String alias) {
    return $ProductVariantsTable(attachedDatabase, alias);
  }
}

class ProductVariantRow extends DataClass
    implements Insertable<ProductVariantRow> {
  final int id;
  final int productId;
  final String? size;
  final String? color;
  final String? sku;
  final double? priceOverride;
  final int stock;
  final bool isActive;
  final DateTime createdAt;
  const ProductVariantRow({
    required this.id,
    required this.productId,
    this.size,
    this.color,
    this.sku,
    this.priceOverride,
    required this.stock,
    required this.isActive,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['product_id'] = Variable<int>(productId);
    if (!nullToAbsent || size != null) {
      map['size'] = Variable<String>(size);
    }
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<String>(color);
    }
    if (!nullToAbsent || sku != null) {
      map['sku'] = Variable<String>(sku);
    }
    if (!nullToAbsent || priceOverride != null) {
      map['price_override'] = Variable<double>(priceOverride);
    }
    map['stock'] = Variable<int>(stock);
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ProductVariantsCompanion toCompanion(bool nullToAbsent) {
    return ProductVariantsCompanion(
      id: Value(id),
      productId: Value(productId),
      size: size == null && nullToAbsent ? const Value.absent() : Value(size),
      color: color == null && nullToAbsent
          ? const Value.absent()
          : Value(color),
      sku: sku == null && nullToAbsent ? const Value.absent() : Value(sku),
      priceOverride: priceOverride == null && nullToAbsent
          ? const Value.absent()
          : Value(priceOverride),
      stock: Value(stock),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
    );
  }

  factory ProductVariantRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductVariantRow(
      id: serializer.fromJson<int>(json['id']),
      productId: serializer.fromJson<int>(json['productId']),
      size: serializer.fromJson<String?>(json['size']),
      color: serializer.fromJson<String?>(json['color']),
      sku: serializer.fromJson<String?>(json['sku']),
      priceOverride: serializer.fromJson<double?>(json['priceOverride']),
      stock: serializer.fromJson<int>(json['stock']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productId': serializer.toJson<int>(productId),
      'size': serializer.toJson<String?>(size),
      'color': serializer.toJson<String?>(color),
      'sku': serializer.toJson<String?>(sku),
      'priceOverride': serializer.toJson<double?>(priceOverride),
      'stock': serializer.toJson<int>(stock),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ProductVariantRow copyWith({
    int? id,
    int? productId,
    Value<String?> size = const Value.absent(),
    Value<String?> color = const Value.absent(),
    Value<String?> sku = const Value.absent(),
    Value<double?> priceOverride = const Value.absent(),
    int? stock,
    bool? isActive,
    DateTime? createdAt,
  }) => ProductVariantRow(
    id: id ?? this.id,
    productId: productId ?? this.productId,
    size: size.present ? size.value : this.size,
    color: color.present ? color.value : this.color,
    sku: sku.present ? sku.value : this.sku,
    priceOverride: priceOverride.present
        ? priceOverride.value
        : this.priceOverride,
    stock: stock ?? this.stock,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
  );
  ProductVariantRow copyWithCompanion(ProductVariantsCompanion data) {
    return ProductVariantRow(
      id: data.id.present ? data.id.value : this.id,
      productId: data.productId.present ? data.productId.value : this.productId,
      size: data.size.present ? data.size.value : this.size,
      color: data.color.present ? data.color.value : this.color,
      sku: data.sku.present ? data.sku.value : this.sku,
      priceOverride: data.priceOverride.present
          ? data.priceOverride.value
          : this.priceOverride,
      stock: data.stock.present ? data.stock.value : this.stock,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductVariantRow(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('size: $size, ')
          ..write('color: $color, ')
          ..write('sku: $sku, ')
          ..write('priceOverride: $priceOverride, ')
          ..write('stock: $stock, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    productId,
    size,
    color,
    sku,
    priceOverride,
    stock,
    isActive,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductVariantRow &&
          other.id == this.id &&
          other.productId == this.productId &&
          other.size == this.size &&
          other.color == this.color &&
          other.sku == this.sku &&
          other.priceOverride == this.priceOverride &&
          other.stock == this.stock &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt);
}

class ProductVariantsCompanion extends UpdateCompanion<ProductVariantRow> {
  final Value<int> id;
  final Value<int> productId;
  final Value<String?> size;
  final Value<String?> color;
  final Value<String?> sku;
  final Value<double?> priceOverride;
  final Value<int> stock;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  const ProductVariantsCompanion({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.size = const Value.absent(),
    this.color = const Value.absent(),
    this.sku = const Value.absent(),
    this.priceOverride = const Value.absent(),
    this.stock = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ProductVariantsCompanion.insert({
    this.id = const Value.absent(),
    required int productId,
    this.size = const Value.absent(),
    this.color = const Value.absent(),
    this.sku = const Value.absent(),
    this.priceOverride = const Value.absent(),
    this.stock = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : productId = Value(productId);
  static Insertable<ProductVariantRow> custom({
    Expression<int>? id,
    Expression<int>? productId,
    Expression<String>? size,
    Expression<String>? color,
    Expression<String>? sku,
    Expression<double>? priceOverride,
    Expression<int>? stock,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productId != null) 'product_id': productId,
      if (size != null) 'size': size,
      if (color != null) 'color': color,
      if (sku != null) 'sku': sku,
      if (priceOverride != null) 'price_override': priceOverride,
      if (stock != null) 'stock': stock,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ProductVariantsCompanion copyWith({
    Value<int>? id,
    Value<int>? productId,
    Value<String?>? size,
    Value<String?>? color,
    Value<String?>? sku,
    Value<double?>? priceOverride,
    Value<int>? stock,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
  }) {
    return ProductVariantsCompanion(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      size: size ?? this.size,
      color: color ?? this.color,
      sku: sku ?? this.sku,
      priceOverride: priceOverride ?? this.priceOverride,
      stock: stock ?? this.stock,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (size.present) {
      map['size'] = Variable<String>(size.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (sku.present) {
      map['sku'] = Variable<String>(sku.value);
    }
    if (priceOverride.present) {
      map['price_override'] = Variable<double>(priceOverride.value);
    }
    if (stock.present) {
      map['stock'] = Variable<int>(stock.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductVariantsCompanion(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('size: $size, ')
          ..write('color: $color, ')
          ..write('sku: $sku, ')
          ..write('priceOverride: $priceOverride, ')
          ..write('stock: $stock, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $PromotionsTable extends Promotions
    with TableInfo<$PromotionsTable, PromotionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PromotionsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _couponCodeMeta = const VerificationMeta(
    'couponCode',
  );
  @override
  late final GeneratedColumn<String> couponCode = GeneratedColumn<String>(
    'coupon_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _typeValueMeta = const VerificationMeta(
    'typeValue',
  );
  @override
  late final GeneratedColumn<int> typeValue = GeneratedColumn<int>(
    'type_value',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<double> value = GeneratedColumn<double>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _startAtMeta = const VerificationMeta(
    'startAt',
  );
  @override
  late final GeneratedColumn<DateTime> startAt = GeneratedColumn<DateTime>(
    'start_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _endAtMeta = const VerificationMeta('endAt');
  @override
  late final GeneratedColumn<DateTime> endAt = GeneratedColumn<DateTime>(
    'end_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    couponCode,
    typeValue,
    value,
    startAt,
    endAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'promotions';
  @override
  VerificationContext validateIntegrity(
    Insertable<PromotionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('coupon_code')) {
      context.handle(
        _couponCodeMeta,
        couponCode.isAcceptableOrUnknown(data['coupon_code']!, _couponCodeMeta),
      );
    }
    if (data.containsKey('type_value')) {
      context.handle(
        _typeValueMeta,
        typeValue.isAcceptableOrUnknown(data['type_value']!, _typeValueMeta),
      );
    } else if (isInserting) {
      context.missing(_typeValueMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    }
    if (data.containsKey('start_at')) {
      context.handle(
        _startAtMeta,
        startAt.isAcceptableOrUnknown(data['start_at']!, _startAtMeta),
      );
    }
    if (data.containsKey('end_at')) {
      context.handle(
        _endAtMeta,
        endAt.isAcceptableOrUnknown(data['end_at']!, _endAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PromotionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PromotionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      couponCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}coupon_code'],
      ),
      typeValue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}type_value'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}value'],
      )!,
      startAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_at'],
      ),
      endAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_at'],
      ),
    );
  }

  @override
  $PromotionsTable createAlias(String alias) {
    return $PromotionsTable(attachedDatabase, alias);
  }
}

class PromotionRow extends DataClass implements Insertable<PromotionRow> {
  final int id;
  final String name;
  final String? couponCode;
  final int typeValue;
  final double value;
  final DateTime? startAt;
  final DateTime? endAt;
  const PromotionRow({
    required this.id,
    required this.name,
    this.couponCode,
    required this.typeValue,
    required this.value,
    this.startAt,
    this.endAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || couponCode != null) {
      map['coupon_code'] = Variable<String>(couponCode);
    }
    map['type_value'] = Variable<int>(typeValue);
    map['value'] = Variable<double>(value);
    if (!nullToAbsent || startAt != null) {
      map['start_at'] = Variable<DateTime>(startAt);
    }
    if (!nullToAbsent || endAt != null) {
      map['end_at'] = Variable<DateTime>(endAt);
    }
    return map;
  }

  PromotionsCompanion toCompanion(bool nullToAbsent) {
    return PromotionsCompanion(
      id: Value(id),
      name: Value(name),
      couponCode: couponCode == null && nullToAbsent
          ? const Value.absent()
          : Value(couponCode),
      typeValue: Value(typeValue),
      value: Value(value),
      startAt: startAt == null && nullToAbsent
          ? const Value.absent()
          : Value(startAt),
      endAt: endAt == null && nullToAbsent
          ? const Value.absent()
          : Value(endAt),
    );
  }

  factory PromotionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PromotionRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      couponCode: serializer.fromJson<String?>(json['couponCode']),
      typeValue: serializer.fromJson<int>(json['typeValue']),
      value: serializer.fromJson<double>(json['value']),
      startAt: serializer.fromJson<DateTime?>(json['startAt']),
      endAt: serializer.fromJson<DateTime?>(json['endAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'couponCode': serializer.toJson<String?>(couponCode),
      'typeValue': serializer.toJson<int>(typeValue),
      'value': serializer.toJson<double>(value),
      'startAt': serializer.toJson<DateTime?>(startAt),
      'endAt': serializer.toJson<DateTime?>(endAt),
    };
  }

  PromotionRow copyWith({
    int? id,
    String? name,
    Value<String?> couponCode = const Value.absent(),
    int? typeValue,
    double? value,
    Value<DateTime?> startAt = const Value.absent(),
    Value<DateTime?> endAt = const Value.absent(),
  }) => PromotionRow(
    id: id ?? this.id,
    name: name ?? this.name,
    couponCode: couponCode.present ? couponCode.value : this.couponCode,
    typeValue: typeValue ?? this.typeValue,
    value: value ?? this.value,
    startAt: startAt.present ? startAt.value : this.startAt,
    endAt: endAt.present ? endAt.value : this.endAt,
  );
  PromotionRow copyWithCompanion(PromotionsCompanion data) {
    return PromotionRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      couponCode: data.couponCode.present
          ? data.couponCode.value
          : this.couponCode,
      typeValue: data.typeValue.present ? data.typeValue.value : this.typeValue,
      value: data.value.present ? data.value.value : this.value,
      startAt: data.startAt.present ? data.startAt.value : this.startAt,
      endAt: data.endAt.present ? data.endAt.value : this.endAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PromotionRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('couponCode: $couponCode, ')
          ..write('typeValue: $typeValue, ')
          ..write('value: $value, ')
          ..write('startAt: $startAt, ')
          ..write('endAt: $endAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, couponCode, typeValue, value, startAt, endAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PromotionRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.couponCode == this.couponCode &&
          other.typeValue == this.typeValue &&
          other.value == this.value &&
          other.startAt == this.startAt &&
          other.endAt == this.endAt);
}

class PromotionsCompanion extends UpdateCompanion<PromotionRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> couponCode;
  final Value<int> typeValue;
  final Value<double> value;
  final Value<DateTime?> startAt;
  final Value<DateTime?> endAt;
  const PromotionsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.couponCode = const Value.absent(),
    this.typeValue = const Value.absent(),
    this.value = const Value.absent(),
    this.startAt = const Value.absent(),
    this.endAt = const Value.absent(),
  });
  PromotionsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.couponCode = const Value.absent(),
    required int typeValue,
    this.value = const Value.absent(),
    this.startAt = const Value.absent(),
    this.endAt = const Value.absent(),
  }) : name = Value(name),
       typeValue = Value(typeValue);
  static Insertable<PromotionRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? couponCode,
    Expression<int>? typeValue,
    Expression<double>? value,
    Expression<DateTime>? startAt,
    Expression<DateTime>? endAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (couponCode != null) 'coupon_code': couponCode,
      if (typeValue != null) 'type_value': typeValue,
      if (value != null) 'value': value,
      if (startAt != null) 'start_at': startAt,
      if (endAt != null) 'end_at': endAt,
    });
  }

  PromotionsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? couponCode,
    Value<int>? typeValue,
    Value<double>? value,
    Value<DateTime?>? startAt,
    Value<DateTime?>? endAt,
  }) {
    return PromotionsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      couponCode: couponCode ?? this.couponCode,
      typeValue: typeValue ?? this.typeValue,
      value: value ?? this.value,
      startAt: startAt ?? this.startAt,
      endAt: endAt ?? this.endAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (couponCode.present) {
      map['coupon_code'] = Variable<String>(couponCode.value);
    }
    if (typeValue.present) {
      map['type_value'] = Variable<int>(typeValue.value);
    }
    if (value.present) {
      map['value'] = Variable<double>(value.value);
    }
    if (startAt.present) {
      map['start_at'] = Variable<DateTime>(startAt.value);
    }
    if (endAt.present) {
      map['end_at'] = Variable<DateTime>(endAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PromotionsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('couponCode: $couponCode, ')
          ..write('typeValue: $typeValue, ')
          ..write('value: $value, ')
          ..write('startAt: $startAt, ')
          ..write('endAt: $endAt')
          ..write(')'))
        .toString();
  }
}

class $PurchaseOrdersTable extends PurchaseOrders
    with TableInfo<$PurchaseOrdersTable, PurchaseOrderRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PurchaseOrdersTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _supplierIdMeta = const VerificationMeta(
    'supplierId',
  );
  @override
  late final GeneratedColumn<int> supplierId = GeneratedColumn<int>(
    'supplier_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
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
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('open'),
  );
  static const VerificationMeta _itemsJsonMeta = const VerificationMeta(
    'itemsJson',
  );
  @override
  late final GeneratedColumn<String> itemsJson = GeneratedColumn<String>(
    'items_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    supplierId,
    createdAt,
    status,
    itemsJson,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'purchase_orders';
  @override
  VerificationContext validateIntegrity(
    Insertable<PurchaseOrderRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('supplier_id')) {
      context.handle(
        _supplierIdMeta,
        supplierId.isAcceptableOrUnknown(data['supplier_id']!, _supplierIdMeta),
      );
    } else if (isInserting) {
      context.missing(_supplierIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('items_json')) {
      context.handle(
        _itemsJsonMeta,
        itemsJson.isAcceptableOrUnknown(data['items_json']!, _itemsJsonMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PurchaseOrderRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PurchaseOrderRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      supplierId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}supplier_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      itemsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}items_json'],
      )!,
    );
  }

  @override
  $PurchaseOrdersTable createAlias(String alias) {
    return $PurchaseOrdersTable(attachedDatabase, alias);
  }
}

class PurchaseOrderRow extends DataClass
    implements Insertable<PurchaseOrderRow> {
  final int id;
  final int supplierId;
  final DateTime createdAt;
  final String status;
  final String itemsJson;
  const PurchaseOrderRow({
    required this.id,
    required this.supplierId,
    required this.createdAt,
    required this.status,
    required this.itemsJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['supplier_id'] = Variable<int>(supplierId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['status'] = Variable<String>(status);
    map['items_json'] = Variable<String>(itemsJson);
    return map;
  }

  PurchaseOrdersCompanion toCompanion(bool nullToAbsent) {
    return PurchaseOrdersCompanion(
      id: Value(id),
      supplierId: Value(supplierId),
      createdAt: Value(createdAt),
      status: Value(status),
      itemsJson: Value(itemsJson),
    );
  }

  factory PurchaseOrderRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PurchaseOrderRow(
      id: serializer.fromJson<int>(json['id']),
      supplierId: serializer.fromJson<int>(json['supplierId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      status: serializer.fromJson<String>(json['status']),
      itemsJson: serializer.fromJson<String>(json['itemsJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'supplierId': serializer.toJson<int>(supplierId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'status': serializer.toJson<String>(status),
      'itemsJson': serializer.toJson<String>(itemsJson),
    };
  }

  PurchaseOrderRow copyWith({
    int? id,
    int? supplierId,
    DateTime? createdAt,
    String? status,
    String? itemsJson,
  }) => PurchaseOrderRow(
    id: id ?? this.id,
    supplierId: supplierId ?? this.supplierId,
    createdAt: createdAt ?? this.createdAt,
    status: status ?? this.status,
    itemsJson: itemsJson ?? this.itemsJson,
  );
  PurchaseOrderRow copyWithCompanion(PurchaseOrdersCompanion data) {
    return PurchaseOrderRow(
      id: data.id.present ? data.id.value : this.id,
      supplierId: data.supplierId.present
          ? data.supplierId.value
          : this.supplierId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      status: data.status.present ? data.status.value : this.status,
      itemsJson: data.itemsJson.present ? data.itemsJson.value : this.itemsJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseOrderRow(')
          ..write('id: $id, ')
          ..write('supplierId: $supplierId, ')
          ..write('createdAt: $createdAt, ')
          ..write('status: $status, ')
          ..write('itemsJson: $itemsJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, supplierId, createdAt, status, itemsJson);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PurchaseOrderRow &&
          other.id == this.id &&
          other.supplierId == this.supplierId &&
          other.createdAt == this.createdAt &&
          other.status == this.status &&
          other.itemsJson == this.itemsJson);
}

class PurchaseOrdersCompanion extends UpdateCompanion<PurchaseOrderRow> {
  final Value<int> id;
  final Value<int> supplierId;
  final Value<DateTime> createdAt;
  final Value<String> status;
  final Value<String> itemsJson;
  const PurchaseOrdersCompanion({
    this.id = const Value.absent(),
    this.supplierId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.status = const Value.absent(),
    this.itemsJson = const Value.absent(),
  });
  PurchaseOrdersCompanion.insert({
    this.id = const Value.absent(),
    required int supplierId,
    this.createdAt = const Value.absent(),
    this.status = const Value.absent(),
    this.itemsJson = const Value.absent(),
  }) : supplierId = Value(supplierId);
  static Insertable<PurchaseOrderRow> custom({
    Expression<int>? id,
    Expression<int>? supplierId,
    Expression<DateTime>? createdAt,
    Expression<String>? status,
    Expression<String>? itemsJson,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (supplierId != null) 'supplier_id': supplierId,
      if (createdAt != null) 'created_at': createdAt,
      if (status != null) 'status': status,
      if (itemsJson != null) 'items_json': itemsJson,
    });
  }

  PurchaseOrdersCompanion copyWith({
    Value<int>? id,
    Value<int>? supplierId,
    Value<DateTime>? createdAt,
    Value<String>? status,
    Value<String>? itemsJson,
  }) {
    return PurchaseOrdersCompanion(
      id: id ?? this.id,
      supplierId: supplierId ?? this.supplierId,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      itemsJson: itemsJson ?? this.itemsJson,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (supplierId.present) {
      map['supplier_id'] = Variable<int>(supplierId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (itemsJson.present) {
      map['items_json'] = Variable<String>(itemsJson.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseOrdersCompanion(')
          ..write('id: $id, ')
          ..write('supplierId: $supplierId, ')
          ..write('createdAt: $createdAt, ')
          ..write('status: $status, ')
          ..write('itemsJson: $itemsJson')
          ..write(')'))
        .toString();
  }
}

class $ReturnsTable extends Returns with TableInfo<$ReturnsTable, ReturnRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReturnsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _originalOrderIdMeta = const VerificationMeta(
    'originalOrderId',
  );
  @override
  late final GeneratedColumn<int> originalOrderId = GeneratedColumn<int>(
    'original_order_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
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
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
    'reason',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _refundAmountMeta = const VerificationMeta(
    'refundAmount',
  );
  @override
  late final GeneratedColumn<double> refundAmount = GeneratedColumn<double>(
    'refund_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _itemsJsonMeta = const VerificationMeta(
    'itemsJson',
  );
  @override
  late final GeneratedColumn<String> itemsJson = GeneratedColumn<String>(
    'items_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _customerIdMeta = const VerificationMeta(
    'customerId',
  );
  @override
  late final GeneratedColumn<int> customerId = GeneratedColumn<int>(
    'customer_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    originalOrderId,
    createdAt,
    reason,
    notes,
    refundAmount,
    itemsJson,
    customerId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'returns';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReturnRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('original_order_id')) {
      context.handle(
        _originalOrderIdMeta,
        originalOrderId.isAcceptableOrUnknown(
          data['original_order_id']!,
          _originalOrderIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_originalOrderIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('reason')) {
      context.handle(
        _reasonMeta,
        reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('refund_amount')) {
      context.handle(
        _refundAmountMeta,
        refundAmount.isAcceptableOrUnknown(
          data['refund_amount']!,
          _refundAmountMeta,
        ),
      );
    }
    if (data.containsKey('items_json')) {
      context.handle(
        _itemsJsonMeta,
        itemsJson.isAcceptableOrUnknown(data['items_json']!, _itemsJsonMeta),
      );
    }
    if (data.containsKey('customer_id')) {
      context.handle(
        _customerIdMeta,
        customerId.isAcceptableOrUnknown(data['customer_id']!, _customerIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReturnRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReturnRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      originalOrderId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}original_order_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      reason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reason'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      )!,
      refundAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}refund_amount'],
      )!,
      itemsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}items_json'],
      )!,
      customerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}customer_id'],
      ),
    );
  }

  @override
  $ReturnsTable createAlias(String alias) {
    return $ReturnsTable(attachedDatabase, alias);
  }
}

class ReturnRow extends DataClass implements Insertable<ReturnRow> {
  final int id;
  final int originalOrderId;
  final DateTime createdAt;
  final String reason;
  final String notes;
  final double refundAmount;
  final String itemsJson;
  final int? customerId;
  const ReturnRow({
    required this.id,
    required this.originalOrderId,
    required this.createdAt,
    required this.reason,
    required this.notes,
    required this.refundAmount,
    required this.itemsJson,
    this.customerId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['original_order_id'] = Variable<int>(originalOrderId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['reason'] = Variable<String>(reason);
    map['notes'] = Variable<String>(notes);
    map['refund_amount'] = Variable<double>(refundAmount);
    map['items_json'] = Variable<String>(itemsJson);
    if (!nullToAbsent || customerId != null) {
      map['customer_id'] = Variable<int>(customerId);
    }
    return map;
  }

  ReturnsCompanion toCompanion(bool nullToAbsent) {
    return ReturnsCompanion(
      id: Value(id),
      originalOrderId: Value(originalOrderId),
      createdAt: Value(createdAt),
      reason: Value(reason),
      notes: Value(notes),
      refundAmount: Value(refundAmount),
      itemsJson: Value(itemsJson),
      customerId: customerId == null && nullToAbsent
          ? const Value.absent()
          : Value(customerId),
    );
  }

  factory ReturnRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReturnRow(
      id: serializer.fromJson<int>(json['id']),
      originalOrderId: serializer.fromJson<int>(json['originalOrderId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      reason: serializer.fromJson<String>(json['reason']),
      notes: serializer.fromJson<String>(json['notes']),
      refundAmount: serializer.fromJson<double>(json['refundAmount']),
      itemsJson: serializer.fromJson<String>(json['itemsJson']),
      customerId: serializer.fromJson<int?>(json['customerId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'originalOrderId': serializer.toJson<int>(originalOrderId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'reason': serializer.toJson<String>(reason),
      'notes': serializer.toJson<String>(notes),
      'refundAmount': serializer.toJson<double>(refundAmount),
      'itemsJson': serializer.toJson<String>(itemsJson),
      'customerId': serializer.toJson<int?>(customerId),
    };
  }

  ReturnRow copyWith({
    int? id,
    int? originalOrderId,
    DateTime? createdAt,
    String? reason,
    String? notes,
    double? refundAmount,
    String? itemsJson,
    Value<int?> customerId = const Value.absent(),
  }) => ReturnRow(
    id: id ?? this.id,
    originalOrderId: originalOrderId ?? this.originalOrderId,
    createdAt: createdAt ?? this.createdAt,
    reason: reason ?? this.reason,
    notes: notes ?? this.notes,
    refundAmount: refundAmount ?? this.refundAmount,
    itemsJson: itemsJson ?? this.itemsJson,
    customerId: customerId.present ? customerId.value : this.customerId,
  );
  ReturnRow copyWithCompanion(ReturnsCompanion data) {
    return ReturnRow(
      id: data.id.present ? data.id.value : this.id,
      originalOrderId: data.originalOrderId.present
          ? data.originalOrderId.value
          : this.originalOrderId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      reason: data.reason.present ? data.reason.value : this.reason,
      notes: data.notes.present ? data.notes.value : this.notes,
      refundAmount: data.refundAmount.present
          ? data.refundAmount.value
          : this.refundAmount,
      itemsJson: data.itemsJson.present ? data.itemsJson.value : this.itemsJson,
      customerId: data.customerId.present
          ? data.customerId.value
          : this.customerId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReturnRow(')
          ..write('id: $id, ')
          ..write('originalOrderId: $originalOrderId, ')
          ..write('createdAt: $createdAt, ')
          ..write('reason: $reason, ')
          ..write('notes: $notes, ')
          ..write('refundAmount: $refundAmount, ')
          ..write('itemsJson: $itemsJson, ')
          ..write('customerId: $customerId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    originalOrderId,
    createdAt,
    reason,
    notes,
    refundAmount,
    itemsJson,
    customerId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReturnRow &&
          other.id == this.id &&
          other.originalOrderId == this.originalOrderId &&
          other.createdAt == this.createdAt &&
          other.reason == this.reason &&
          other.notes == this.notes &&
          other.refundAmount == this.refundAmount &&
          other.itemsJson == this.itemsJson &&
          other.customerId == this.customerId);
}

class ReturnsCompanion extends UpdateCompanion<ReturnRow> {
  final Value<int> id;
  final Value<int> originalOrderId;
  final Value<DateTime> createdAt;
  final Value<String> reason;
  final Value<String> notes;
  final Value<double> refundAmount;
  final Value<String> itemsJson;
  final Value<int?> customerId;
  const ReturnsCompanion({
    this.id = const Value.absent(),
    this.originalOrderId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.reason = const Value.absent(),
    this.notes = const Value.absent(),
    this.refundAmount = const Value.absent(),
    this.itemsJson = const Value.absent(),
    this.customerId = const Value.absent(),
  });
  ReturnsCompanion.insert({
    this.id = const Value.absent(),
    required int originalOrderId,
    this.createdAt = const Value.absent(),
    this.reason = const Value.absent(),
    this.notes = const Value.absent(),
    this.refundAmount = const Value.absent(),
    this.itemsJson = const Value.absent(),
    this.customerId = const Value.absent(),
  }) : originalOrderId = Value(originalOrderId);
  static Insertable<ReturnRow> custom({
    Expression<int>? id,
    Expression<int>? originalOrderId,
    Expression<DateTime>? createdAt,
    Expression<String>? reason,
    Expression<String>? notes,
    Expression<double>? refundAmount,
    Expression<String>? itemsJson,
    Expression<int>? customerId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (originalOrderId != null) 'original_order_id': originalOrderId,
      if (createdAt != null) 'created_at': createdAt,
      if (reason != null) 'reason': reason,
      if (notes != null) 'notes': notes,
      if (refundAmount != null) 'refund_amount': refundAmount,
      if (itemsJson != null) 'items_json': itemsJson,
      if (customerId != null) 'customer_id': customerId,
    });
  }

  ReturnsCompanion copyWith({
    Value<int>? id,
    Value<int>? originalOrderId,
    Value<DateTime>? createdAt,
    Value<String>? reason,
    Value<String>? notes,
    Value<double>? refundAmount,
    Value<String>? itemsJson,
    Value<int?>? customerId,
  }) {
    return ReturnsCompanion(
      id: id ?? this.id,
      originalOrderId: originalOrderId ?? this.originalOrderId,
      createdAt: createdAt ?? this.createdAt,
      reason: reason ?? this.reason,
      notes: notes ?? this.notes,
      refundAmount: refundAmount ?? this.refundAmount,
      itemsJson: itemsJson ?? this.itemsJson,
      customerId: customerId ?? this.customerId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (originalOrderId.present) {
      map['original_order_id'] = Variable<int>(originalOrderId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (refundAmount.present) {
      map['refund_amount'] = Variable<double>(refundAmount.value);
    }
    if (itemsJson.present) {
      map['items_json'] = Variable<String>(itemsJson.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<int>(customerId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReturnsCompanion(')
          ..write('id: $id, ')
          ..write('originalOrderId: $originalOrderId, ')
          ..write('createdAt: $createdAt, ')
          ..write('reason: $reason, ')
          ..write('notes: $notes, ')
          ..write('refundAmount: $refundAmount, ')
          ..write('itemsJson: $itemsJson, ')
          ..write('customerId: $customerId')
          ..write(')'))
        .toString();
  }
}

class $StockAdjustmentsTable extends StockAdjustments
    with TableInfo<$StockAdjustmentsTable, StockAdjustmentRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StockAdjustmentsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deltaMeta = const VerificationMeta('delta');
  @override
  late final GeneratedColumn<int> delta = GeneratedColumn<int>(
    'delta',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
    'reason',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
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
  static const VerificationMeta _batchNumberMeta = const VerificationMeta(
    'batchNumber',
  );
  @override
  late final GeneratedColumn<String> batchNumber = GeneratedColumn<String>(
    'batch_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _expiryDateMeta = const VerificationMeta(
    'expiryDate',
  );
  @override
  late final GeneratedColumn<DateTime> expiryDate = GeneratedColumn<DateTime>(
    'expiry_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    productId,
    delta,
    reason,
    notes,
    createdAt,
    batchNumber,
    expiryDate,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stock_adjustments';
  @override
  VerificationContext validateIntegrity(
    Insertable<StockAdjustmentRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('delta')) {
      context.handle(
        _deltaMeta,
        delta.isAcceptableOrUnknown(data['delta']!, _deltaMeta),
      );
    } else if (isInserting) {
      context.missing(_deltaMeta);
    }
    if (data.containsKey('reason')) {
      context.handle(
        _reasonMeta,
        reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta),
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
    }
    if (data.containsKey('batch_number')) {
      context.handle(
        _batchNumberMeta,
        batchNumber.isAcceptableOrUnknown(
          data['batch_number']!,
          _batchNumberMeta,
        ),
      );
    }
    if (data.containsKey('expiry_date')) {
      context.handle(
        _expiryDateMeta,
        expiryDate.isAcceptableOrUnknown(data['expiry_date']!, _expiryDateMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StockAdjustmentRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StockAdjustmentRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_id'],
      )!,
      delta: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}delta'],
      )!,
      reason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reason'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      batchNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}batch_number'],
      ),
      expiryDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expiry_date'],
      ),
    );
  }

  @override
  $StockAdjustmentsTable createAlias(String alias) {
    return $StockAdjustmentsTable(attachedDatabase, alias);
  }
}

class StockAdjustmentRow extends DataClass
    implements Insertable<StockAdjustmentRow> {
  final int id;
  final int productId;
  final int delta;
  final String reason;
  final String notes;
  final DateTime createdAt;
  final String? batchNumber;
  final DateTime? expiryDate;
  const StockAdjustmentRow({
    required this.id,
    required this.productId,
    required this.delta,
    required this.reason,
    required this.notes,
    required this.createdAt,
    this.batchNumber,
    this.expiryDate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['product_id'] = Variable<int>(productId);
    map['delta'] = Variable<int>(delta);
    map['reason'] = Variable<String>(reason);
    map['notes'] = Variable<String>(notes);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || batchNumber != null) {
      map['batch_number'] = Variable<String>(batchNumber);
    }
    if (!nullToAbsent || expiryDate != null) {
      map['expiry_date'] = Variable<DateTime>(expiryDate);
    }
    return map;
  }

  StockAdjustmentsCompanion toCompanion(bool nullToAbsent) {
    return StockAdjustmentsCompanion(
      id: Value(id),
      productId: Value(productId),
      delta: Value(delta),
      reason: Value(reason),
      notes: Value(notes),
      createdAt: Value(createdAt),
      batchNumber: batchNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(batchNumber),
      expiryDate: expiryDate == null && nullToAbsent
          ? const Value.absent()
          : Value(expiryDate),
    );
  }

  factory StockAdjustmentRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StockAdjustmentRow(
      id: serializer.fromJson<int>(json['id']),
      productId: serializer.fromJson<int>(json['productId']),
      delta: serializer.fromJson<int>(json['delta']),
      reason: serializer.fromJson<String>(json['reason']),
      notes: serializer.fromJson<String>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      batchNumber: serializer.fromJson<String?>(json['batchNumber']),
      expiryDate: serializer.fromJson<DateTime?>(json['expiryDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productId': serializer.toJson<int>(productId),
      'delta': serializer.toJson<int>(delta),
      'reason': serializer.toJson<String>(reason),
      'notes': serializer.toJson<String>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'batchNumber': serializer.toJson<String?>(batchNumber),
      'expiryDate': serializer.toJson<DateTime?>(expiryDate),
    };
  }

  StockAdjustmentRow copyWith({
    int? id,
    int? productId,
    int? delta,
    String? reason,
    String? notes,
    DateTime? createdAt,
    Value<String?> batchNumber = const Value.absent(),
    Value<DateTime?> expiryDate = const Value.absent(),
  }) => StockAdjustmentRow(
    id: id ?? this.id,
    productId: productId ?? this.productId,
    delta: delta ?? this.delta,
    reason: reason ?? this.reason,
    notes: notes ?? this.notes,
    createdAt: createdAt ?? this.createdAt,
    batchNumber: batchNumber.present ? batchNumber.value : this.batchNumber,
    expiryDate: expiryDate.present ? expiryDate.value : this.expiryDate,
  );
  StockAdjustmentRow copyWithCompanion(StockAdjustmentsCompanion data) {
    return StockAdjustmentRow(
      id: data.id.present ? data.id.value : this.id,
      productId: data.productId.present ? data.productId.value : this.productId,
      delta: data.delta.present ? data.delta.value : this.delta,
      reason: data.reason.present ? data.reason.value : this.reason,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      batchNumber: data.batchNumber.present
          ? data.batchNumber.value
          : this.batchNumber,
      expiryDate: data.expiryDate.present
          ? data.expiryDate.value
          : this.expiryDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StockAdjustmentRow(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('delta: $delta, ')
          ..write('reason: $reason, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('batchNumber: $batchNumber, ')
          ..write('expiryDate: $expiryDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    productId,
    delta,
    reason,
    notes,
    createdAt,
    batchNumber,
    expiryDate,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StockAdjustmentRow &&
          other.id == this.id &&
          other.productId == this.productId &&
          other.delta == this.delta &&
          other.reason == this.reason &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.batchNumber == this.batchNumber &&
          other.expiryDate == this.expiryDate);
}

class StockAdjustmentsCompanion extends UpdateCompanion<StockAdjustmentRow> {
  final Value<int> id;
  final Value<int> productId;
  final Value<int> delta;
  final Value<String> reason;
  final Value<String> notes;
  final Value<DateTime> createdAt;
  final Value<String?> batchNumber;
  final Value<DateTime?> expiryDate;
  const StockAdjustmentsCompanion({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.delta = const Value.absent(),
    this.reason = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.batchNumber = const Value.absent(),
    this.expiryDate = const Value.absent(),
  });
  StockAdjustmentsCompanion.insert({
    this.id = const Value.absent(),
    required int productId,
    required int delta,
    this.reason = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.batchNumber = const Value.absent(),
    this.expiryDate = const Value.absent(),
  }) : productId = Value(productId),
       delta = Value(delta);
  static Insertable<StockAdjustmentRow> custom({
    Expression<int>? id,
    Expression<int>? productId,
    Expression<int>? delta,
    Expression<String>? reason,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<String>? batchNumber,
    Expression<DateTime>? expiryDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productId != null) 'product_id': productId,
      if (delta != null) 'delta': delta,
      if (reason != null) 'reason': reason,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (batchNumber != null) 'batch_number': batchNumber,
      if (expiryDate != null) 'expiry_date': expiryDate,
    });
  }

  StockAdjustmentsCompanion copyWith({
    Value<int>? id,
    Value<int>? productId,
    Value<int>? delta,
    Value<String>? reason,
    Value<String>? notes,
    Value<DateTime>? createdAt,
    Value<String?>? batchNumber,
    Value<DateTime?>? expiryDate,
  }) {
    return StockAdjustmentsCompanion(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      delta: delta ?? this.delta,
      reason: reason ?? this.reason,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      batchNumber: batchNumber ?? this.batchNumber,
      expiryDate: expiryDate ?? this.expiryDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (delta.present) {
      map['delta'] = Variable<int>(delta.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (batchNumber.present) {
      map['batch_number'] = Variable<String>(batchNumber.value);
    }
    if (expiryDate.present) {
      map['expiry_date'] = Variable<DateTime>(expiryDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StockAdjustmentsCompanion(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('delta: $delta, ')
          ..write('reason: $reason, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('batchNumber: $batchNumber, ')
          ..write('expiryDate: $expiryDate')
          ..write(')'))
        .toString();
  }
}

class $StockTransfersTable extends StockTransfers
    with TableInfo<$StockTransfersTable, StockTransferRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StockTransfersTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _fromStoreIdMeta = const VerificationMeta(
    'fromStoreId',
  );
  @override
  late final GeneratedColumn<int> fromStoreId = GeneratedColumn<int>(
    'from_store_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _toStoreIdMeta = const VerificationMeta(
    'toStoreId',
  );
  @override
  late final GeneratedColumn<int> toStoreId = GeneratedColumn<int>(
    'to_store_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
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
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    fromStoreId,
    toStoreId,
    productId,
    quantity,
    status,
    notes,
    createdAt,
    completedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stock_transfers';
  @override
  VerificationContext validateIntegrity(
    Insertable<StockTransferRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('from_store_id')) {
      context.handle(
        _fromStoreIdMeta,
        fromStoreId.isAcceptableOrUnknown(
          data['from_store_id']!,
          _fromStoreIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fromStoreIdMeta);
    }
    if (data.containsKey('to_store_id')) {
      context.handle(
        _toStoreIdMeta,
        toStoreId.isAcceptableOrUnknown(data['to_store_id']!, _toStoreIdMeta),
      );
    } else if (isInserting) {
      context.missing(_toStoreIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
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
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StockTransferRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StockTransferRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      fromStoreId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}from_store_id'],
      )!,
      toStoreId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}to_store_id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_id'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
    );
  }

  @override
  $StockTransfersTable createAlias(String alias) {
    return $StockTransfersTable(attachedDatabase, alias);
  }
}

class StockTransferRow extends DataClass
    implements Insertable<StockTransferRow> {
  final int id;
  final int fromStoreId;
  final int toStoreId;
  final int productId;
  final int quantity;
  final String status;
  final String? notes;
  final DateTime createdAt;
  final DateTime? completedAt;
  const StockTransferRow({
    required this.id,
    required this.fromStoreId,
    required this.toStoreId,
    required this.productId,
    required this.quantity,
    required this.status,
    this.notes,
    required this.createdAt,
    this.completedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['from_store_id'] = Variable<int>(fromStoreId);
    map['to_store_id'] = Variable<int>(toStoreId);
    map['product_id'] = Variable<int>(productId);
    map['quantity'] = Variable<int>(quantity);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    return map;
  }

  StockTransfersCompanion toCompanion(bool nullToAbsent) {
    return StockTransfersCompanion(
      id: Value(id),
      fromStoreId: Value(fromStoreId),
      toStoreId: Value(toStoreId),
      productId: Value(productId),
      quantity: Value(quantity),
      status: Value(status),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
    );
  }

  factory StockTransferRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StockTransferRow(
      id: serializer.fromJson<int>(json['id']),
      fromStoreId: serializer.fromJson<int>(json['fromStoreId']),
      toStoreId: serializer.fromJson<int>(json['toStoreId']),
      productId: serializer.fromJson<int>(json['productId']),
      quantity: serializer.fromJson<int>(json['quantity']),
      status: serializer.fromJson<String>(json['status']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'fromStoreId': serializer.toJson<int>(fromStoreId),
      'toStoreId': serializer.toJson<int>(toStoreId),
      'productId': serializer.toJson<int>(productId),
      'quantity': serializer.toJson<int>(quantity),
      'status': serializer.toJson<String>(status),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
    };
  }

  StockTransferRow copyWith({
    int? id,
    int? fromStoreId,
    int? toStoreId,
    int? productId,
    int? quantity,
    String? status,
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    Value<DateTime?> completedAt = const Value.absent(),
  }) => StockTransferRow(
    id: id ?? this.id,
    fromStoreId: fromStoreId ?? this.fromStoreId,
    toStoreId: toStoreId ?? this.toStoreId,
    productId: productId ?? this.productId,
    quantity: quantity ?? this.quantity,
    status: status ?? this.status,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
  );
  StockTransferRow copyWithCompanion(StockTransfersCompanion data) {
    return StockTransferRow(
      id: data.id.present ? data.id.value : this.id,
      fromStoreId: data.fromStoreId.present
          ? data.fromStoreId.value
          : this.fromStoreId,
      toStoreId: data.toStoreId.present ? data.toStoreId.value : this.toStoreId,
      productId: data.productId.present ? data.productId.value : this.productId,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      status: data.status.present ? data.status.value : this.status,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StockTransferRow(')
          ..write('id: $id, ')
          ..write('fromStoreId: $fromStoreId, ')
          ..write('toStoreId: $toStoreId, ')
          ..write('productId: $productId, ')
          ..write('quantity: $quantity, ')
          ..write('status: $status, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    fromStoreId,
    toStoreId,
    productId,
    quantity,
    status,
    notes,
    createdAt,
    completedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StockTransferRow &&
          other.id == this.id &&
          other.fromStoreId == this.fromStoreId &&
          other.toStoreId == this.toStoreId &&
          other.productId == this.productId &&
          other.quantity == this.quantity &&
          other.status == this.status &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.completedAt == this.completedAt);
}

class StockTransfersCompanion extends UpdateCompanion<StockTransferRow> {
  final Value<int> id;
  final Value<int> fromStoreId;
  final Value<int> toStoreId;
  final Value<int> productId;
  final Value<int> quantity;
  final Value<String> status;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime?> completedAt;
  const StockTransfersCompanion({
    this.id = const Value.absent(),
    this.fromStoreId = const Value.absent(),
    this.toStoreId = const Value.absent(),
    this.productId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.status = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.completedAt = const Value.absent(),
  });
  StockTransfersCompanion.insert({
    this.id = const Value.absent(),
    required int fromStoreId,
    required int toStoreId,
    required int productId,
    required int quantity,
    this.status = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.completedAt = const Value.absent(),
  }) : fromStoreId = Value(fromStoreId),
       toStoreId = Value(toStoreId),
       productId = Value(productId),
       quantity = Value(quantity);
  static Insertable<StockTransferRow> custom({
    Expression<int>? id,
    Expression<int>? fromStoreId,
    Expression<int>? toStoreId,
    Expression<int>? productId,
    Expression<int>? quantity,
    Expression<String>? status,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? completedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fromStoreId != null) 'from_store_id': fromStoreId,
      if (toStoreId != null) 'to_store_id': toStoreId,
      if (productId != null) 'product_id': productId,
      if (quantity != null) 'quantity': quantity,
      if (status != null) 'status': status,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (completedAt != null) 'completed_at': completedAt,
    });
  }

  StockTransfersCompanion copyWith({
    Value<int>? id,
    Value<int>? fromStoreId,
    Value<int>? toStoreId,
    Value<int>? productId,
    Value<int>? quantity,
    Value<String>? status,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime?>? completedAt,
  }) {
    return StockTransfersCompanion(
      id: id ?? this.id,
      fromStoreId: fromStoreId ?? this.fromStoreId,
      toStoreId: toStoreId ?? this.toStoreId,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (fromStoreId.present) {
      map['from_store_id'] = Variable<int>(fromStoreId.value);
    }
    if (toStoreId.present) {
      map['to_store_id'] = Variable<int>(toStoreId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StockTransfersCompanion(')
          ..write('id: $id, ')
          ..write('fromStoreId: $fromStoreId, ')
          ..write('toStoreId: $toStoreId, ')
          ..write('productId: $productId, ')
          ..write('quantity: $quantity, ')
          ..write('status: $status, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }
}

class $StoresTable extends Stores with TableInfo<$StoresTable, StoreRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StoresTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
    defaultValue: const Constant(true),
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
    name,
    address,
    phone,
    email,
    isActive,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stores';
  @override
  VerificationContext validateIntegrity(
    Insertable<StoreRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
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
  StoreRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StoreRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $StoresTable createAlias(String alias) {
    return $StoresTable(attachedDatabase, alias);
  }
}

class StoreRow extends DataClass implements Insertable<StoreRow> {
  final int id;
  final String name;
  final String address;
  final String? phone;
  final String? email;
  final bool isActive;
  final DateTime createdAt;
  const StoreRow({
    required this.id,
    required this.name,
    required this.address,
    this.phone,
    this.email,
    required this.isActive,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['address'] = Variable<String>(address);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  StoresCompanion toCompanion(bool nullToAbsent) {
    return StoresCompanion(
      id: Value(id),
      name: Value(name),
      address: Value(address),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
    );
  }

  factory StoreRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StoreRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      address: serializer.fromJson<String>(json['address']),
      phone: serializer.fromJson<String?>(json['phone']),
      email: serializer.fromJson<String?>(json['email']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'address': serializer.toJson<String>(address),
      'phone': serializer.toJson<String?>(phone),
      'email': serializer.toJson<String?>(email),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  StoreRow copyWith({
    int? id,
    String? name,
    String? address,
    Value<String?> phone = const Value.absent(),
    Value<String?> email = const Value.absent(),
    bool? isActive,
    DateTime? createdAt,
  }) => StoreRow(
    id: id ?? this.id,
    name: name ?? this.name,
    address: address ?? this.address,
    phone: phone.present ? phone.value : this.phone,
    email: email.present ? email.value : this.email,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
  );
  StoreRow copyWithCompanion(StoresCompanion data) {
    return StoreRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      address: data.address.present ? data.address.value : this.address,
      phone: data.phone.present ? data.phone.value : this.phone,
      email: data.email.present ? data.email.value : this.email,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StoreRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, address, phone, email, isActive, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StoreRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.address == this.address &&
          other.phone == this.phone &&
          other.email == this.email &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt);
}

class StoresCompanion extends UpdateCompanion<StoreRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> address;
  final Value<String?> phone;
  final Value<String?> email;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  const StoresCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.address = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  StoresCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.address = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<StoreRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? address,
    Expression<String>? phone,
    Expression<String>? email,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (address != null) 'address': address,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  StoresCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? address,
    Value<String?>? phone,
    Value<String?>? email,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
  }) {
    return StoresCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StoresCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $SuppliersTable extends Suppliers
    with TableInfo<$SuppliersTable, SupplierRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SuppliersTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contactNameMeta = const VerificationMeta(
    'contactName',
  );
  @override
  late final GeneratedColumn<String> contactName = GeneratedColumn<String>(
    'contact_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    contactName,
    phone,
    email,
    address,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'suppliers';
  @override
  VerificationContext validateIntegrity(
    Insertable<SupplierRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('contact_name')) {
      context.handle(
        _contactNameMeta,
        contactName.isAcceptableOrUnknown(
          data['contact_name']!,
          _contactNameMeta,
        ),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
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
  SupplierRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SupplierRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      contactName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contact_name'],
      ),
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SuppliersTable createAlias(String alias) {
    return $SuppliersTable(attachedDatabase, alias);
  }
}

class SupplierRow extends DataClass implements Insertable<SupplierRow> {
  final int id;
  final String name;
  final String? contactName;
  final String? phone;
  final String? email;
  final String? address;
  final DateTime createdAt;
  const SupplierRow({
    required this.id,
    required this.name,
    this.contactName,
    this.phone,
    this.email,
    this.address,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || contactName != null) {
      map['contact_name'] = Variable<String>(contactName);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SuppliersCompanion toCompanion(bool nullToAbsent) {
    return SuppliersCompanion(
      id: Value(id),
      name: Value(name),
      contactName: contactName == null && nullToAbsent
          ? const Value.absent()
          : Value(contactName),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      createdAt: Value(createdAt),
    );
  }

  factory SupplierRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SupplierRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      contactName: serializer.fromJson<String?>(json['contactName']),
      phone: serializer.fromJson<String?>(json['phone']),
      email: serializer.fromJson<String?>(json['email']),
      address: serializer.fromJson<String?>(json['address']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'contactName': serializer.toJson<String?>(contactName),
      'phone': serializer.toJson<String?>(phone),
      'email': serializer.toJson<String?>(email),
      'address': serializer.toJson<String?>(address),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SupplierRow copyWith({
    int? id,
    String? name,
    Value<String?> contactName = const Value.absent(),
    Value<String?> phone = const Value.absent(),
    Value<String?> email = const Value.absent(),
    Value<String?> address = const Value.absent(),
    DateTime? createdAt,
  }) => SupplierRow(
    id: id ?? this.id,
    name: name ?? this.name,
    contactName: contactName.present ? contactName.value : this.contactName,
    phone: phone.present ? phone.value : this.phone,
    email: email.present ? email.value : this.email,
    address: address.present ? address.value : this.address,
    createdAt: createdAt ?? this.createdAt,
  );
  SupplierRow copyWithCompanion(SuppliersCompanion data) {
    return SupplierRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      contactName: data.contactName.present
          ? data.contactName.value
          : this.contactName,
      phone: data.phone.present ? data.phone.value : this.phone,
      email: data.email.present ? data.email.value : this.email,
      address: data.address.present ? data.address.value : this.address,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SupplierRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('contactName: $contactName, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('address: $address, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, contactName, phone, email, address, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SupplierRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.contactName == this.contactName &&
          other.phone == this.phone &&
          other.email == this.email &&
          other.address == this.address &&
          other.createdAt == this.createdAt);
}

class SuppliersCompanion extends UpdateCompanion<SupplierRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> contactName;
  final Value<String?> phone;
  final Value<String?> email;
  final Value<String?> address;
  final Value<DateTime> createdAt;
  const SuppliersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.contactName = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.address = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  SuppliersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.contactName = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.address = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<SupplierRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? contactName,
    Expression<String>? phone,
    Expression<String>? email,
    Expression<String>? address,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (contactName != null) 'contact_name': contactName,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (address != null) 'address': address,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  SuppliersCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? contactName,
    Value<String?>? phone,
    Value<String?>? email,
    Value<String?>? address,
    Value<DateTime>? createdAt,
  }) {
    return SuppliersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      contactName: contactName ?? this.contactName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (contactName.present) {
      map['contact_name'] = Variable<String>(contactName.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SuppliersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('contactName: $contactName, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('address: $address, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, UserRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _usernameMeta = const VerificationMeta(
    'username',
  );
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
    'username',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _passwordMeta = const VerificationMeta(
    'password',
  );
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
    'password',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roleValueMeta = const VerificationMeta(
    'roleValue',
  );
  @override
  late final GeneratedColumn<int> roleValue = GeneratedColumn<int>(
    'role_value',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
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
    username,
    password,
    roleValue,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('username')) {
      context.handle(
        _usernameMeta,
        username.isAcceptableOrUnknown(data['username']!, _usernameMeta),
      );
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('password')) {
      context.handle(
        _passwordMeta,
        password.isAcceptableOrUnknown(data['password']!, _passwordMeta),
      );
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    if (data.containsKey('role_value')) {
      context.handle(
        _roleValueMeta,
        roleValue.isAcceptableOrUnknown(data['role_value']!, _roleValueMeta),
      );
    } else if (isInserting) {
      context.missing(_roleValueMeta);
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
  UserRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      username: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}username'],
      )!,
      password: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}password'],
      )!,
      roleValue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}role_value'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class UserRow extends DataClass implements Insertable<UserRow> {
  final int id;
  final String username;
  final String password;
  final int roleValue;
  final DateTime createdAt;
  const UserRow({
    required this.id,
    required this.username,
    required this.password,
    required this.roleValue,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['username'] = Variable<String>(username);
    map['password'] = Variable<String>(password);
    map['role_value'] = Variable<int>(roleValue);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      username: Value(username),
      password: Value(password),
      roleValue: Value(roleValue),
      createdAt: Value(createdAt),
    );
  }

  factory UserRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserRow(
      id: serializer.fromJson<int>(json['id']),
      username: serializer.fromJson<String>(json['username']),
      password: serializer.fromJson<String>(json['password']),
      roleValue: serializer.fromJson<int>(json['roleValue']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'username': serializer.toJson<String>(username),
      'password': serializer.toJson<String>(password),
      'roleValue': serializer.toJson<int>(roleValue),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  UserRow copyWith({
    int? id,
    String? username,
    String? password,
    int? roleValue,
    DateTime? createdAt,
  }) => UserRow(
    id: id ?? this.id,
    username: username ?? this.username,
    password: password ?? this.password,
    roleValue: roleValue ?? this.roleValue,
    createdAt: createdAt ?? this.createdAt,
  );
  UserRow copyWithCompanion(UsersCompanion data) {
    return UserRow(
      id: data.id.present ? data.id.value : this.id,
      username: data.username.present ? data.username.value : this.username,
      password: data.password.present ? data.password.value : this.password,
      roleValue: data.roleValue.present ? data.roleValue.value : this.roleValue,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserRow(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('roleValue: $roleValue, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, username, password, roleValue, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserRow &&
          other.id == this.id &&
          other.username == this.username &&
          other.password == this.password &&
          other.roleValue == this.roleValue &&
          other.createdAt == this.createdAt);
}

class UsersCompanion extends UpdateCompanion<UserRow> {
  final Value<int> id;
  final Value<String> username;
  final Value<String> password;
  final Value<int> roleValue;
  final Value<DateTime> createdAt;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.password = const Value.absent(),
    this.roleValue = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String username,
    required String password,
    required int roleValue,
    this.createdAt = const Value.absent(),
  }) : username = Value(username),
       password = Value(password),
       roleValue = Value(roleValue);
  static Insertable<UserRow> custom({
    Expression<int>? id,
    Expression<String>? username,
    Expression<String>? password,
    Expression<int>? roleValue,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (username != null) 'username': username,
      if (password != null) 'password': password,
      if (roleValue != null) 'role_value': roleValue,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  UsersCompanion copyWith({
    Value<int>? id,
    Value<String>? username,
    Value<String>? password,
    Value<int>? roleValue,
    Value<DateTime>? createdAt,
  }) {
    return UsersCompanion(
      id: id ?? this.id,
      username: username ?? this.username,
      password: password ?? this.password,
      roleValue: roleValue ?? this.roleValue,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    if (roleValue.present) {
      map['role_value'] = Variable<int>(roleValue.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('roleValue: $roleValue, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $AuditLogsTable auditLogs = $AuditLogsTable(this);
  late final $CustomersTable customers = $CustomersTable(this);
  late final $GoodsReceiptsTable goodsReceipts = $GoodsReceiptsTable(this);
  late final $OrdersTable orders = $OrdersTable(this);
  late final $PaymentsTable payments = $PaymentsTable(this);
  late final $ProductBundlesTable productBundles = $ProductBundlesTable(this);
  late final $ProductPricesTable productPrices = $ProductPricesTable(this);
  late final $ProductsTable products = $ProductsTable(this);
  late final $UnitsTable units = $UnitsTable(this);
  late final $ProductUnitsTable productUnits = $ProductUnitsTable(this);
  late final $ProductVariantsTable productVariants = $ProductVariantsTable(
    this,
  );
  late final $PromotionsTable promotions = $PromotionsTable(this);
  late final $PurchaseOrdersTable purchaseOrders = $PurchaseOrdersTable(this);
  late final $ReturnsTable returns = $ReturnsTable(this);
  late final $StockAdjustmentsTable stockAdjustments = $StockAdjustmentsTable(
    this,
  );
  late final $StockTransfersTable stockTransfers = $StockTransfersTable(this);
  late final $StoresTable stores = $StoresTable(this);
  late final $SuppliersTable suppliers = $SuppliersTable(this);
  late final $UsersTable users = $UsersTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    auditLogs,
    customers,
    goodsReceipts,
    orders,
    payments,
    productBundles,
    productPrices,
    products,
    units,
    productUnits,
    productVariants,
    promotions,
    purchaseOrders,
    returns,
    stockAdjustments,
    stockTransfers,
    stores,
    suppliers,
    users,
  ];
}

typedef $$AuditLogsTableCreateCompanionBuilder =
    AuditLogsCompanion Function({
      Value<int> id,
      Value<int?> userId,
      required String action,
      Value<String?> details,
      Value<DateTime> createdAt,
    });
typedef $$AuditLogsTableUpdateCompanionBuilder =
    AuditLogsCompanion Function({
      Value<int> id,
      Value<int?> userId,
      Value<String> action,
      Value<String?> details,
      Value<DateTime> createdAt,
    });

class $$AuditLogsTableFilterComposer
    extends Composer<_$AppDatabase, $AuditLogsTable> {
  $$AuditLogsTableFilterComposer({
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

  ColumnFilters<int> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get details => $composableBuilder(
    column: $table.details,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AuditLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $AuditLogsTable> {
  $$AuditLogsTableOrderingComposer({
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

  ColumnOrderings<int> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get details => $composableBuilder(
    column: $table.details,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AuditLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AuditLogsTable> {
  $$AuditLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get action =>
      $composableBuilder(column: $table.action, builder: (column) => column);

  GeneratedColumn<String> get details =>
      $composableBuilder(column: $table.details, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$AuditLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AuditLogsTable,
          AuditLogRow,
          $$AuditLogsTableFilterComposer,
          $$AuditLogsTableOrderingComposer,
          $$AuditLogsTableAnnotationComposer,
          $$AuditLogsTableCreateCompanionBuilder,
          $$AuditLogsTableUpdateCompanionBuilder,
          (
            AuditLogRow,
            BaseReferences<_$AppDatabase, $AuditLogsTable, AuditLogRow>,
          ),
          AuditLogRow,
          PrefetchHooks Function()
        > {
  $$AuditLogsTableTableManager(_$AppDatabase db, $AuditLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AuditLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AuditLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AuditLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> userId = const Value.absent(),
                Value<String> action = const Value.absent(),
                Value<String?> details = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => AuditLogsCompanion(
                id: id,
                userId: userId,
                action: action,
                details: details,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> userId = const Value.absent(),
                required String action,
                Value<String?> details = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => AuditLogsCompanion.insert(
                id: id,
                userId: userId,
                action: action,
                details: details,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AuditLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AuditLogsTable,
      AuditLogRow,
      $$AuditLogsTableFilterComposer,
      $$AuditLogsTableOrderingComposer,
      $$AuditLogsTableAnnotationComposer,
      $$AuditLogsTableCreateCompanionBuilder,
      $$AuditLogsTableUpdateCompanionBuilder,
      (
        AuditLogRow,
        BaseReferences<_$AppDatabase, $AuditLogsTable, AuditLogRow>,
      ),
      AuditLogRow,
      PrefetchHooks Function()
    >;
typedef $$CustomersTableCreateCompanionBuilder =
    CustomersCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> phone,
      Value<String?> email,
      Value<String?> tier,
      Value<int> points,
    });
typedef $$CustomersTableUpdateCompanionBuilder =
    CustomersCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> phone,
      Value<String?> email,
      Value<String?> tier,
      Value<int> points,
    });

class $$CustomersTableFilterComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tier => $composableBuilder(
    column: $table.tier,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get points => $composableBuilder(
    column: $table.points,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CustomersTableOrderingComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tier => $composableBuilder(
    column: $table.tier,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get points => $composableBuilder(
    column: $table.points,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CustomersTableAnnotationComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get tier =>
      $composableBuilder(column: $table.tier, builder: (column) => column);

  GeneratedColumn<int> get points =>
      $composableBuilder(column: $table.points, builder: (column) => column);
}

class $$CustomersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CustomersTable,
          CustomerRow,
          $$CustomersTableFilterComposer,
          $$CustomersTableOrderingComposer,
          $$CustomersTableAnnotationComposer,
          $$CustomersTableCreateCompanionBuilder,
          $$CustomersTableUpdateCompanionBuilder,
          (
            CustomerRow,
            BaseReferences<_$AppDatabase, $CustomersTable, CustomerRow>,
          ),
          CustomerRow,
          PrefetchHooks Function()
        > {
  $$CustomersTableTableManager(_$AppDatabase db, $CustomersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CustomersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CustomersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CustomersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> tier = const Value.absent(),
                Value<int> points = const Value.absent(),
              }) => CustomersCompanion(
                id: id,
                name: name,
                phone: phone,
                email: email,
                tier: tier,
                points: points,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> phone = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> tier = const Value.absent(),
                Value<int> points = const Value.absent(),
              }) => CustomersCompanion.insert(
                id: id,
                name: name,
                phone: phone,
                email: email,
                tier: tier,
                points: points,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CustomersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CustomersTable,
      CustomerRow,
      $$CustomersTableFilterComposer,
      $$CustomersTableOrderingComposer,
      $$CustomersTableAnnotationComposer,
      $$CustomersTableCreateCompanionBuilder,
      $$CustomersTableUpdateCompanionBuilder,
      (
        CustomerRow,
        BaseReferences<_$AppDatabase, $CustomersTable, CustomerRow>,
      ),
      CustomerRow,
      PrefetchHooks Function()
    >;
typedef $$GoodsReceiptsTableCreateCompanionBuilder =
    GoodsReceiptsCompanion Function({
      Value<int> id,
      required int supplierId,
      Value<int?> purchaseOrderId,
      Value<DateTime> receivedAt,
      Value<String> itemsJson,
      Value<String?> notes,
    });
typedef $$GoodsReceiptsTableUpdateCompanionBuilder =
    GoodsReceiptsCompanion Function({
      Value<int> id,
      Value<int> supplierId,
      Value<int?> purchaseOrderId,
      Value<DateTime> receivedAt,
      Value<String> itemsJson,
      Value<String?> notes,
    });

class $$GoodsReceiptsTableFilterComposer
    extends Composer<_$AppDatabase, $GoodsReceiptsTable> {
  $$GoodsReceiptsTableFilterComposer({
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

  ColumnFilters<int> get supplierId => $composableBuilder(
    column: $table.supplierId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get purchaseOrderId => $composableBuilder(
    column: $table.purchaseOrderId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get receivedAt => $composableBuilder(
    column: $table.receivedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get itemsJson => $composableBuilder(
    column: $table.itemsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );
}

class $$GoodsReceiptsTableOrderingComposer
    extends Composer<_$AppDatabase, $GoodsReceiptsTable> {
  $$GoodsReceiptsTableOrderingComposer({
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

  ColumnOrderings<int> get supplierId => $composableBuilder(
    column: $table.supplierId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get purchaseOrderId => $composableBuilder(
    column: $table.purchaseOrderId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get receivedAt => $composableBuilder(
    column: $table.receivedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get itemsJson => $composableBuilder(
    column: $table.itemsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GoodsReceiptsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GoodsReceiptsTable> {
  $$GoodsReceiptsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get supplierId => $composableBuilder(
    column: $table.supplierId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get purchaseOrderId => $composableBuilder(
    column: $table.purchaseOrderId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get receivedAt => $composableBuilder(
    column: $table.receivedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get itemsJson =>
      $composableBuilder(column: $table.itemsJson, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $$GoodsReceiptsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GoodsReceiptsTable,
          GoodsReceiptRow,
          $$GoodsReceiptsTableFilterComposer,
          $$GoodsReceiptsTableOrderingComposer,
          $$GoodsReceiptsTableAnnotationComposer,
          $$GoodsReceiptsTableCreateCompanionBuilder,
          $$GoodsReceiptsTableUpdateCompanionBuilder,
          (
            GoodsReceiptRow,
            BaseReferences<_$AppDatabase, $GoodsReceiptsTable, GoodsReceiptRow>,
          ),
          GoodsReceiptRow,
          PrefetchHooks Function()
        > {
  $$GoodsReceiptsTableTableManager(_$AppDatabase db, $GoodsReceiptsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GoodsReceiptsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GoodsReceiptsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GoodsReceiptsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> supplierId = const Value.absent(),
                Value<int?> purchaseOrderId = const Value.absent(),
                Value<DateTime> receivedAt = const Value.absent(),
                Value<String> itemsJson = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => GoodsReceiptsCompanion(
                id: id,
                supplierId: supplierId,
                purchaseOrderId: purchaseOrderId,
                receivedAt: receivedAt,
                itemsJson: itemsJson,
                notes: notes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int supplierId,
                Value<int?> purchaseOrderId = const Value.absent(),
                Value<DateTime> receivedAt = const Value.absent(),
                Value<String> itemsJson = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => GoodsReceiptsCompanion.insert(
                id: id,
                supplierId: supplierId,
                purchaseOrderId: purchaseOrderId,
                receivedAt: receivedAt,
                itemsJson: itemsJson,
                notes: notes,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$GoodsReceiptsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GoodsReceiptsTable,
      GoodsReceiptRow,
      $$GoodsReceiptsTableFilterComposer,
      $$GoodsReceiptsTableOrderingComposer,
      $$GoodsReceiptsTableAnnotationComposer,
      $$GoodsReceiptsTableCreateCompanionBuilder,
      $$GoodsReceiptsTableUpdateCompanionBuilder,
      (
        GoodsReceiptRow,
        BaseReferences<_$AppDatabase, $GoodsReceiptsTable, GoodsReceiptRow>,
      ),
      GoodsReceiptRow,
      PrefetchHooks Function()
    >;
typedef $$OrdersTableCreateCompanionBuilder =
    OrdersCompanion Function({
      Value<int> id,
      Value<DateTime> createdAt,
      Value<double> totalAmount,
      Value<int?> customerId,
      Value<int> pointsDelta,
      Value<String> itemsJson,
      Value<double> changeAmount,
    });
typedef $$OrdersTableUpdateCompanionBuilder =
    OrdersCompanion Function({
      Value<int> id,
      Value<DateTime> createdAt,
      Value<double> totalAmount,
      Value<int?> customerId,
      Value<int> pointsDelta,
      Value<String> itemsJson,
      Value<double> changeAmount,
    });

class $$OrdersTableFilterComposer
    extends Composer<_$AppDatabase, $OrdersTable> {
  $$OrdersTableFilterComposer({
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

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pointsDelta => $composableBuilder(
    column: $table.pointsDelta,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get itemsJson => $composableBuilder(
    column: $table.itemsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get changeAmount => $composableBuilder(
    column: $table.changeAmount,
    builder: (column) => ColumnFilters(column),
  );
}

class $$OrdersTableOrderingComposer
    extends Composer<_$AppDatabase, $OrdersTable> {
  $$OrdersTableOrderingComposer({
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

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pointsDelta => $composableBuilder(
    column: $table.pointsDelta,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get itemsJson => $composableBuilder(
    column: $table.itemsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get changeAmount => $composableBuilder(
    column: $table.changeAmount,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$OrdersTableAnnotationComposer
    extends Composer<_$AppDatabase, $OrdersTable> {
  $$OrdersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get pointsDelta => $composableBuilder(
    column: $table.pointsDelta,
    builder: (column) => column,
  );

  GeneratedColumn<String> get itemsJson =>
      $composableBuilder(column: $table.itemsJson, builder: (column) => column);

  GeneratedColumn<double> get changeAmount => $composableBuilder(
    column: $table.changeAmount,
    builder: (column) => column,
  );
}

class $$OrdersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OrdersTable,
          OrderRow,
          $$OrdersTableFilterComposer,
          $$OrdersTableOrderingComposer,
          $$OrdersTableAnnotationComposer,
          $$OrdersTableCreateCompanionBuilder,
          $$OrdersTableUpdateCompanionBuilder,
          (OrderRow, BaseReferences<_$AppDatabase, $OrdersTable, OrderRow>),
          OrderRow,
          PrefetchHooks Function()
        > {
  $$OrdersTableTableManager(_$AppDatabase db, $OrdersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OrdersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OrdersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OrdersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<double> totalAmount = const Value.absent(),
                Value<int?> customerId = const Value.absent(),
                Value<int> pointsDelta = const Value.absent(),
                Value<String> itemsJson = const Value.absent(),
                Value<double> changeAmount = const Value.absent(),
              }) => OrdersCompanion(
                id: id,
                createdAt: createdAt,
                totalAmount: totalAmount,
                customerId: customerId,
                pointsDelta: pointsDelta,
                itemsJson: itemsJson,
                changeAmount: changeAmount,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<double> totalAmount = const Value.absent(),
                Value<int?> customerId = const Value.absent(),
                Value<int> pointsDelta = const Value.absent(),
                Value<String> itemsJson = const Value.absent(),
                Value<double> changeAmount = const Value.absent(),
              }) => OrdersCompanion.insert(
                id: id,
                createdAt: createdAt,
                totalAmount: totalAmount,
                customerId: customerId,
                pointsDelta: pointsDelta,
                itemsJson: itemsJson,
                changeAmount: changeAmount,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$OrdersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OrdersTable,
      OrderRow,
      $$OrdersTableFilterComposer,
      $$OrdersTableOrderingComposer,
      $$OrdersTableAnnotationComposer,
      $$OrdersTableCreateCompanionBuilder,
      $$OrdersTableUpdateCompanionBuilder,
      (OrderRow, BaseReferences<_$AppDatabase, $OrdersTable, OrderRow>),
      OrderRow,
      PrefetchHooks Function()
    >;
typedef $$PaymentsTableCreateCompanionBuilder =
    PaymentsCompanion Function({
      Value<int> id,
      required int orderId,
      required int methodValue,
      Value<double> value,
      Value<double> amount,
      Value<DateTime> createdAt,
    });
typedef $$PaymentsTableUpdateCompanionBuilder =
    PaymentsCompanion Function({
      Value<int> id,
      Value<int> orderId,
      Value<int> methodValue,
      Value<double> value,
      Value<double> amount,
      Value<DateTime> createdAt,
    });

class $$PaymentsTableFilterComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableFilterComposer({
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

  ColumnFilters<int> get orderId => $composableBuilder(
    column: $table.orderId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get methodValue => $composableBuilder(
    column: $table.methodValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PaymentsTableOrderingComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableOrderingComposer({
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

  ColumnOrderings<int> get orderId => $composableBuilder(
    column: $table.orderId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get methodValue => $composableBuilder(
    column: $table.methodValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PaymentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get orderId =>
      $composableBuilder(column: $table.orderId, builder: (column) => column);

  GeneratedColumn<int> get methodValue => $composableBuilder(
    column: $table.methodValue,
    builder: (column) => column,
  );

  GeneratedColumn<double> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$PaymentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PaymentsTable,
          PaymentRow,
          $$PaymentsTableFilterComposer,
          $$PaymentsTableOrderingComposer,
          $$PaymentsTableAnnotationComposer,
          $$PaymentsTableCreateCompanionBuilder,
          $$PaymentsTableUpdateCompanionBuilder,
          (
            PaymentRow,
            BaseReferences<_$AppDatabase, $PaymentsTable, PaymentRow>,
          ),
          PaymentRow,
          PrefetchHooks Function()
        > {
  $$PaymentsTableTableManager(_$AppDatabase db, $PaymentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PaymentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PaymentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PaymentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> orderId = const Value.absent(),
                Value<int> methodValue = const Value.absent(),
                Value<double> value = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => PaymentsCompanion(
                id: id,
                orderId: orderId,
                methodValue: methodValue,
                value: value,
                amount: amount,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int orderId,
                required int methodValue,
                Value<double> value = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => PaymentsCompanion.insert(
                id: id,
                orderId: orderId,
                methodValue: methodValue,
                value: value,
                amount: amount,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PaymentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PaymentsTable,
      PaymentRow,
      $$PaymentsTableFilterComposer,
      $$PaymentsTableOrderingComposer,
      $$PaymentsTableAnnotationComposer,
      $$PaymentsTableCreateCompanionBuilder,
      $$PaymentsTableUpdateCompanionBuilder,
      (PaymentRow, BaseReferences<_$AppDatabase, $PaymentsTable, PaymentRow>),
      PaymentRow,
      PrefetchHooks Function()
    >;
typedef $$ProductBundlesTableCreateCompanionBuilder =
    ProductBundlesCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> sku,
      Value<double> price,
      Value<String> itemsJson,
      Value<bool> isActive,
      Value<DateTime> createdAt,
    });
typedef $$ProductBundlesTableUpdateCompanionBuilder =
    ProductBundlesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> sku,
      Value<double> price,
      Value<String> itemsJson,
      Value<bool> isActive,
      Value<DateTime> createdAt,
    });

class $$ProductBundlesTableFilterComposer
    extends Composer<_$AppDatabase, $ProductBundlesTable> {
  $$ProductBundlesTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sku => $composableBuilder(
    column: $table.sku,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get itemsJson => $composableBuilder(
    column: $table.itemsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProductBundlesTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductBundlesTable> {
  $$ProductBundlesTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sku => $composableBuilder(
    column: $table.sku,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get itemsJson => $composableBuilder(
    column: $table.itemsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProductBundlesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductBundlesTable> {
  $$ProductBundlesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get sku =>
      $composableBuilder(column: $table.sku, builder: (column) => column);

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<String> get itemsJson =>
      $composableBuilder(column: $table.itemsJson, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$ProductBundlesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductBundlesTable,
          ProductBundleRow,
          $$ProductBundlesTableFilterComposer,
          $$ProductBundlesTableOrderingComposer,
          $$ProductBundlesTableAnnotationComposer,
          $$ProductBundlesTableCreateCompanionBuilder,
          $$ProductBundlesTableUpdateCompanionBuilder,
          (
            ProductBundleRow,
            BaseReferences<
              _$AppDatabase,
              $ProductBundlesTable,
              ProductBundleRow
            >,
          ),
          ProductBundleRow,
          PrefetchHooks Function()
        > {
  $$ProductBundlesTableTableManager(
    _$AppDatabase db,
    $ProductBundlesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductBundlesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductBundlesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductBundlesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> sku = const Value.absent(),
                Value<double> price = const Value.absent(),
                Value<String> itemsJson = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ProductBundlesCompanion(
                id: id,
                name: name,
                sku: sku,
                price: price,
                itemsJson: itemsJson,
                isActive: isActive,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> sku = const Value.absent(),
                Value<double> price = const Value.absent(),
                Value<String> itemsJson = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ProductBundlesCompanion.insert(
                id: id,
                name: name,
                sku: sku,
                price: price,
                itemsJson: itemsJson,
                isActive: isActive,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProductBundlesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductBundlesTable,
      ProductBundleRow,
      $$ProductBundlesTableFilterComposer,
      $$ProductBundlesTableOrderingComposer,
      $$ProductBundlesTableAnnotationComposer,
      $$ProductBundlesTableCreateCompanionBuilder,
      $$ProductBundlesTableUpdateCompanionBuilder,
      (
        ProductBundleRow,
        BaseReferences<_$AppDatabase, $ProductBundlesTable, ProductBundleRow>,
      ),
      ProductBundleRow,
      PrefetchHooks Function()
    >;
typedef $$ProductPricesTableCreateCompanionBuilder =
    ProductPricesCompanion Function({
      Value<int> id,
      required int productId,
      required int storeId,
      Value<double> price,
      Value<DateTime> createdAt,
      Value<DateTime?> validFrom,
      Value<DateTime?> validTo,
    });
typedef $$ProductPricesTableUpdateCompanionBuilder =
    ProductPricesCompanion Function({
      Value<int> id,
      Value<int> productId,
      Value<int> storeId,
      Value<double> price,
      Value<DateTime> createdAt,
      Value<DateTime?> validFrom,
      Value<DateTime?> validTo,
    });

class $$ProductPricesTableFilterComposer
    extends Composer<_$AppDatabase, $ProductPricesTable> {
  $$ProductPricesTableFilterComposer({
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

  ColumnFilters<int> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get storeId => $composableBuilder(
    column: $table.storeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get validFrom => $composableBuilder(
    column: $table.validFrom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get validTo => $composableBuilder(
    column: $table.validTo,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProductPricesTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductPricesTable> {
  $$ProductPricesTableOrderingComposer({
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

  ColumnOrderings<int> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get storeId => $composableBuilder(
    column: $table.storeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get validFrom => $composableBuilder(
    column: $table.validFrom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get validTo => $composableBuilder(
    column: $table.validTo,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProductPricesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductPricesTable> {
  $$ProductPricesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<int> get storeId =>
      $composableBuilder(column: $table.storeId, builder: (column) => column);

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get validFrom =>
      $composableBuilder(column: $table.validFrom, builder: (column) => column);

  GeneratedColumn<DateTime> get validTo =>
      $composableBuilder(column: $table.validTo, builder: (column) => column);
}

class $$ProductPricesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductPricesTable,
          ProductPriceRow,
          $$ProductPricesTableFilterComposer,
          $$ProductPricesTableOrderingComposer,
          $$ProductPricesTableAnnotationComposer,
          $$ProductPricesTableCreateCompanionBuilder,
          $$ProductPricesTableUpdateCompanionBuilder,
          (
            ProductPriceRow,
            BaseReferences<_$AppDatabase, $ProductPricesTable, ProductPriceRow>,
          ),
          ProductPriceRow,
          PrefetchHooks Function()
        > {
  $$ProductPricesTableTableManager(_$AppDatabase db, $ProductPricesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductPricesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductPricesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductPricesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> productId = const Value.absent(),
                Value<int> storeId = const Value.absent(),
                Value<double> price = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> validFrom = const Value.absent(),
                Value<DateTime?> validTo = const Value.absent(),
              }) => ProductPricesCompanion(
                id: id,
                productId: productId,
                storeId: storeId,
                price: price,
                createdAt: createdAt,
                validFrom: validFrom,
                validTo: validTo,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int productId,
                required int storeId,
                Value<double> price = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> validFrom = const Value.absent(),
                Value<DateTime?> validTo = const Value.absent(),
              }) => ProductPricesCompanion.insert(
                id: id,
                productId: productId,
                storeId: storeId,
                price: price,
                createdAt: createdAt,
                validFrom: validFrom,
                validTo: validTo,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProductPricesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductPricesTable,
      ProductPriceRow,
      $$ProductPricesTableFilterComposer,
      $$ProductPricesTableOrderingComposer,
      $$ProductPricesTableAnnotationComposer,
      $$ProductPricesTableCreateCompanionBuilder,
      $$ProductPricesTableUpdateCompanionBuilder,
      (
        ProductPriceRow,
        BaseReferences<_$AppDatabase, $ProductPricesTable, ProductPriceRow>,
      ),
      ProductPriceRow,
      PrefetchHooks Function()
    >;
typedef $$ProductsTableCreateCompanionBuilder =
    ProductsCompanion Function({
      Value<int> id,
      required String name,
      required String sku,
      Value<double> costPrice,
      Value<double> salePrice,
      Value<int> stock,
      Value<int> lowStockThreshold,
      Value<String?> category,
      Value<String?> description,
      Value<String?> barcode,
    });
typedef $$ProductsTableUpdateCompanionBuilder =
    ProductsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> sku,
      Value<double> costPrice,
      Value<double> salePrice,
      Value<int> stock,
      Value<int> lowStockThreshold,
      Value<String?> category,
      Value<String?> description,
      Value<String?> barcode,
    });

final class $$ProductsTableReferences
    extends BaseReferences<_$AppDatabase, $ProductsTable, ProductRow> {
  $$ProductsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ProductUnitsTable, List<ProductUnitRow>>
  _productUnitsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.productUnits,
    aliasName: $_aliasNameGenerator(db.products.id, db.productUnits.productId),
  );

  $$ProductUnitsTableProcessedTableManager get productUnitsRefs {
    final manager = $$ProductUnitsTableTableManager(
      $_db,
      $_db.productUnits,
    ).filter((f) => f.productId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_productUnitsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProductsTableFilterComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sku => $composableBuilder(
    column: $table.sku,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get costPrice => $composableBuilder(
    column: $table.costPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get salePrice => $composableBuilder(
    column: $table.salePrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get stock => $composableBuilder(
    column: $table.stock,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lowStockThreshold => $composableBuilder(
    column: $table.lowStockThreshold,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> productUnitsRefs(
    Expression<bool> Function($$ProductUnitsTableFilterComposer f) f,
  ) {
    final $$ProductUnitsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.productUnits,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductUnitsTableFilterComposer(
            $db: $db,
            $table: $db.productUnits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProductsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sku => $composableBuilder(
    column: $table.sku,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get costPrice => $composableBuilder(
    column: $table.costPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get salePrice => $composableBuilder(
    column: $table.salePrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stock => $composableBuilder(
    column: $table.stock,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lowStockThreshold => $composableBuilder(
    column: $table.lowStockThreshold,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProductsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get sku =>
      $composableBuilder(column: $table.sku, builder: (column) => column);

  GeneratedColumn<double> get costPrice =>
      $composableBuilder(column: $table.costPrice, builder: (column) => column);

  GeneratedColumn<double> get salePrice =>
      $composableBuilder(column: $table.salePrice, builder: (column) => column);

  GeneratedColumn<int> get stock =>
      $composableBuilder(column: $table.stock, builder: (column) => column);

  GeneratedColumn<int> get lowStockThreshold => $composableBuilder(
    column: $table.lowStockThreshold,
    builder: (column) => column,
  );

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get barcode =>
      $composableBuilder(column: $table.barcode, builder: (column) => column);

  Expression<T> productUnitsRefs<T extends Object>(
    Expression<T> Function($$ProductUnitsTableAnnotationComposer a) f,
  ) {
    final $$ProductUnitsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.productUnits,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductUnitsTableAnnotationComposer(
            $db: $db,
            $table: $db.productUnits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProductsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductsTable,
          ProductRow,
          $$ProductsTableFilterComposer,
          $$ProductsTableOrderingComposer,
          $$ProductsTableAnnotationComposer,
          $$ProductsTableCreateCompanionBuilder,
          $$ProductsTableUpdateCompanionBuilder,
          (ProductRow, $$ProductsTableReferences),
          ProductRow,
          PrefetchHooks Function({bool productUnitsRefs})
        > {
  $$ProductsTableTableManager(_$AppDatabase db, $ProductsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> sku = const Value.absent(),
                Value<double> costPrice = const Value.absent(),
                Value<double> salePrice = const Value.absent(),
                Value<int> stock = const Value.absent(),
                Value<int> lowStockThreshold = const Value.absent(),
                Value<String?> category = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> barcode = const Value.absent(),
              }) => ProductsCompanion(
                id: id,
                name: name,
                sku: sku,
                costPrice: costPrice,
                salePrice: salePrice,
                stock: stock,
                lowStockThreshold: lowStockThreshold,
                category: category,
                description: description,
                barcode: barcode,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String sku,
                Value<double> costPrice = const Value.absent(),
                Value<double> salePrice = const Value.absent(),
                Value<int> stock = const Value.absent(),
                Value<int> lowStockThreshold = const Value.absent(),
                Value<String?> category = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> barcode = const Value.absent(),
              }) => ProductsCompanion.insert(
                id: id,
                name: name,
                sku: sku,
                costPrice: costPrice,
                salePrice: salePrice,
                stock: stock,
                lowStockThreshold: lowStockThreshold,
                category: category,
                description: description,
                barcode: barcode,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProductsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({productUnitsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (productUnitsRefs) db.productUnits],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (productUnitsRefs)
                    await $_getPrefetchedData<
                      ProductRow,
                      $ProductsTable,
                      ProductUnitRow
                    >(
                      currentTable: table,
                      referencedTable: $$ProductsTableReferences
                          ._productUnitsRefsTable(db),
                      managerFromTypedResult: (p0) => $$ProductsTableReferences(
                        db,
                        table,
                        p0,
                      ).productUnitsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.productId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ProductsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductsTable,
      ProductRow,
      $$ProductsTableFilterComposer,
      $$ProductsTableOrderingComposer,
      $$ProductsTableAnnotationComposer,
      $$ProductsTableCreateCompanionBuilder,
      $$ProductsTableUpdateCompanionBuilder,
      (ProductRow, $$ProductsTableReferences),
      ProductRow,
      PrefetchHooks Function({bool productUnitsRefs})
    >;
typedef $$UnitsTableCreateCompanionBuilder =
    UnitsCompanion Function({
      Value<int> id,
      required String name,
      required String key,
      Value<bool> isActive,
      Value<DateTime> createdAt,
    });
typedef $$UnitsTableUpdateCompanionBuilder =
    UnitsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> key,
      Value<bool> isActive,
      Value<DateTime> createdAt,
    });

final class $$UnitsTableReferences
    extends BaseReferences<_$AppDatabase, $UnitsTable, UnitRow> {
  $$UnitsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ProductUnitsTable, List<ProductUnitRow>>
  _productUnitsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.productUnits,
    aliasName: $_aliasNameGenerator(db.units.id, db.productUnits.unitId),
  );

  $$ProductUnitsTableProcessedTableManager get productUnitsRefs {
    final manager = $$ProductUnitsTableTableManager(
      $_db,
      $_db.productUnits,
    ).filter((f) => f.unitId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_productUnitsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$UnitsTableFilterComposer extends Composer<_$AppDatabase, $UnitsTable> {
  $$UnitsTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> productUnitsRefs(
    Expression<bool> Function($$ProductUnitsTableFilterComposer f) f,
  ) {
    final $$ProductUnitsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.productUnits,
      getReferencedColumn: (t) => t.unitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductUnitsTableFilterComposer(
            $db: $db,
            $table: $db.productUnits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UnitsTableOrderingComposer
    extends Composer<_$AppDatabase, $UnitsTable> {
  $$UnitsTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UnitsTableAnnotationComposer
    extends Composer<_$AppDatabase, $UnitsTable> {
  $$UnitsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> productUnitsRefs<T extends Object>(
    Expression<T> Function($$ProductUnitsTableAnnotationComposer a) f,
  ) {
    final $$ProductUnitsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.productUnits,
      getReferencedColumn: (t) => t.unitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductUnitsTableAnnotationComposer(
            $db: $db,
            $table: $db.productUnits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UnitsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UnitsTable,
          UnitRow,
          $$UnitsTableFilterComposer,
          $$UnitsTableOrderingComposer,
          $$UnitsTableAnnotationComposer,
          $$UnitsTableCreateCompanionBuilder,
          $$UnitsTableUpdateCompanionBuilder,
          (UnitRow, $$UnitsTableReferences),
          UnitRow,
          PrefetchHooks Function({bool productUnitsRefs})
        > {
  $$UnitsTableTableManager(_$AppDatabase db, $UnitsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UnitsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UnitsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UnitsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> key = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => UnitsCompanion(
                id: id,
                name: name,
                key: key,
                isActive: isActive,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String key,
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => UnitsCompanion.insert(
                id: id,
                name: name,
                key: key,
                isActive: isActive,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$UnitsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({productUnitsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (productUnitsRefs) db.productUnits],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (productUnitsRefs)
                    await $_getPrefetchedData<
                      UnitRow,
                      $UnitsTable,
                      ProductUnitRow
                    >(
                      currentTable: table,
                      referencedTable: $$UnitsTableReferences
                          ._productUnitsRefsTable(db),
                      managerFromTypedResult: (p0) => $$UnitsTableReferences(
                        db,
                        table,
                        p0,
                      ).productUnitsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.unitId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$UnitsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UnitsTable,
      UnitRow,
      $$UnitsTableFilterComposer,
      $$UnitsTableOrderingComposer,
      $$UnitsTableAnnotationComposer,
      $$UnitsTableCreateCompanionBuilder,
      $$UnitsTableUpdateCompanionBuilder,
      (UnitRow, $$UnitsTableReferences),
      UnitRow,
      PrefetchHooks Function({bool productUnitsRefs})
    >;
typedef $$ProductUnitsTableCreateCompanionBuilder =
    ProductUnitsCompanion Function({
      required int productId,
      required int unitId,
      Value<double> factor,
      Value<bool> isBase,
      Value<bool> isDefault,
      Value<double?> priceOverride,
      Value<String?> sku,
      Value<String?> barcode,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$ProductUnitsTableUpdateCompanionBuilder =
    ProductUnitsCompanion Function({
      Value<int> productId,
      Value<int> unitId,
      Value<double> factor,
      Value<bool> isBase,
      Value<bool> isDefault,
      Value<double?> priceOverride,
      Value<String?> sku,
      Value<String?> barcode,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$ProductUnitsTableReferences
    extends BaseReferences<_$AppDatabase, $ProductUnitsTable, ProductUnitRow> {
  $$ProductUnitsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProductsTable _productIdTable(_$AppDatabase db) =>
      db.products.createAlias(
        $_aliasNameGenerator(db.productUnits.productId, db.products.id),
      );

  $$ProductsTableProcessedTableManager get productId {
    final $_column = $_itemColumn<int>('product_id')!;

    final manager = $$ProductsTableTableManager(
      $_db,
      $_db.products,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $UnitsTable _unitIdTable(_$AppDatabase db) => db.units.createAlias(
    $_aliasNameGenerator(db.productUnits.unitId, db.units.id),
  );

  $$UnitsTableProcessedTableManager get unitId {
    final $_column = $_itemColumn<int>('unit_id')!;

    final manager = $$UnitsTableTableManager(
      $_db,
      $_db.units,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_unitIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ProductUnitsTableFilterComposer
    extends Composer<_$AppDatabase, $ProductUnitsTable> {
  $$ProductUnitsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<double> get factor => $composableBuilder(
    column: $table.factor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isBase => $composableBuilder(
    column: $table.isBase,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get priceOverride => $composableBuilder(
    column: $table.priceOverride,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sku => $composableBuilder(
    column: $table.sku,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ProductsTableFilterComposer get productId {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableFilterComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UnitsTableFilterComposer get unitId {
    final $$UnitsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.unitId,
      referencedTable: $db.units,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UnitsTableFilterComposer(
            $db: $db,
            $table: $db.units,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProductUnitsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductUnitsTable> {
  $$ProductUnitsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<double> get factor => $composableBuilder(
    column: $table.factor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isBase => $composableBuilder(
    column: $table.isBase,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get priceOverride => $composableBuilder(
    column: $table.priceOverride,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sku => $composableBuilder(
    column: $table.sku,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProductsTableOrderingComposer get productId {
    final $$ProductsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableOrderingComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UnitsTableOrderingComposer get unitId {
    final $$UnitsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.unitId,
      referencedTable: $db.units,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UnitsTableOrderingComposer(
            $db: $db,
            $table: $db.units,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProductUnitsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductUnitsTable> {
  $$ProductUnitsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<double> get factor =>
      $composableBuilder(column: $table.factor, builder: (column) => column);

  GeneratedColumn<bool> get isBase =>
      $composableBuilder(column: $table.isBase, builder: (column) => column);

  GeneratedColumn<bool> get isDefault =>
      $composableBuilder(column: $table.isDefault, builder: (column) => column);

  GeneratedColumn<double> get priceOverride => $composableBuilder(
    column: $table.priceOverride,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sku =>
      $composableBuilder(column: $table.sku, builder: (column) => column);

  GeneratedColumn<String> get barcode =>
      $composableBuilder(column: $table.barcode, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$ProductsTableAnnotationComposer get productId {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UnitsTableAnnotationComposer get unitId {
    final $$UnitsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.unitId,
      referencedTable: $db.units,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UnitsTableAnnotationComposer(
            $db: $db,
            $table: $db.units,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProductUnitsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductUnitsTable,
          ProductUnitRow,
          $$ProductUnitsTableFilterComposer,
          $$ProductUnitsTableOrderingComposer,
          $$ProductUnitsTableAnnotationComposer,
          $$ProductUnitsTableCreateCompanionBuilder,
          $$ProductUnitsTableUpdateCompanionBuilder,
          (ProductUnitRow, $$ProductUnitsTableReferences),
          ProductUnitRow,
          PrefetchHooks Function({bool productId, bool unitId})
        > {
  $$ProductUnitsTableTableManager(_$AppDatabase db, $ProductUnitsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductUnitsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductUnitsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductUnitsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> productId = const Value.absent(),
                Value<int> unitId = const Value.absent(),
                Value<double> factor = const Value.absent(),
                Value<bool> isBase = const Value.absent(),
                Value<bool> isDefault = const Value.absent(),
                Value<double?> priceOverride = const Value.absent(),
                Value<String?> sku = const Value.absent(),
                Value<String?> barcode = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductUnitsCompanion(
                productId: productId,
                unitId: unitId,
                factor: factor,
                isBase: isBase,
                isDefault: isDefault,
                priceOverride: priceOverride,
                sku: sku,
                barcode: barcode,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int productId,
                required int unitId,
                Value<double> factor = const Value.absent(),
                Value<bool> isBase = const Value.absent(),
                Value<bool> isDefault = const Value.absent(),
                Value<double?> priceOverride = const Value.absent(),
                Value<String?> sku = const Value.absent(),
                Value<String?> barcode = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductUnitsCompanion.insert(
                productId: productId,
                unitId: unitId,
                factor: factor,
                isBase: isBase,
                isDefault: isDefault,
                priceOverride: priceOverride,
                sku: sku,
                barcode: barcode,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProductUnitsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({productId = false, unitId = false}) {
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
                    if (productId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.productId,
                                referencedTable: $$ProductUnitsTableReferences
                                    ._productIdTable(db),
                                referencedColumn: $$ProductUnitsTableReferences
                                    ._productIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (unitId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.unitId,
                                referencedTable: $$ProductUnitsTableReferences
                                    ._unitIdTable(db),
                                referencedColumn: $$ProductUnitsTableReferences
                                    ._unitIdTable(db)
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

typedef $$ProductUnitsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductUnitsTable,
      ProductUnitRow,
      $$ProductUnitsTableFilterComposer,
      $$ProductUnitsTableOrderingComposer,
      $$ProductUnitsTableAnnotationComposer,
      $$ProductUnitsTableCreateCompanionBuilder,
      $$ProductUnitsTableUpdateCompanionBuilder,
      (ProductUnitRow, $$ProductUnitsTableReferences),
      ProductUnitRow,
      PrefetchHooks Function({bool productId, bool unitId})
    >;
typedef $$ProductVariantsTableCreateCompanionBuilder =
    ProductVariantsCompanion Function({
      Value<int> id,
      required int productId,
      Value<String?> size,
      Value<String?> color,
      Value<String?> sku,
      Value<double?> priceOverride,
      Value<int> stock,
      Value<bool> isActive,
      Value<DateTime> createdAt,
    });
typedef $$ProductVariantsTableUpdateCompanionBuilder =
    ProductVariantsCompanion Function({
      Value<int> id,
      Value<int> productId,
      Value<String?> size,
      Value<String?> color,
      Value<String?> sku,
      Value<double?> priceOverride,
      Value<int> stock,
      Value<bool> isActive,
      Value<DateTime> createdAt,
    });

class $$ProductVariantsTableFilterComposer
    extends Composer<_$AppDatabase, $ProductVariantsTable> {
  $$ProductVariantsTableFilterComposer({
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

  ColumnFilters<int> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get size => $composableBuilder(
    column: $table.size,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sku => $composableBuilder(
    column: $table.sku,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get priceOverride => $composableBuilder(
    column: $table.priceOverride,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get stock => $composableBuilder(
    column: $table.stock,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProductVariantsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductVariantsTable> {
  $$ProductVariantsTableOrderingComposer({
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

  ColumnOrderings<int> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get size => $composableBuilder(
    column: $table.size,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sku => $composableBuilder(
    column: $table.sku,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get priceOverride => $composableBuilder(
    column: $table.priceOverride,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stock => $composableBuilder(
    column: $table.stock,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProductVariantsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductVariantsTable> {
  $$ProductVariantsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<String> get size =>
      $composableBuilder(column: $table.size, builder: (column) => column);

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<String> get sku =>
      $composableBuilder(column: $table.sku, builder: (column) => column);

  GeneratedColumn<double> get priceOverride => $composableBuilder(
    column: $table.priceOverride,
    builder: (column) => column,
  );

  GeneratedColumn<int> get stock =>
      $composableBuilder(column: $table.stock, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$ProductVariantsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductVariantsTable,
          ProductVariantRow,
          $$ProductVariantsTableFilterComposer,
          $$ProductVariantsTableOrderingComposer,
          $$ProductVariantsTableAnnotationComposer,
          $$ProductVariantsTableCreateCompanionBuilder,
          $$ProductVariantsTableUpdateCompanionBuilder,
          (
            ProductVariantRow,
            BaseReferences<
              _$AppDatabase,
              $ProductVariantsTable,
              ProductVariantRow
            >,
          ),
          ProductVariantRow,
          PrefetchHooks Function()
        > {
  $$ProductVariantsTableTableManager(
    _$AppDatabase db,
    $ProductVariantsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductVariantsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductVariantsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductVariantsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> productId = const Value.absent(),
                Value<String?> size = const Value.absent(),
                Value<String?> color = const Value.absent(),
                Value<String?> sku = const Value.absent(),
                Value<double?> priceOverride = const Value.absent(),
                Value<int> stock = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ProductVariantsCompanion(
                id: id,
                productId: productId,
                size: size,
                color: color,
                sku: sku,
                priceOverride: priceOverride,
                stock: stock,
                isActive: isActive,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int productId,
                Value<String?> size = const Value.absent(),
                Value<String?> color = const Value.absent(),
                Value<String?> sku = const Value.absent(),
                Value<double?> priceOverride = const Value.absent(),
                Value<int> stock = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ProductVariantsCompanion.insert(
                id: id,
                productId: productId,
                size: size,
                color: color,
                sku: sku,
                priceOverride: priceOverride,
                stock: stock,
                isActive: isActive,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProductVariantsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductVariantsTable,
      ProductVariantRow,
      $$ProductVariantsTableFilterComposer,
      $$ProductVariantsTableOrderingComposer,
      $$ProductVariantsTableAnnotationComposer,
      $$ProductVariantsTableCreateCompanionBuilder,
      $$ProductVariantsTableUpdateCompanionBuilder,
      (
        ProductVariantRow,
        BaseReferences<_$AppDatabase, $ProductVariantsTable, ProductVariantRow>,
      ),
      ProductVariantRow,
      PrefetchHooks Function()
    >;
typedef $$PromotionsTableCreateCompanionBuilder =
    PromotionsCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> couponCode,
      required int typeValue,
      Value<double> value,
      Value<DateTime?> startAt,
      Value<DateTime?> endAt,
    });
typedef $$PromotionsTableUpdateCompanionBuilder =
    PromotionsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> couponCode,
      Value<int> typeValue,
      Value<double> value,
      Value<DateTime?> startAt,
      Value<DateTime?> endAt,
    });

class $$PromotionsTableFilterComposer
    extends Composer<_$AppDatabase, $PromotionsTable> {
  $$PromotionsTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get couponCode => $composableBuilder(
    column: $table.couponCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get typeValue => $composableBuilder(
    column: $table.typeValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startAt => $composableBuilder(
    column: $table.startAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endAt => $composableBuilder(
    column: $table.endAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PromotionsTableOrderingComposer
    extends Composer<_$AppDatabase, $PromotionsTable> {
  $$PromotionsTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get couponCode => $composableBuilder(
    column: $table.couponCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get typeValue => $composableBuilder(
    column: $table.typeValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startAt => $composableBuilder(
    column: $table.startAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endAt => $composableBuilder(
    column: $table.endAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PromotionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PromotionsTable> {
  $$PromotionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get couponCode => $composableBuilder(
    column: $table.couponCode,
    builder: (column) => column,
  );

  GeneratedColumn<int> get typeValue =>
      $composableBuilder(column: $table.typeValue, builder: (column) => column);

  GeneratedColumn<double> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<DateTime> get startAt =>
      $composableBuilder(column: $table.startAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endAt =>
      $composableBuilder(column: $table.endAt, builder: (column) => column);
}

class $$PromotionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PromotionsTable,
          PromotionRow,
          $$PromotionsTableFilterComposer,
          $$PromotionsTableOrderingComposer,
          $$PromotionsTableAnnotationComposer,
          $$PromotionsTableCreateCompanionBuilder,
          $$PromotionsTableUpdateCompanionBuilder,
          (
            PromotionRow,
            BaseReferences<_$AppDatabase, $PromotionsTable, PromotionRow>,
          ),
          PromotionRow,
          PrefetchHooks Function()
        > {
  $$PromotionsTableTableManager(_$AppDatabase db, $PromotionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PromotionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PromotionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PromotionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> couponCode = const Value.absent(),
                Value<int> typeValue = const Value.absent(),
                Value<double> value = const Value.absent(),
                Value<DateTime?> startAt = const Value.absent(),
                Value<DateTime?> endAt = const Value.absent(),
              }) => PromotionsCompanion(
                id: id,
                name: name,
                couponCode: couponCode,
                typeValue: typeValue,
                value: value,
                startAt: startAt,
                endAt: endAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> couponCode = const Value.absent(),
                required int typeValue,
                Value<double> value = const Value.absent(),
                Value<DateTime?> startAt = const Value.absent(),
                Value<DateTime?> endAt = const Value.absent(),
              }) => PromotionsCompanion.insert(
                id: id,
                name: name,
                couponCode: couponCode,
                typeValue: typeValue,
                value: value,
                startAt: startAt,
                endAt: endAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PromotionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PromotionsTable,
      PromotionRow,
      $$PromotionsTableFilterComposer,
      $$PromotionsTableOrderingComposer,
      $$PromotionsTableAnnotationComposer,
      $$PromotionsTableCreateCompanionBuilder,
      $$PromotionsTableUpdateCompanionBuilder,
      (
        PromotionRow,
        BaseReferences<_$AppDatabase, $PromotionsTable, PromotionRow>,
      ),
      PromotionRow,
      PrefetchHooks Function()
    >;
typedef $$PurchaseOrdersTableCreateCompanionBuilder =
    PurchaseOrdersCompanion Function({
      Value<int> id,
      required int supplierId,
      Value<DateTime> createdAt,
      Value<String> status,
      Value<String> itemsJson,
    });
typedef $$PurchaseOrdersTableUpdateCompanionBuilder =
    PurchaseOrdersCompanion Function({
      Value<int> id,
      Value<int> supplierId,
      Value<DateTime> createdAt,
      Value<String> status,
      Value<String> itemsJson,
    });

class $$PurchaseOrdersTableFilterComposer
    extends Composer<_$AppDatabase, $PurchaseOrdersTable> {
  $$PurchaseOrdersTableFilterComposer({
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

  ColumnFilters<int> get supplierId => $composableBuilder(
    column: $table.supplierId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get itemsJson => $composableBuilder(
    column: $table.itemsJson,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PurchaseOrdersTableOrderingComposer
    extends Composer<_$AppDatabase, $PurchaseOrdersTable> {
  $$PurchaseOrdersTableOrderingComposer({
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

  ColumnOrderings<int> get supplierId => $composableBuilder(
    column: $table.supplierId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get itemsJson => $composableBuilder(
    column: $table.itemsJson,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PurchaseOrdersTableAnnotationComposer
    extends Composer<_$AppDatabase, $PurchaseOrdersTable> {
  $$PurchaseOrdersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get supplierId => $composableBuilder(
    column: $table.supplierId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get itemsJson =>
      $composableBuilder(column: $table.itemsJson, builder: (column) => column);
}

class $$PurchaseOrdersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PurchaseOrdersTable,
          PurchaseOrderRow,
          $$PurchaseOrdersTableFilterComposer,
          $$PurchaseOrdersTableOrderingComposer,
          $$PurchaseOrdersTableAnnotationComposer,
          $$PurchaseOrdersTableCreateCompanionBuilder,
          $$PurchaseOrdersTableUpdateCompanionBuilder,
          (
            PurchaseOrderRow,
            BaseReferences<
              _$AppDatabase,
              $PurchaseOrdersTable,
              PurchaseOrderRow
            >,
          ),
          PurchaseOrderRow,
          PrefetchHooks Function()
        > {
  $$PurchaseOrdersTableTableManager(
    _$AppDatabase db,
    $PurchaseOrdersTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PurchaseOrdersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PurchaseOrdersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PurchaseOrdersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> supplierId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> itemsJson = const Value.absent(),
              }) => PurchaseOrdersCompanion(
                id: id,
                supplierId: supplierId,
                createdAt: createdAt,
                status: status,
                itemsJson: itemsJson,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int supplierId,
                Value<DateTime> createdAt = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> itemsJson = const Value.absent(),
              }) => PurchaseOrdersCompanion.insert(
                id: id,
                supplierId: supplierId,
                createdAt: createdAt,
                status: status,
                itemsJson: itemsJson,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PurchaseOrdersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PurchaseOrdersTable,
      PurchaseOrderRow,
      $$PurchaseOrdersTableFilterComposer,
      $$PurchaseOrdersTableOrderingComposer,
      $$PurchaseOrdersTableAnnotationComposer,
      $$PurchaseOrdersTableCreateCompanionBuilder,
      $$PurchaseOrdersTableUpdateCompanionBuilder,
      (
        PurchaseOrderRow,
        BaseReferences<_$AppDatabase, $PurchaseOrdersTable, PurchaseOrderRow>,
      ),
      PurchaseOrderRow,
      PrefetchHooks Function()
    >;
typedef $$ReturnsTableCreateCompanionBuilder =
    ReturnsCompanion Function({
      Value<int> id,
      required int originalOrderId,
      Value<DateTime> createdAt,
      Value<String> reason,
      Value<String> notes,
      Value<double> refundAmount,
      Value<String> itemsJson,
      Value<int?> customerId,
    });
typedef $$ReturnsTableUpdateCompanionBuilder =
    ReturnsCompanion Function({
      Value<int> id,
      Value<int> originalOrderId,
      Value<DateTime> createdAt,
      Value<String> reason,
      Value<String> notes,
      Value<double> refundAmount,
      Value<String> itemsJson,
      Value<int?> customerId,
    });

class $$ReturnsTableFilterComposer
    extends Composer<_$AppDatabase, $ReturnsTable> {
  $$ReturnsTableFilterComposer({
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

  ColumnFilters<int> get originalOrderId => $composableBuilder(
    column: $table.originalOrderId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get refundAmount => $composableBuilder(
    column: $table.refundAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get itemsJson => $composableBuilder(
    column: $table.itemsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ReturnsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReturnsTable> {
  $$ReturnsTableOrderingComposer({
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

  ColumnOrderings<int> get originalOrderId => $composableBuilder(
    column: $table.originalOrderId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get refundAmount => $composableBuilder(
    column: $table.refundAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get itemsJson => $composableBuilder(
    column: $table.itemsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ReturnsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReturnsTable> {
  $$ReturnsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get originalOrderId => $composableBuilder(
    column: $table.originalOrderId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<double> get refundAmount => $composableBuilder(
    column: $table.refundAmount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get itemsJson =>
      $composableBuilder(column: $table.itemsJson, builder: (column) => column);

  GeneratedColumn<int> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => column,
  );
}

class $$ReturnsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReturnsTable,
          ReturnRow,
          $$ReturnsTableFilterComposer,
          $$ReturnsTableOrderingComposer,
          $$ReturnsTableAnnotationComposer,
          $$ReturnsTableCreateCompanionBuilder,
          $$ReturnsTableUpdateCompanionBuilder,
          (ReturnRow, BaseReferences<_$AppDatabase, $ReturnsTable, ReturnRow>),
          ReturnRow,
          PrefetchHooks Function()
        > {
  $$ReturnsTableTableManager(_$AppDatabase db, $ReturnsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReturnsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReturnsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReturnsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> originalOrderId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String> reason = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<double> refundAmount = const Value.absent(),
                Value<String> itemsJson = const Value.absent(),
                Value<int?> customerId = const Value.absent(),
              }) => ReturnsCompanion(
                id: id,
                originalOrderId: originalOrderId,
                createdAt: createdAt,
                reason: reason,
                notes: notes,
                refundAmount: refundAmount,
                itemsJson: itemsJson,
                customerId: customerId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int originalOrderId,
                Value<DateTime> createdAt = const Value.absent(),
                Value<String> reason = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<double> refundAmount = const Value.absent(),
                Value<String> itemsJson = const Value.absent(),
                Value<int?> customerId = const Value.absent(),
              }) => ReturnsCompanion.insert(
                id: id,
                originalOrderId: originalOrderId,
                createdAt: createdAt,
                reason: reason,
                notes: notes,
                refundAmount: refundAmount,
                itemsJson: itemsJson,
                customerId: customerId,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ReturnsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReturnsTable,
      ReturnRow,
      $$ReturnsTableFilterComposer,
      $$ReturnsTableOrderingComposer,
      $$ReturnsTableAnnotationComposer,
      $$ReturnsTableCreateCompanionBuilder,
      $$ReturnsTableUpdateCompanionBuilder,
      (ReturnRow, BaseReferences<_$AppDatabase, $ReturnsTable, ReturnRow>),
      ReturnRow,
      PrefetchHooks Function()
    >;
typedef $$StockAdjustmentsTableCreateCompanionBuilder =
    StockAdjustmentsCompanion Function({
      Value<int> id,
      required int productId,
      required int delta,
      Value<String> reason,
      Value<String> notes,
      Value<DateTime> createdAt,
      Value<String?> batchNumber,
      Value<DateTime?> expiryDate,
    });
typedef $$StockAdjustmentsTableUpdateCompanionBuilder =
    StockAdjustmentsCompanion Function({
      Value<int> id,
      Value<int> productId,
      Value<int> delta,
      Value<String> reason,
      Value<String> notes,
      Value<DateTime> createdAt,
      Value<String?> batchNumber,
      Value<DateTime?> expiryDate,
    });

class $$StockAdjustmentsTableFilterComposer
    extends Composer<_$AppDatabase, $StockAdjustmentsTable> {
  $$StockAdjustmentsTableFilterComposer({
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

  ColumnFilters<int> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get delta => $composableBuilder(
    column: $table.delta,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get batchNumber => $composableBuilder(
    column: $table.batchNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expiryDate => $composableBuilder(
    column: $table.expiryDate,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StockAdjustmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $StockAdjustmentsTable> {
  $$StockAdjustmentsTableOrderingComposer({
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

  ColumnOrderings<int> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get delta => $composableBuilder(
    column: $table.delta,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get batchNumber => $composableBuilder(
    column: $table.batchNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expiryDate => $composableBuilder(
    column: $table.expiryDate,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StockAdjustmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StockAdjustmentsTable> {
  $$StockAdjustmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<int> get delta =>
      $composableBuilder(column: $table.delta, builder: (column) => column);

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get batchNumber => $composableBuilder(
    column: $table.batchNumber,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get expiryDate => $composableBuilder(
    column: $table.expiryDate,
    builder: (column) => column,
  );
}

class $$StockAdjustmentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StockAdjustmentsTable,
          StockAdjustmentRow,
          $$StockAdjustmentsTableFilterComposer,
          $$StockAdjustmentsTableOrderingComposer,
          $$StockAdjustmentsTableAnnotationComposer,
          $$StockAdjustmentsTableCreateCompanionBuilder,
          $$StockAdjustmentsTableUpdateCompanionBuilder,
          (
            StockAdjustmentRow,
            BaseReferences<
              _$AppDatabase,
              $StockAdjustmentsTable,
              StockAdjustmentRow
            >,
          ),
          StockAdjustmentRow,
          PrefetchHooks Function()
        > {
  $$StockAdjustmentsTableTableManager(
    _$AppDatabase db,
    $StockAdjustmentsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StockAdjustmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StockAdjustmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StockAdjustmentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> productId = const Value.absent(),
                Value<int> delta = const Value.absent(),
                Value<String> reason = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String?> batchNumber = const Value.absent(),
                Value<DateTime?> expiryDate = const Value.absent(),
              }) => StockAdjustmentsCompanion(
                id: id,
                productId: productId,
                delta: delta,
                reason: reason,
                notes: notes,
                createdAt: createdAt,
                batchNumber: batchNumber,
                expiryDate: expiryDate,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int productId,
                required int delta,
                Value<String> reason = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String?> batchNumber = const Value.absent(),
                Value<DateTime?> expiryDate = const Value.absent(),
              }) => StockAdjustmentsCompanion.insert(
                id: id,
                productId: productId,
                delta: delta,
                reason: reason,
                notes: notes,
                createdAt: createdAt,
                batchNumber: batchNumber,
                expiryDate: expiryDate,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StockAdjustmentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StockAdjustmentsTable,
      StockAdjustmentRow,
      $$StockAdjustmentsTableFilterComposer,
      $$StockAdjustmentsTableOrderingComposer,
      $$StockAdjustmentsTableAnnotationComposer,
      $$StockAdjustmentsTableCreateCompanionBuilder,
      $$StockAdjustmentsTableUpdateCompanionBuilder,
      (
        StockAdjustmentRow,
        BaseReferences<
          _$AppDatabase,
          $StockAdjustmentsTable,
          StockAdjustmentRow
        >,
      ),
      StockAdjustmentRow,
      PrefetchHooks Function()
    >;
typedef $$StockTransfersTableCreateCompanionBuilder =
    StockTransfersCompanion Function({
      Value<int> id,
      required int fromStoreId,
      required int toStoreId,
      required int productId,
      required int quantity,
      Value<String> status,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime?> completedAt,
    });
typedef $$StockTransfersTableUpdateCompanionBuilder =
    StockTransfersCompanion Function({
      Value<int> id,
      Value<int> fromStoreId,
      Value<int> toStoreId,
      Value<int> productId,
      Value<int> quantity,
      Value<String> status,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime?> completedAt,
    });

class $$StockTransfersTableFilterComposer
    extends Composer<_$AppDatabase, $StockTransfersTable> {
  $$StockTransfersTableFilterComposer({
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

  ColumnFilters<int> get fromStoreId => $composableBuilder(
    column: $table.fromStoreId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get toStoreId => $composableBuilder(
    column: $table.toStoreId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StockTransfersTableOrderingComposer
    extends Composer<_$AppDatabase, $StockTransfersTable> {
  $$StockTransfersTableOrderingComposer({
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

  ColumnOrderings<int> get fromStoreId => $composableBuilder(
    column: $table.fromStoreId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get toStoreId => $composableBuilder(
    column: $table.toStoreId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StockTransfersTableAnnotationComposer
    extends Composer<_$AppDatabase, $StockTransfersTable> {
  $$StockTransfersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get fromStoreId => $composableBuilder(
    column: $table.fromStoreId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get toStoreId =>
      $composableBuilder(column: $table.toStoreId, builder: (column) => column);

  GeneratedColumn<int> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );
}

class $$StockTransfersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StockTransfersTable,
          StockTransferRow,
          $$StockTransfersTableFilterComposer,
          $$StockTransfersTableOrderingComposer,
          $$StockTransfersTableAnnotationComposer,
          $$StockTransfersTableCreateCompanionBuilder,
          $$StockTransfersTableUpdateCompanionBuilder,
          (
            StockTransferRow,
            BaseReferences<
              _$AppDatabase,
              $StockTransfersTable,
              StockTransferRow
            >,
          ),
          StockTransferRow,
          PrefetchHooks Function()
        > {
  $$StockTransfersTableTableManager(
    _$AppDatabase db,
    $StockTransfersTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StockTransfersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StockTransfersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StockTransfersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> fromStoreId = const Value.absent(),
                Value<int> toStoreId = const Value.absent(),
                Value<int> productId = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
              }) => StockTransfersCompanion(
                id: id,
                fromStoreId: fromStoreId,
                toStoreId: toStoreId,
                productId: productId,
                quantity: quantity,
                status: status,
                notes: notes,
                createdAt: createdAt,
                completedAt: completedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int fromStoreId,
                required int toStoreId,
                required int productId,
                required int quantity,
                Value<String> status = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
              }) => StockTransfersCompanion.insert(
                id: id,
                fromStoreId: fromStoreId,
                toStoreId: toStoreId,
                productId: productId,
                quantity: quantity,
                status: status,
                notes: notes,
                createdAt: createdAt,
                completedAt: completedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StockTransfersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StockTransfersTable,
      StockTransferRow,
      $$StockTransfersTableFilterComposer,
      $$StockTransfersTableOrderingComposer,
      $$StockTransfersTableAnnotationComposer,
      $$StockTransfersTableCreateCompanionBuilder,
      $$StockTransfersTableUpdateCompanionBuilder,
      (
        StockTransferRow,
        BaseReferences<_$AppDatabase, $StockTransfersTable, StockTransferRow>,
      ),
      StockTransferRow,
      PrefetchHooks Function()
    >;
typedef $$StoresTableCreateCompanionBuilder =
    StoresCompanion Function({
      Value<int> id,
      required String name,
      Value<String> address,
      Value<String?> phone,
      Value<String?> email,
      Value<bool> isActive,
      Value<DateTime> createdAt,
    });
typedef $$StoresTableUpdateCompanionBuilder =
    StoresCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> address,
      Value<String?> phone,
      Value<String?> email,
      Value<bool> isActive,
      Value<DateTime> createdAt,
    });

class $$StoresTableFilterComposer
    extends Composer<_$AppDatabase, $StoresTable> {
  $$StoresTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StoresTableOrderingComposer
    extends Composer<_$AppDatabase, $StoresTable> {
  $$StoresTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StoresTableAnnotationComposer
    extends Composer<_$AppDatabase, $StoresTable> {
  $$StoresTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$StoresTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StoresTable,
          StoreRow,
          $$StoresTableFilterComposer,
          $$StoresTableOrderingComposer,
          $$StoresTableAnnotationComposer,
          $$StoresTableCreateCompanionBuilder,
          $$StoresTableUpdateCompanionBuilder,
          (StoreRow, BaseReferences<_$AppDatabase, $StoresTable, StoreRow>),
          StoreRow,
          PrefetchHooks Function()
        > {
  $$StoresTableTableManager(_$AppDatabase db, $StoresTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StoresTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StoresTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StoresTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> address = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => StoresCompanion(
                id: id,
                name: name,
                address: address,
                phone: phone,
                email: email,
                isActive: isActive,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String> address = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => StoresCompanion.insert(
                id: id,
                name: name,
                address: address,
                phone: phone,
                email: email,
                isActive: isActive,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StoresTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StoresTable,
      StoreRow,
      $$StoresTableFilterComposer,
      $$StoresTableOrderingComposer,
      $$StoresTableAnnotationComposer,
      $$StoresTableCreateCompanionBuilder,
      $$StoresTableUpdateCompanionBuilder,
      (StoreRow, BaseReferences<_$AppDatabase, $StoresTable, StoreRow>),
      StoreRow,
      PrefetchHooks Function()
    >;
typedef $$SuppliersTableCreateCompanionBuilder =
    SuppliersCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> contactName,
      Value<String?> phone,
      Value<String?> email,
      Value<String?> address,
      Value<DateTime> createdAt,
    });
typedef $$SuppliersTableUpdateCompanionBuilder =
    SuppliersCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> contactName,
      Value<String?> phone,
      Value<String?> email,
      Value<String?> address,
      Value<DateTime> createdAt,
    });

class $$SuppliersTableFilterComposer
    extends Composer<_$AppDatabase, $SuppliersTable> {
  $$SuppliersTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contactName => $composableBuilder(
    column: $table.contactName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SuppliersTableOrderingComposer
    extends Composer<_$AppDatabase, $SuppliersTable> {
  $$SuppliersTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contactName => $composableBuilder(
    column: $table.contactName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SuppliersTableAnnotationComposer
    extends Composer<_$AppDatabase, $SuppliersTable> {
  $$SuppliersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get contactName => $composableBuilder(
    column: $table.contactName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$SuppliersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SuppliersTable,
          SupplierRow,
          $$SuppliersTableFilterComposer,
          $$SuppliersTableOrderingComposer,
          $$SuppliersTableAnnotationComposer,
          $$SuppliersTableCreateCompanionBuilder,
          $$SuppliersTableUpdateCompanionBuilder,
          (
            SupplierRow,
            BaseReferences<_$AppDatabase, $SuppliersTable, SupplierRow>,
          ),
          SupplierRow,
          PrefetchHooks Function()
        > {
  $$SuppliersTableTableManager(_$AppDatabase db, $SuppliersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SuppliersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SuppliersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SuppliersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> contactName = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => SuppliersCompanion(
                id: id,
                name: name,
                contactName: contactName,
                phone: phone,
                email: email,
                address: address,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> contactName = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => SuppliersCompanion.insert(
                id: id,
                name: name,
                contactName: contactName,
                phone: phone,
                email: email,
                address: address,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SuppliersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SuppliersTable,
      SupplierRow,
      $$SuppliersTableFilterComposer,
      $$SuppliersTableOrderingComposer,
      $$SuppliersTableAnnotationComposer,
      $$SuppliersTableCreateCompanionBuilder,
      $$SuppliersTableUpdateCompanionBuilder,
      (
        SupplierRow,
        BaseReferences<_$AppDatabase, $SuppliersTable, SupplierRow>,
      ),
      SupplierRow,
      PrefetchHooks Function()
    >;
typedef $$UsersTableCreateCompanionBuilder =
    UsersCompanion Function({
      Value<int> id,
      required String username,
      required String password,
      required int roleValue,
      Value<DateTime> createdAt,
    });
typedef $$UsersTableUpdateCompanionBuilder =
    UsersCompanion Function({
      Value<int> id,
      Value<String> username,
      Value<String> password,
      Value<int> roleValue,
      Value<DateTime> createdAt,
    });

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
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

  ColumnFilters<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get password => $composableBuilder(
    column: $table.password,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get roleValue => $composableBuilder(
    column: $table.roleValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
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

  ColumnOrderings<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get password => $composableBuilder(
    column: $table.password,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get roleValue => $composableBuilder(
    column: $table.roleValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get password =>
      $composableBuilder(column: $table.password, builder: (column) => column);

  GeneratedColumn<int> get roleValue =>
      $composableBuilder(column: $table.roleValue, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$UsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsersTable,
          UserRow,
          $$UsersTableFilterComposer,
          $$UsersTableOrderingComposer,
          $$UsersTableAnnotationComposer,
          $$UsersTableCreateCompanionBuilder,
          $$UsersTableUpdateCompanionBuilder,
          (UserRow, BaseReferences<_$AppDatabase, $UsersTable, UserRow>),
          UserRow,
          PrefetchHooks Function()
        > {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> username = const Value.absent(),
                Value<String> password = const Value.absent(),
                Value<int> roleValue = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => UsersCompanion(
                id: id,
                username: username,
                password: password,
                roleValue: roleValue,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String username,
                required String password,
                required int roleValue,
                Value<DateTime> createdAt = const Value.absent(),
              }) => UsersCompanion.insert(
                id: id,
                username: username,
                password: password,
                roleValue: roleValue,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsersTable,
      UserRow,
      $$UsersTableFilterComposer,
      $$UsersTableOrderingComposer,
      $$UsersTableAnnotationComposer,
      $$UsersTableCreateCompanionBuilder,
      $$UsersTableUpdateCompanionBuilder,
      (UserRow, BaseReferences<_$AppDatabase, $UsersTable, UserRow>),
      UserRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AuditLogsTableTableManager get auditLogs =>
      $$AuditLogsTableTableManager(_db, _db.auditLogs);
  $$CustomersTableTableManager get customers =>
      $$CustomersTableTableManager(_db, _db.customers);
  $$GoodsReceiptsTableTableManager get goodsReceipts =>
      $$GoodsReceiptsTableTableManager(_db, _db.goodsReceipts);
  $$OrdersTableTableManager get orders =>
      $$OrdersTableTableManager(_db, _db.orders);
  $$PaymentsTableTableManager get payments =>
      $$PaymentsTableTableManager(_db, _db.payments);
  $$ProductBundlesTableTableManager get productBundles =>
      $$ProductBundlesTableTableManager(_db, _db.productBundles);
  $$ProductPricesTableTableManager get productPrices =>
      $$ProductPricesTableTableManager(_db, _db.productPrices);
  $$ProductsTableTableManager get products =>
      $$ProductsTableTableManager(_db, _db.products);
  $$UnitsTableTableManager get units =>
      $$UnitsTableTableManager(_db, _db.units);
  $$ProductUnitsTableTableManager get productUnits =>
      $$ProductUnitsTableTableManager(_db, _db.productUnits);
  $$ProductVariantsTableTableManager get productVariants =>
      $$ProductVariantsTableTableManager(_db, _db.productVariants);
  $$PromotionsTableTableManager get promotions =>
      $$PromotionsTableTableManager(_db, _db.promotions);
  $$PurchaseOrdersTableTableManager get purchaseOrders =>
      $$PurchaseOrdersTableTableManager(_db, _db.purchaseOrders);
  $$ReturnsTableTableManager get returns =>
      $$ReturnsTableTableManager(_db, _db.returns);
  $$StockAdjustmentsTableTableManager get stockAdjustments =>
      $$StockAdjustmentsTableTableManager(_db, _db.stockAdjustments);
  $$StockTransfersTableTableManager get stockTransfers =>
      $$StockTransfersTableTableManager(_db, _db.stockTransfers);
  $$StoresTableTableManager get stores =>
      $$StoresTableTableManager(_db, _db.stores);
  $$SuppliersTableTableManager get suppliers =>
      $$SuppliersTableTableManager(_db, _db.suppliers);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
}
