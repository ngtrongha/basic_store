// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goods_receipt.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetGoodsReceiptCollection on Isar {
  IsarCollection<GoodsReceipt> get goodsReceipts => this.collection();
}

const GoodsReceiptSchema = CollectionSchema(
  name: r'GoodsReceipt',
  id: -71658764919571263,
  properties: {
    r'items': PropertySchema(
      id: 0,
      name: r'items',
      type: IsarType.objectList,
      target: r'GoodsReceiptItem',
    ),
    r'notes': PropertySchema(
      id: 1,
      name: r'notes',
      type: IsarType.string,
    ),
    r'purchaseOrderId': PropertySchema(
      id: 2,
      name: r'purchaseOrderId',
      type: IsarType.long,
    ),
    r'receivedAt': PropertySchema(
      id: 3,
      name: r'receivedAt',
      type: IsarType.dateTime,
    ),
    r'supplierId': PropertySchema(
      id: 4,
      name: r'supplierId',
      type: IsarType.long,
    )
  },
  estimateSize: _goodsReceiptEstimateSize,
  serialize: _goodsReceiptSerialize,
  deserialize: _goodsReceiptDeserialize,
  deserializeProp: _goodsReceiptDeserializeProp,
  idName: r'id',
  indexes: {
    r'supplierId': IndexSchema(
      id: -7509772217447508349,
      name: r'supplierId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'supplierId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'purchaseOrderId': IndexSchema(
      id: -1594698832458899075,
      name: r'purchaseOrderId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'purchaseOrderId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {r'GoodsReceiptItem': GoodsReceiptItemSchema},
  getId: _goodsReceiptGetId,
  getLinks: _goodsReceiptGetLinks,
  attach: _goodsReceiptAttach,
  version: '3.1.0+1',
);

int _goodsReceiptEstimateSize(
  GoodsReceipt object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.items.length * 3;
  {
    final offsets = allOffsets[GoodsReceiptItem]!;
    for (var i = 0; i < object.items.length; i++) {
      final value = object.items[i];
      bytesCount +=
          GoodsReceiptItemSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  {
    final value = object.notes;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _goodsReceiptSerialize(
  GoodsReceipt object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObjectList<GoodsReceiptItem>(
    offsets[0],
    allOffsets,
    GoodsReceiptItemSchema.serialize,
    object.items,
  );
  writer.writeString(offsets[1], object.notes);
  writer.writeLong(offsets[2], object.purchaseOrderId);
  writer.writeDateTime(offsets[3], object.receivedAt);
  writer.writeLong(offsets[4], object.supplierId);
}

GoodsReceipt _goodsReceiptDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = GoodsReceipt();
  object.id = id;
  object.items = reader.readObjectList<GoodsReceiptItem>(
        offsets[0],
        GoodsReceiptItemSchema.deserialize,
        allOffsets,
        GoodsReceiptItem(),
      ) ??
      [];
  object.notes = reader.readStringOrNull(offsets[1]);
  object.purchaseOrderId = reader.readLongOrNull(offsets[2]);
  object.receivedAt = reader.readDateTime(offsets[3]);
  object.supplierId = reader.readLong(offsets[4]);
  return object;
}

P _goodsReceiptDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectList<GoodsReceiptItem>(
            offset,
            GoodsReceiptItemSchema.deserialize,
            allOffsets,
            GoodsReceiptItem(),
          ) ??
          []) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _goodsReceiptGetId(GoodsReceipt object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _goodsReceiptGetLinks(GoodsReceipt object) {
  return [];
}

void _goodsReceiptAttach(
    IsarCollection<dynamic> col, Id id, GoodsReceipt object) {
  object.id = id;
}

extension GoodsReceiptQueryWhereSort
    on QueryBuilder<GoodsReceipt, GoodsReceipt, QWhere> {
  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterWhere> anySupplierId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'supplierId'),
      );
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterWhere> anyPurchaseOrderId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'purchaseOrderId'),
      );
    });
  }
}

