import 'package:isar/isar.dart';

part 'audit_log.g.dart';

@Collection()
class AuditLog {
  Id id = Isar.autoIncrement;

  @Index()
  int? userId;

  @Index()
  late String action; // e.g., CHECKOUT, STOCK_ADJUST, RETURN

  String? details;
  DateTime createdAt = DateTime.now();
}
