import 'package:objectbox/objectbox.dart';



@Entity()
class AuditLog {
  @Id()
  int id = 0;

  @Index()
  int? userId;

  @Index()
  String action = ''; // e.g., CHECKOUT, STOCK_ADJUST, RETURN

  String? details;
  @Property(type: PropertyType.date)
  DateTime createdAt = DateTime.now();
}
