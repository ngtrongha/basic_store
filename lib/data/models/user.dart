import 'package:objectbox/objectbox.dart';


enum UserRole { admin, manager, cashier }

@Entity()
class AppUser {
  @Id()
  int id = 0;

  @Index()
  @Unique(onConflict: ConflictStrategy.replace)
  String username = '';

  // For demo only; in production store salted hash
  String password = '';

  @Property(type: PropertyType.byte)
  int roleValue = UserRole.admin.index;

  @Transient()
  UserRole get role => UserRole.values[roleValue];

  set role(UserRole value) => roleValue = value.index;

  @Property(type: PropertyType.date)
  DateTime createdAt = DateTime.now();
}
