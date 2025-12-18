import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/user.dart';
import '../../data/services/auth_service.dart';
import '../../di/injection.dart';
import 'login_state.dart';

final loginControllerProvider = NotifierProvider<LoginController, LoginState>(
  LoginController.new,
);

class LoginController extends Notifier<LoginState> {
  AuthService get _authService => getIt<AuthService>();

  @override
  LoginState build() => LoginState.initial();

  void setUsername(String value) {
    state = state.copyWith(username: value, errorMessage: null);
  }

  void setPassword(String value) {
    state = state.copyWith(password: value, errorMessage: null);
  }

  void togglePasswordVisibility() {
    state = state.copyWith(isPasswordVisible: !state.isPasswordVisible);
  }

  void toggleRememberMe() {
    state = state.copyWith(rememberMe: !state.rememberMe);
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  Future<AppUser?> login() async {
    if (state.username.trim().isEmpty) {
      state = state.copyWith(errorMessage: 'Vui lòng nhập tên đăng nhập');
      return null;
    }

    if (state.password.isEmpty) {
      state = state.copyWith(errorMessage: 'Vui lòng nhập mật khẩu');
      return null;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final user = await _authService.login(
        state.username.trim(),
        state.password,
      );

      if (user != null) {
        state = state.copyWith(isLoading: false, user: user);
        return user;
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'Tên đăng nhập hoặc mật khẩu không đúng',
        );
        return null;
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Đã xảy ra lỗi. Vui lòng thử lại.',
      );
      return null;
    }
  }

  void reset() {
    state = LoginState.initial();
  }
}
