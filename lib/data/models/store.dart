import 'package:isar/isar.dart';

part 'store.g.dart';

@Collection()
class Store {
  Id id = Isar.autoIncrement;

  late String name;
  late String address;
  String? phone;
  String? email;
  bool isActive = true;
  DateTime createdAt = DateTime.now();
}
