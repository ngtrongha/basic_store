import 'package:objectbox/objectbox.dart';


@Entity()
class Store {
  @Id()
  int id = 0;

  String name = '';
  String address = '';
  String? phone;
  String? email;
  bool isActive = true;
  @Property(type: PropertyType.date)
  DateTime createdAt = DateTime.now();
}
