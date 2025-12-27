import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/di/injection.dart';
import '../../data/services/auth_service.dart';
import '../../domain/models/auth_models.dart';

/// Auth service provider
final authServiceProvider = Provider<AuthService>((ref) {
  return getIt<AuthService>();
});
 
class AuthNotifier extends Notifier<AuthState> {
  late AuthService _authService;

  @override
  AuthState build() {
    _authService = ref.watch(authServiceProvider);

    // Check current user on init
    final currentUser = _authService.currentUser;
    if (currentUser != null) {
      // Listen to auth state changes
      _listenToAuthChanges();
      return AuthState.authenticated(currentUser);
    }

    _listenToAuthChanges();
    return const AuthState.unauthenticated();
  }

  void _listenToAuthChanges() {
    _authService.authStateChanges.listen((user) {
      if (user != null) {
        state = AuthState.authenticated(user);
      } else {
        state = const AuthState.unauthenticated();
      }
    });
  }

  /// Sign in with email and password
  Future<void> signInWithEmail(String email, String password) async {
    state = const AuthState.loading();
    try {
      final user = await _authService.signInWithEmail(email, password);
      state = AuthState.authenticated(user);
    } on AuthException catch (e) {
      state = AuthState.error(e.message);
    }
  }

  /// Register with email and password
  Future<void> registerWithEmail({
    required String email,
    required String password,
    String? displayName,
  }) async {
    state = const AuthState.loading();
    try {
      final user = await _authService.registerWithEmail(
        email: email,
        password: password,
        displayName: displayName,
      );
      state = AuthState.authenticated(user);
    } on AuthException catch (e) {
      state = AuthState.error(e.message);
    }
  }

  /// Sign in with Google
  Future<void> signInWithGoogle() async {
    state = const AuthState.loading();
    try {
      final user = await _authService.signInWithGoogle();
      state = AuthState.authenticated(user);
    } on AuthException catch (e) {
      state = AuthState.error(e.message);
    }
  }

  /// Sign in with Apple
  Future<void> signInWithApple() async {
    state = const AuthState.loading();
    try {
      final user = await _authService.signInWithApple();
      state = AuthState.authenticated(user);
    } on AuthException catch (e) {
      state = AuthState.error(e.message);
    }
  }

  /// Send password reset email
  Future<bool> sendPasswordResetEmail(String email) async {
    try {
      await _authService.sendPasswordResetEmail(email);
      return true;
    } on AuthException {
      return false;
    }
  }

  /// Sign out
  Future<void> signOut() async {
    await _authService.signOut();
    state = const AuthState.unauthenticated();
  }

  /// Clear error state
  void clearError() {
    final isError = state.maybeWhen(error: (_) => true, orElse: () => false);
    if (isError) {
      state = const AuthState.unauthenticated();
    }
  }
}

/// Auth notifier provider (Riverpod 3.0)
final authNotifierProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);

/// Current user provider
final currentUserProvider = Provider<AppUser?>((ref) {
  final authState = ref.watch(authNotifierProvider);
  return authState.maybeWhen(authenticated: (user) => user, orElse: () => null);
});

/// Is authenticated provider
final isAuthenticatedProvider = Provider<bool>((ref) {
  final authState = ref.watch(authNotifierProvider);
  return authState.maybeWhen(authenticated: (_) => true, orElse: () => false);
});
