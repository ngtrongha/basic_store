
import '../../objectbox.g.dart';
import '../models/audit_log.dart';
import '../services/database_service.dart';

class AuditLogRepository {
  Box<AuditLog> get _box => DatabaseService.instance.store.box<AuditLog>();

  Future<int> create(AuditLog log) async {
    return DatabaseService.instance.runWrite<int>(() => _box.put(log));
  }

  Future<List<AuditLog>> list({int limit = 200}) async {
    final builder = _box.query()
      ..order(AuditLog_.createdAt, flags: Order.descending);
    final query = builder.build();
    try {
      final results = query.find();
      if (results.length <= limit) return results;
      return results.take(limit).toList();
    } finally {
      query.close();
    }
  }
}
