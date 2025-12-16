enum UserRole { admin, manager, cashier }

class AppUser {
  int id = 0;

  String username = '';

  // For demo only; in production store salted hash
  String password = '';

  int roleValue = UserRole.admin.index;

  UserRole get role => UserRole.values[roleValue];

  set role(UserRole value) => roleValue = value.index;

  DateTime createdAt = DateTime.now();
}
