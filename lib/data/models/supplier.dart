import 'package:objectbox/objectbox.dart';


@Entity()
class Supplier {
  @Id()
  int id = 0;

  @Index()
  String name = '';

  String? contactName;
  String? phone;
  String? email;
  String? address;
  @Property(type: PropertyType.date)
  DateTime createdAt = DateTime.now();
}
