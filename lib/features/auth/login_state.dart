import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/user.dart';

part 'login_state.freezed.dart';

@freezed
abstract class LoginState with _$LoginState {
  const factory LoginState({
    @Default('') String username,
    @Default('') String password,
    @Default(false) bool isLoading,
    @Default(false) bool isPasswordVisible,
    @Default(false) bool rememberMe,
    String? errorMessage,
    AppUser? user,
  }) = _LoginState;

  factory LoginState.initial() =>
      const LoginState(username: 'admin', password: 'admin');
}
