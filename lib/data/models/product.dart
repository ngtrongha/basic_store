import 'package:objectbox/objectbox.dart';


@Entity()
class Product {
  @Id()
  int id = 0;

  String name = '';

  @Index()
  @Unique()
  String sku = '';

  double costPrice = 0;
  double salePrice = 0;
  int stock = 0;
  int lowStockThreshold = 0; // Alert when stock falls below this
  String? category;
  String? description;
  String? barcode;
}
