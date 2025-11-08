import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';
import '../repositories/user_repository.dart';

class AuthService {
  static const _currentUserIdKey = 'current_user_id';
  final _users = UserRepository();

  Future<AppUser?> login(String username, String password) async {
    final user = await _users.getByUsername(username);
    if (user != null && user.password == password) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_currentUserIdKey, user.id);
      return user;
    }
    return null;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_currentUserIdKey);
  }

  Future<AppUser?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt(_currentUserIdKey);
    if (id == null) return null;
    return _users.getById(id);
  }

  Future<bool> hasRole(UserRole role) async {
    final user = await getCurrentUser();
    if (user == null) return false;
    if (user.role == UserRole.admin) return true;
    return user.role == role;
  }
}
