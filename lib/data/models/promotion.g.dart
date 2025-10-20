// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotion.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPromotionCollection on Isar {
  IsarCollection<Promotion> get promotions => this.collection();
}

const PromotionSchema = CollectionSchema(
  name: r'Promotion',
  id: -4983502548623607622,
  properties: {
    r'couponCode': PropertySchema(
      id: 0,
      name: r'couponCode',
      type: IsarType.string,
    ),
    r'endAt': PropertySchema(
      id: 1,
      name: r'endAt',
      type: IsarType.dateTime,
    ),
    r'isActiveNow': PropertySchema(
      id: 2,
      name: r'isActiveNow',
      type: IsarType.bool,
    ),
    r'name': PropertySchema(
      id: 3,
      name: r'name',
      type: IsarType.string,
    ),
    r'startAt': PropertySchema(
      id: 4,
      name: r'startAt',
      type: IsarType.dateTime,
    ),
    r'type': PropertySchema(
      id: 5,
      name: r'type',
      type: IsarType.byte,
      enumMap: _PromotiontypeEnumValueMap,
    ),
    r'value': PropertySchema(
      id: 6,
      name: r'value',
      type: IsarType.double,
    )
  },
  estimateSize: _promotionEstimateSize,
  serialize: _promotionSerialize,
  deserialize: _promotionDeserialize,
  deserializeProp: _promotionDeserializeProp,
  idName: r'id',
  indexes: {
    r'name': IndexSchema(
      id: 879695947855722453,
      name: r'name',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'name',
          type: IndexType.hash,
          caseSensitive: false,
        )
      ],
    ),
    r'couponCode': IndexSchema(
      id: 9202292763320664728,
      name: r'couponCode',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'couponCode',
          type: IndexType.hash,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _promotionGetId,
  getLinks: _promotionGetLinks,
  attach: _promotionAttach,
  version: '3.1.0+1',
);

int _promotionEstimateSize(
  Promotion object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.couponCode;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.name.length * 3;
  return bytesCount;
}

void _promotionSerialize(
  Promotion object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.couponCode);
  writer.writeDateTime(offsets[1], object.endAt);
  writer.writeBool(offsets[2], object.isActiveNow);
  writer.writeString(offsets[3], object.name);
  writer.writeDateTime(offsets[4], object.startAt);
  writer.writeByte(offsets[5], object.type.index);
  writer.writeDouble(offsets[6], object.value);
}

Promotion _promotionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Promotion();
  object.couponCode = reader.readStringOrNull(offsets[0]);
  object.endAt = reader.readDateTimeOrNull(offsets[1]);
  object.id = id;
  object.name = reader.readString(offsets[3]);
  object.startAt = reader.readDateTimeOrNull(offsets[4]);
  object.type = _PromotiontypeValueEnumMap[reader.readByteOrNull(offsets[5])] ??
      PromotionType.itemPercent;
  object.value = reader.readDouble(offsets[6]);
  return object;
}

P _promotionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 5:
      return (_PromotiontypeValueEnumMap[reader.readByteOrNull(offset)] ??
          PromotionType.itemPercent) as P;
    case 6:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _PromotiontypeEnumValueMap = {
  'itemPercent': 0,
  'itemAmount': 1,
  'cartPercent': 2,
  'cartAmount': 3,
  'couponPercent': 4,
  'couponAmount': 5,
};
const _PromotiontypeValueEnumMap = {
  0: PromotionType.itemPercent,
  1: PromotionType.itemAmount,
  2: PromotionType.cartPercent,
  3: PromotionType.cartAmount,
  4: PromotionType.couponPercent,
  5: PromotionType.couponAmount,
};

Id _promotionGetId(Promotion object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _promotionGetLinks(Promotion object) {
  return [];
}

void _promotionAttach(IsarCollection<dynamic> col, Id id, Promotion object) {
  object.id = id;
}

extension PromotionQueryWhereSort
    on QueryBuilder<Promotion, Promotion, QWhere> {
  QueryBuilder<Promotion, Promotion, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PromotionQueryWhere
    on QueryBuilder<Promotion, Promotion, QWhereClause> {
  QueryBuilder<Promotion, Promotion, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterWhereClause> nameEqualTo(
      String name) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'name',
        value: [name],
      ));
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterWhereClause> nameNotEqualTo(
      String name) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [],
              upper: [name],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [name],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [name],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [],
              upper: [name],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterWhereClause> couponCodeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'couponCode',
        value: [null],
      ));
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterWhereClause> couponCodeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'couponCode',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterWhereClause> couponCodeEqualTo(
      String? couponCode) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'couponCode',
        value: [couponCode],
      ));
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterWhereClause> couponCodeNotEqualTo(
      String? couponCode) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'couponCode',
              lower: [],
              upper: [couponCode],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'couponCode',
              lower: [couponCode],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'couponCode',
              lower: [couponCode],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'couponCode',
              lower: [],
              upper: [couponCode],
              includeUpper: false,
            ));
      }
    });
  }
}

