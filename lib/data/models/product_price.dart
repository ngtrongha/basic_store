import 'package:objectbox/objectbox.dart';


@Entity()
class ProductPrice {
  @Id()
  int id = 0;

  int productId = 0;
  int storeId = 0;
  double price = 0;
  @Property(type: PropertyType.date)
  DateTime createdAt = DateTime.now();
  @Property(type: PropertyType.date)
  DateTime? validFrom;
  @Property(type: PropertyType.date)
  DateTime? validTo;
}
