class AuditLog {
  int id = 0;

  int? userId;

  String action = ''; // e.g., CHECKOUT, STOCK_ADJUST, RETURN

  String? details;
  DateTime createdAt = DateTime.now();
}