extension PromotionQueryFilter
    on QueryBuilder<Promotion, Promotion, QFilterCondition> {
  QueryBuilder<Promotion, Promotion, QAfterFilterCondition> couponCodeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'couponCode',
      ));
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterFilterCondition>
      couponCodeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'couponCode',
      ));
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterFilterCondition> couponCodeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'couponCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterFilterCondition>
      couponCodeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'couponCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterFilterCondition> couponCodeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'couponCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterFilterCondition> couponCodeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'couponCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterFilterCondition>
      couponCodeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'couponCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterFilterCondition> couponCodeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'couponCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterFilterCondition> couponCodeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'couponCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterFilterCondition> couponCodeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'couponCode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterFilterCondition>
      couponCodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'couponCode',
        value: '',
      ));
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterFilterCondition>
      couponCodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'couponCode',
        value: '',
      ));
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterFilterCondition> endAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'endAt',
      ));
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterFilterCondition> endAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'endAt',
      ));
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterFilterCondition> endAtEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'endAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterFilterCondition> endAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'endAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterFilterCondition> endAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'endAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterFilterCondition> endAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'endAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterFilterCondition> isActiveNowEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isActiveNow',
        value: value,
      ));
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterFilterCondition> startAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'startAt',
      ));
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterFilterCondition> startAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'startAt',
      ));
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterFilterCondition> startAtEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'startAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterFilterCondition> startAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'startAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterFilterCondition> startAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'startAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterFilterCondition> startAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'startAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterFilterCondition> typeEqualTo(
      PromotionType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterFilterCondition> typeGreaterThan(
    PromotionType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterFilterCondition> typeLessThan(
    PromotionType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterFilterCondition> typeBetween(
    PromotionType lower,
    PromotionType upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterFilterCondition> valueEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'value',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterFilterCondition> valueGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'value',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterFilterCondition> valueLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'value',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterFilterCondition> valueBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'value',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension PromotionQueryObject
    on QueryBuilder<Promotion, Promotion, QFilterCondition> {}

extension PromotionQueryLinks
    on QueryBuilder<Promotion, Promotion, QFilterCondition> {}

extension PromotionQuerySortBy on QueryBuilder<Promotion, Promotion, QSortBy> {
  QueryBuilder<Promotion, Promotion, QAfterSortBy> sortByCouponCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'couponCode', Sort.asc);
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterSortBy> sortByCouponCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'couponCode', Sort.desc);
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterSortBy> sortByEndAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endAt', Sort.asc);
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterSortBy> sortByEndAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endAt', Sort.desc);
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterSortBy> sortByIsActiveNow() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActiveNow', Sort.asc);
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterSortBy> sortByIsActiveNowDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActiveNow', Sort.desc);
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterSortBy> sortByStartAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startAt', Sort.asc);
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterSortBy> sortByStartAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startAt', Sort.desc);
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterSortBy> sortByValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'value', Sort.asc);
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterSortBy> sortByValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'value', Sort.desc);
    });
  }
}

extension PromotionQuerySortThenBy
    on QueryBuilder<Promotion, Promotion, QSortThenBy> {
  QueryBuilder<Promotion, Promotion, QAfterSortBy> thenByCouponCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'couponCode', Sort.asc);
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterSortBy> thenByCouponCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'couponCode', Sort.desc);
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterSortBy> thenByEndAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endAt', Sort.asc);
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterSortBy> thenByEndAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endAt', Sort.desc);
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterSortBy> thenByIsActiveNow() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActiveNow', Sort.asc);
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterSortBy> thenByIsActiveNowDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActiveNow', Sort.desc);
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterSortBy> thenByStartAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startAt', Sort.asc);
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterSortBy> thenByStartAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startAt', Sort.desc);
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterSortBy> thenByValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'value', Sort.asc);
    });
  }

  QueryBuilder<Promotion, Promotion, QAfterSortBy> thenByValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'value', Sort.desc);
    });
  }
}

extension PromotionQueryWhereDistinct
    on QueryBuilder<Promotion, Promotion, QDistinct> {
  QueryBuilder<Promotion, Promotion, QDistinct> distinctByCouponCode(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'couponCode', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Promotion, Promotion, QDistinct> distinctByEndAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'endAt');
    });
  }

  QueryBuilder<Promotion, Promotion, QDistinct> distinctByIsActiveNow() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isActiveNow');
    });
  }

  QueryBuilder<Promotion, Promotion, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Promotion, Promotion, QDistinct> distinctByStartAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startAt');
    });
  }

  QueryBuilder<Promotion, Promotion, QDistinct> distinctByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type');
    });
  }

  QueryBuilder<Promotion, Promotion, QDistinct> distinctByValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'value');
    });
  }
}

extension PromotionQueryProperty
    on QueryBuilder<Promotion, Promotion, QQueryProperty> {
  QueryBuilder<Promotion, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Promotion, String?, QQueryOperations> couponCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'couponCode');
    });
  }

  QueryBuilder<Promotion, DateTime?, QQueryOperations> endAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'endAt');
    });
  }

  QueryBuilder<Promotion, bool, QQueryOperations> isActiveNowProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isActiveNow');
    });
  }

  QueryBuilder<Promotion, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Promotion, DateTime?, QQueryOperations> startAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startAt');
    });
  }

  QueryBuilder<Promotion, PromotionType, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }

  QueryBuilder<Promotion, double, QQueryOperations> valueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'value');
    });
  }
}
