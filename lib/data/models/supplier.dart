import 'package:isar/isar.dart';

part 'supplier.g.dart';

@Collection()
class Supplier {
  Id id = Isar.autoIncrement;

  @Index(caseSensitive: false)
  late String name;

  String? contactName;
  String? phone;
  String? email;
  String? address;

  DateTime createdAt = DateTime.now();
}
