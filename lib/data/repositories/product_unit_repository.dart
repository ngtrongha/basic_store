import 'package:drift/drift.dart';

import '../db/app_database.dart';
import '../models/product_unit.dart' as product_model;
import '../models/unit.dart' as unit_model;
import '../services/database_service.dart';
import 'unit_repository.dart';

class ProductUnitWithUnit {
  final product_model.ProductUnit productUnit;
  final unit_model.Unit unit;

  const ProductUnitWithUnit({required this.productUnit, required this.unit});
}

class ProductUnitRepository {
  AppDatabase get _db => DatabaseService.instance.db;

  Future<void> upsert(product_model.ProductUnit pu) async {
    final companion = ProductUnitsCompanion(
      productId: Value(pu.productId),
      unitId: Value(pu.unitId),
      factor: Value(pu.factor),
      isBase: Value(pu.isBase),
      isDefault: Value(pu.isDefault),
      priceOverride: Value(pu.priceOverride),
      sku: Value(pu.sku),
      barcode: Value(pu.barcode),
      createdAt: Value(pu.createdAt),
    );

    await _db
        .into(_db.productUnits)
        .insert(companion, mode: InsertMode.insertOrReplace);
  }

  Future<List<product_model.ProductUnit>> getByProduct(int productId) async {
    final rows =
        await (_db.select(_db.productUnits)
              ..where((t) => t.productId.equals(productId))
              ..orderBy([
                (t) => OrderingTerm(
                  expression: t.isDefault,
                  mode: OrderingMode.desc,
                ),
                (t) =>
                    OrderingTerm(expression: t.isBase, mode: OrderingMode.desc),
                (t) => OrderingTerm(expression: t.unitId),
              ]))
            .get();
    return rows.map(_toModel).toList();
  }

  Future<product_model.ProductUnit?> getDefaultByProduct(int productId) async {
    final row =
        await (_db.select(_db.productUnits)
              ..where(
                (t) => t.productId.equals(productId) & t.isDefault.equals(true),
              )
              ..limit(1))
            .getSingleOrNull();
    if (row != null) return _toModel(row);

    final base =
        await (_db.select(_db.productUnits)
              ..where(
                (t) => t.productId.equals(productId) & t.isBase.equals(true),
              )
              ..limit(1))
            .getSingleOrNull();
    if (base != null) return _toModel(base);

    final any =
        await (_db.select(_db.productUnits)
              ..where((t) => t.productId.equals(productId))
              ..limit(1))
            .getSingleOrNull();
    return any == null ? null : _toModel(any);
  }

  Future<ProductUnitWithUnit?> getDefaultByProductWithUnit(
    int productId,
  ) async {
    final pu = await getDefaultByProduct(productId);
    if (pu == null) return null;
    final unitRow = await (_db.select(
      _db.units,
    )..where((t) => t.id.equals(pu.unitId))).getSingleOrNull();
    if (unitRow == null) return null;
    return ProductUnitWithUnit(productUnit: pu, unit: _toUnit(unitRow));
  }

  Future<ProductUnitWithUnit?> findByProductAndUnitKey({
    required int productId,
    required String unitKey,
  }) async {
    final key = UnitRepository.normalizeKey(unitKey);
    if (key.isEmpty) return null;

    final query =
        _db.select(_db.productUnits).join([
            innerJoin(
              _db.units,
              _db.units.id.equalsExp(_db.productUnits.unitId),
            ),
          ])
          ..where(
            _db.productUnits.productId.equals(productId) &
                _db.units.key.equals(key),
          )
          ..limit(1);

    final row = await query.getSingleOrNull();
    if (row == null) return null;
    final puRow = row.readTable(_db.productUnits);
    final unitRow = row.readTable(_db.units);
    return ProductUnitWithUnit(
      productUnit: _toModel(puRow),
      unit: _toUnit(unitRow),
    );
  }

