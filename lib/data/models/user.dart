import 'package:isar/isar.dart';

part 'user.g.dart';

enum UserRole { admin, manager, cashier }

@Collection()
class AppUser {
  Id id = Isar.autoIncrement;

  @Index(unique: true, caseSensitive: false)
  late String username;

  // For demo only; in production store salted hash
  late String password;

  @enumerated
  late UserRole role;

  DateTime createdAt = DateTime.now();
}