extension GoodsReceiptQueryWhere
    on QueryBuilder<GoodsReceipt, GoodsReceipt, QWhereClause> {
  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterWhereClause> idBetween(
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

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterWhereClause> supplierIdEqualTo(
      int supplierId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'supplierId',
        value: [supplierId],
      ));
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterWhereClause>
      supplierIdNotEqualTo(int supplierId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'supplierId',
              lower: [],
              upper: [supplierId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'supplierId',
              lower: [supplierId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'supplierId',
              lower: [supplierId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'supplierId',
              lower: [],
              upper: [supplierId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterWhereClause>
      supplierIdGreaterThan(
    int supplierId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'supplierId',
        lower: [supplierId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterWhereClause>
      supplierIdLessThan(
    int supplierId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'supplierId',
        lower: [],
        upper: [supplierId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterWhereClause> supplierIdBetween(
    int lowerSupplierId,
    int upperSupplierId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'supplierId',
        lower: [lowerSupplierId],
        includeLower: includeLower,
        upper: [upperSupplierId],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterWhereClause>
      purchaseOrderIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'purchaseOrderId',
        value: [null],
      ));
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterWhereClause>
      purchaseOrderIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'purchaseOrderId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterWhereClause>
      purchaseOrderIdEqualTo(int? purchaseOrderId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'purchaseOrderId',
        value: [purchaseOrderId],
      ));
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterWhereClause>
      purchaseOrderIdNotEqualTo(int? purchaseOrderId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'purchaseOrderId',
              lower: [],
              upper: [purchaseOrderId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'purchaseOrderId',
              lower: [purchaseOrderId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'purchaseOrderId',
              lower: [purchaseOrderId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'purchaseOrderId',
              lower: [],
              upper: [purchaseOrderId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterWhereClause>
      purchaseOrderIdGreaterThan(
    int? purchaseOrderId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'purchaseOrderId',
        lower: [purchaseOrderId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterWhereClause>
      purchaseOrderIdLessThan(
    int? purchaseOrderId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'purchaseOrderId',
        lower: [],
        upper: [purchaseOrderId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterWhereClause>
      purchaseOrderIdBetween(
    int? lowerPurchaseOrderId,
    int? upperPurchaseOrderId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'purchaseOrderId',
        lower: [lowerPurchaseOrderId],
        includeLower: includeLower,
        upper: [upperPurchaseOrderId],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension GoodsReceiptQueryFilter
    on QueryBuilder<GoodsReceipt, GoodsReceipt, QFilterCondition> {
  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterFilterCondition> idBetween(
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

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterFilterCondition>
      itemsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'items',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterFilterCondition>
      itemsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'items',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterFilterCondition>
      itemsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'items',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterFilterCondition>
      itemsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'items',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterFilterCondition>
      itemsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'items',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterFilterCondition>
      itemsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'items',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterFilterCondition>
      notesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'notes',
      ));
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterFilterCondition>
      notesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'notes',
      ));
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterFilterCondition> notesEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterFilterCondition>
      notesGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterFilterCondition> notesLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterFilterCondition> notesBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterFilterCondition>
      notesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterFilterCondition> notesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterFilterCondition> notesContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterFilterCondition> notesMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'notes',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterFilterCondition>
      notesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterFilterCondition>
      notesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterFilterCondition>
      purchaseOrderIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'purchaseOrderId',
      ));
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterFilterCondition>
      purchaseOrderIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'purchaseOrderId',
      ));
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterFilterCondition>
      purchaseOrderIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'purchaseOrderId',
        value: value,
      ));
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterFilterCondition>
      purchaseOrderIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'purchaseOrderId',
        value: value,
      ));
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterFilterCondition>
      purchaseOrderIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'purchaseOrderId',
        value: value,
      ));
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterFilterCondition>
      purchaseOrderIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'purchaseOrderId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterFilterCondition>
      receivedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'receivedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterFilterCondition>
      receivedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'receivedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterFilterCondition>
      receivedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'receivedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterFilterCondition>
      receivedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'receivedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterFilterCondition>
      supplierIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'supplierId',
        value: value,
      ));
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterFilterCondition>
      supplierIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'supplierId',
        value: value,
      ));
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterFilterCondition>
      supplierIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'supplierId',
        value: value,
      ));
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterFilterCondition>
      supplierIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'supplierId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension GoodsReceiptQueryObject
    on QueryBuilder<GoodsReceipt, GoodsReceipt, QFilterCondition> {
  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterFilterCondition> itemsElement(
      FilterQuery<GoodsReceiptItem> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'items');
    });
  }
}

extension GoodsReceiptQueryLinks
    on QueryBuilder<GoodsReceipt, GoodsReceipt, QFilterCondition> {}

extension GoodsReceiptQuerySortBy
    on QueryBuilder<GoodsReceipt, GoodsReceipt, QSortBy> {
  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterSortBy> sortByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterSortBy> sortByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterSortBy>
      sortByPurchaseOrderId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'purchaseOrderId', Sort.asc);
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterSortBy>
      sortByPurchaseOrderIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'purchaseOrderId', Sort.desc);
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterSortBy> sortByReceivedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'receivedAt', Sort.asc);
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterSortBy>
      sortByReceivedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'receivedAt', Sort.desc);
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterSortBy> sortBySupplierId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supplierId', Sort.asc);
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterSortBy>
      sortBySupplierIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supplierId', Sort.desc);
    });
  }
}

extension GoodsReceiptQuerySortThenBy
    on QueryBuilder<GoodsReceipt, GoodsReceipt, QSortThenBy> {
  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterSortBy> thenByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterSortBy> thenByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterSortBy>
      thenByPurchaseOrderId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'purchaseOrderId', Sort.asc);
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterSortBy>
      thenByPurchaseOrderIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'purchaseOrderId', Sort.desc);
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterSortBy> thenByReceivedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'receivedAt', Sort.asc);
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterSortBy>
      thenByReceivedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'receivedAt', Sort.desc);
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterSortBy> thenBySupplierId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supplierId', Sort.asc);
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QAfterSortBy>
      thenBySupplierIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supplierId', Sort.desc);
    });
  }
}