  Future<ProductUnitWithUnit?> lookupBySkuOrBarcode(String code) async {
    final q = code.trim();
    if (q.isEmpty) return null;

    final query =
        _db.select(_db.productUnits).join([
            innerJoin(
              _db.units,
              _db.units.id.equalsExp(_db.productUnits.unitId),
            ),
          ])
          ..where(
            _db.productUnits.sku.equals(q) | _db.productUnits.barcode.equals(q),
          )
          ..limit(1);

    final row = await query.getSingleOrNull();
    if (row == null) return null;
    final puRow = row.readTable(_db.productUnits);
    final unitRow = row.readTable(_db.units);
    return ProductUnitWithUnit(
      productUnit: _toModel(puRow),
      unit: _toUnit(unitRow),
    );
  }

  Future<List<ProductUnitWithUnit>> getByProductWithUnits(int productId) async {
    final query =
        _db.select(_db.productUnits).join([
            innerJoin(
              _db.units,
              _db.units.id.equalsExp(_db.productUnits.unitId),
            ),
          ])
          ..where(_db.productUnits.productId.equals(productId))
          ..orderBy([
            OrderingTerm(
              expression: _db.productUnits.isDefault,
              mode: OrderingMode.desc,
            ),
            OrderingTerm(
              expression: _db.productUnits.isBase,
              mode: OrderingMode.desc,
            ),
            OrderingTerm(expression: _db.units.name),
          ]);

    final rows = await query.get();
    return rows.map((r) {
      final puRow = r.readTable(_db.productUnits);
      final unitRow = r.readTable(_db.units);
      return ProductUnitWithUnit(
        productUnit: _toModel(puRow),
        unit: _toUnit(unitRow),
      );
    }).toList();
  }

  Future<List<ProductUnitWithUnit>> getAllWithUnits({int limit = 10000}) async {
    final query =
        _db.select(_db.productUnits).join([
            innerJoin(
              _db.units,
              _db.units.id.equalsExp(_db.productUnits.unitId),
            ),
          ])
          ..orderBy([
            OrderingTerm(expression: _db.productUnits.productId),
            OrderingTerm(expression: _db.units.name),
          ])
          ..limit(limit);

    final rows = await query.get();
    return rows.map((r) {
      final puRow = r.readTable(_db.productUnits);
      final unitRow = r.readTable(_db.units);
      return ProductUnitWithUnit(
        productUnit: _toModel(puRow),
        unit: _toUnit(unitRow),
      );
    }).toList();
  }

  Future<void> replaceForProduct({
    required int productId,
    required List<product_model.ProductUnit> units,
  }) async {
    await DatabaseService.instance.runWriteVoid((db) async {
      await (db.delete(
        db.productUnits,
      )..where((t) => t.productId.equals(productId))).go();

      if (units.isEmpty) return;

      await db.batch((batch) {
        batch.insertAll(
          db.productUnits,
          units
              .map(
                (u) => ProductUnitsCompanion.insert(
                  productId: productId,
                  unitId: u.unitId,
                  factor: Value(u.factor),
                  isBase: Value(u.isBase),
                  isDefault: Value(u.isDefault),
                  priceOverride: Value(u.priceOverride),
                  sku: Value(u.sku),
                  barcode: Value(u.barcode),
                  createdAt: Value(u.createdAt),
                ),
              )
              .toList(growable: false),
          mode: InsertMode.insertOrReplace,
        );
      });
    });
  }

  product_model.ProductUnit _toModel(ProductUnitRow row) {
    return product_model.ProductUnit()
      ..productId = row.productId
      ..unitId = row.unitId
      ..factor = row.factor
      ..isBase = row.isBase
      ..isDefault = row.isDefault
      ..priceOverride = row.priceOverride
      ..sku = row.sku
      ..barcode = row.barcode
      ..createdAt = row.createdAt;
  }

  unit_model.Unit _toUnit(UnitRow row) {
    return unit_model.Unit()
      ..id = row.id
      ..name = row.name
      ..key = row.key
      ..isActive = row.isActive
      ..createdAt = row.createdAt;
  }
}
