import 'package:drift/drift.dart';

import '../db/app_database.dart';
import '../models/audit_log.dart';
import '../services/database_service.dart';

class AuditLogRepository {
  AppDatabase get _db => DatabaseService.instance.db;

  Future<int> create(AuditLog log) async {
    final companion = AuditLogsCompanion(
      id: log.id == 0 ? const Value.absent() : Value(log.id),
      userId: Value(log.userId),
      action: Value(log.action),
      details: Value(log.details),
      createdAt: Value(log.createdAt),
    );
    final id = await _db
        .into(_db.auditLogs)
        .insert(companion, mode: InsertMode.insertOrReplace);
    log.id = id;
    return id;
  }

  Future<List<AuditLog>> list({int limit = 200}) async {
    final rows =
        await (_db.select(_db.auditLogs)
              ..orderBy([
                (t) => OrderingTerm(
                  expression: t.createdAt,
                  mode: OrderingMode.desc,
                ),
              ])
              ..limit(limit))
            .get();
    return rows.map(_toModel).toList();
  }

  AuditLog _toModel(AuditLogRow row) {
    return AuditLog()
      ..id = row.id
      ..userId = row.userId
      ..action = row.action
      ..details = row.details
      ..createdAt = row.createdAt;
  }
}