extension GoodsReceiptQueryWhereDistinct
    on QueryBuilder<GoodsReceipt, GoodsReceipt, QDistinct> {
  QueryBuilder<GoodsReceipt, GoodsReceipt, QDistinct> distinctByNotes(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QDistinct>
      distinctByPurchaseOrderId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'purchaseOrderId');
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QDistinct> distinctByReceivedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'receivedAt');
    });
  }

  QueryBuilder<GoodsReceipt, GoodsReceipt, QDistinct> distinctBySupplierId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'supplierId');
    });
  }
}

extension GoodsReceiptQueryProperty
    on QueryBuilder<GoodsReceipt, GoodsReceipt, QQueryProperty> {
  QueryBuilder<GoodsReceipt, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<GoodsReceipt, List<GoodsReceiptItem>, QQueryOperations>
      itemsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'items');
    });
  }

  QueryBuilder<GoodsReceipt, String?, QQueryOperations> notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notes');
    });
  }

  QueryBuilder<GoodsReceipt, int?, QQueryOperations> purchaseOrderIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'purchaseOrderId');
    });
  }

  QueryBuilder<GoodsReceipt, DateTime, QQueryOperations> receivedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'receivedAt');
    });
  }

  QueryBuilder<GoodsReceipt, int, QQueryOperations> supplierIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'supplierId');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const GoodsReceiptItemSchema = Schema(
  name: r'GoodsReceiptItem',
  id: 8965825720764464420,
  properties: {
    r'productId': PropertySchema(
      id: 0,
      name: r'productId',
      type: IsarType.long,
    ),
    r'quantity': PropertySchema(
      id: 1,
      name: r'quantity',
      type: IsarType.long,
    ),
    r'unitCost': PropertySchema(
      id: 2,
      name: r'unitCost',
      type: IsarType.double,
    )
  },
  estimateSize: _goodsReceiptItemEstimateSize,
  serialize: _goodsReceiptItemSerialize,
  deserialize: _goodsReceiptItemDeserialize,
  deserializeProp: _goodsReceiptItemDeserializeProp,
);

int _goodsReceiptItemEstimateSize(
  GoodsReceiptItem object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _goodsReceiptItemSerialize(
  GoodsReceiptItem object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.productId);
  writer.writeLong(offsets[1], object.quantity);
  writer.writeDouble(offsets[2], object.unitCost);
}

GoodsReceiptItem _goodsReceiptItemDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = GoodsReceiptItem();
  object.productId = reader.readLong(offsets[0]);
  object.quantity = reader.readLong(offsets[1]);
  object.unitCost = reader.readDouble(offsets[2]);
  return object;
}

P _goodsReceiptItemDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension GoodsReceiptItemQueryFilter
    on QueryBuilder<GoodsReceiptItem, GoodsReceiptItem, QFilterCondition> {
  QueryBuilder<GoodsReceiptItem, GoodsReceiptItem, QAfterFilterCondition>
      productIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'productId',
        value: value,
      ));
    });
  }

  QueryBuilder<GoodsReceiptItem, GoodsReceiptItem, QAfterFilterCondition>
      productIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'productId',
        value: value,
      ));
    });
  }

  QueryBuilder<GoodsReceiptItem, GoodsReceiptItem, QAfterFilterCondition>
      productIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'productId',
        value: value,
      ));
    });
  }

  QueryBuilder<GoodsReceiptItem, GoodsReceiptItem, QAfterFilterCondition>
      productIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'productId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GoodsReceiptItem, GoodsReceiptItem, QAfterFilterCondition>
      quantityEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quantity',
        value: value,
      ));
    });
  }

  QueryBuilder<GoodsReceiptItem, GoodsReceiptItem, QAfterFilterCondition>
      quantityGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quantity',
        value: value,
      ));
    });
  }

  QueryBuilder<GoodsReceiptItem, GoodsReceiptItem, QAfterFilterCondition>
      quantityLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quantity',
        value: value,
      ));
    });
  }

  QueryBuilder<GoodsReceiptItem, GoodsReceiptItem, QAfterFilterCondition>
      quantityBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quantity',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GoodsReceiptItem, GoodsReceiptItem, QAfterFilterCondition>
      unitCostEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'unitCost',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<GoodsReceiptItem, GoodsReceiptItem, QAfterFilterCondition>
      unitCostGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'unitCost',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<GoodsReceiptItem, GoodsReceiptItem, QAfterFilterCondition>
      unitCostLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'unitCost',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<GoodsReceiptItem, GoodsReceiptItem, QAfterFilterCondition>
      unitCostBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'unitCost',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension GoodsReceiptItemQueryObject
    on QueryBuilder<GoodsReceiptItem, GoodsReceiptItem, QFilterCondition> {}
