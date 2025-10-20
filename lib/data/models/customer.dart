import 'package:isar/isar.dart';

part 'customer.g.dart';

@Collection()
class Customer {
  Id id = Isar.autoIncrement;

  @Index(caseSensitive: false)
  late String name;

  @Index(unique: true, caseSensitive: false, replace: true)
  String? phone;

  @Index(unique: true, caseSensitive: false, replace: true)
  String? email;

  String? tier; // e.g., Bronze/Silver/Gold

  int points = 0;
}
