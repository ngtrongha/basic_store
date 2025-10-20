import 'package:isar/isar.dart';

import '../models/audit_log.dart';
import '../services/database_service.dart';

class AuditLogRepository {
  final Isar _isar = DatabaseService.instance.isar;

  Future<int> create(AuditLog log) async {
    return _isar.writeTxn(() => _isar.auditLogs.put(log));
  }

  Future<List<AuditLog>> list({int limit = 200}) async {
    return _isar.auditLogs.where().sortByCreatedAtDesc().limit(limit).findAll();
  }
}
