import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../domain/models/auth_models.dart';

/// Authentication service with Firebase Auth, Google Sign-in, Apple Sign-in
@lazySingleton
class AuthService {
  AuthService(this._firebaseAuth);

  final FirebaseAuth _firebaseAuth;
  bool _googleSignInInitialized = false;
  GoogleSignInAccount? _currentGoogleUser;

  /// Get current user
  AppUser? get currentUser {
    final user = _firebaseAuth.currentUser;
    if (user == null) return null;
    return _mapFirebaseUser(user);
  }

  /// Auth state changes stream
  Stream<AppUser?> get authStateChanges {
    return _firebaseAuth.authStateChanges().map((user) {
      if (user == null) return null;
      return _mapFirebaseUser(user);
    });
  }

  /// Sign in with email and password
  Future<AppUser> signInWithEmail(String email, String password) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _mapFirebaseUser(credential.user!);
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseError(e);
    }
  }

  /// Register with email and password
  Future<AppUser> registerWithEmail({
     required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (displayName != null) {
        await credential.user!.updateDisplayName(displayName);
      }

      return _mapFirebaseUser(credential.user!);
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseError(e);
    }
  }

  /// Initialize Google Sign In (required for v7.x)
  Future<void> _initGoogleSignIn() async {
    if (_googleSignInInitialized) return;
    await GoogleSignIn.instance.initialize();
    _googleSignInInitialized = true;
  }

  /// Handle Google authentication event
  void _handleAuthEvent(GoogleSignInAuthenticationEvent event) {
    if (event case GoogleSignInAuthenticationEventSignIn(:final user)) {
      _currentGoogleUser = user;
    } else if (event case GoogleSignInAuthenticationEventSignOut()) {
      _currentGoogleUser = null;
    }
  }

  /// Sign in with Google (Updated for google_sign_in 7.x)
  Future<AppUser> signInWithGoogle() async {
    try {
      await _initGoogleSignIn();

      // Listen to auth events
      GoogleSignIn.instance.authenticationEvents.listen(_handleAuthEvent);

      // Use authenticate() in v7.x
      final account = await GoogleSignIn.instance.authenticate();
      _currentGoogleUser = account;

      // Request authorization for Firebase
      final authorization = await account.authorizationClient.authorizeScopes([
        'email',
        'profile',
      ]);

      // Create Firebase credential
      final credential = GoogleAuthProvider.credential(
        accessToken: authorization.accessToken,
      );

      final userCredential = await _firebaseAuth.signInWithCredential(
        credential,
      );
      return _mapFirebaseUser(
        userCredential.user!,
        provider: SignInMethod.google,
      );
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseError(e);
    } catch (e) {
      throw AuthException('Đăng nhập Google thất bại: $e');
    }
  }

  /// Sign in with Apple (iOS only)
  Future<AppUser> signInWithApple() async {
    if (!Platform.isIOS && !Platform.isMacOS) {
      throw AuthException('Apple sign-in chỉ khả dụng trên iOS/macOS');
    }

    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oauthCredential = OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      final userCredential = await _firebaseAuth.signInWithCredential(
        oauthCredential,
      );

      // Apple only provides name on first sign-in
      if (appleCredential.givenName != null) {
        final displayName =
            '${appleCredential.givenName} ${appleCredential.familyName ?? ''}'
                .trim();
        await userCredential.user!.updateDisplayName(displayName);
      }

      return _mapFirebaseUser(
        userCredential.user!,
        provider: SignInMethod.apple,
      );
    } on SignInWithAppleAuthorizationException catch (e) {
      throw AuthException('Đăng nhập Apple thất bại: ${e.message}');
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseError(e);
    }
  }

  /// Send password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseError(e);
    }
  }

  /// Sign out
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    if (_googleSignInInitialized) {
      await GoogleSignIn.instance.signOut();
    }
  }

  /// Map Firebase User to AppUser
  AppUser _mapFirebaseUser(User user, {SignInMethod? provider}) {
    return AppUser(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoUrl: user.photoURL,
      phoneNumber: user.phoneNumber,
      isEmailVerified: user.emailVerified,
      provider: provider ?? _detectProvider(user),
      createdAt: user.metadata.creationTime,
      lastLoginAt: user.metadata.lastSignInTime,
    );
  }

  /// Detect auth provider from Firebase user
  SignInMethod _detectProvider(User user) {
    for (final info in user.providerData) {
      if (info.providerId == 'google.com') return SignInMethod.google;
      if (info.providerId == 'apple.com') return SignInMethod.apple;
    }
    return SignInMethod.email;
  }

  /// Map Firebase auth errors to readable messages
  AuthException _mapFirebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return AuthException('Không tìm thấy tài khoản với email này');
      case 'wrong-password':
        return AuthException('Mật khẩu không đúng');
      case 'email-already-in-use':
        return AuthException('Email này đã được sử dụng');
      case 'weak-password':
        return AuthException('Mật khẩu quá yếu');
      case 'invalid-email':
        return AuthException('Email không hợp lệ');
      case 'user-disabled':
        return AuthException('Tài khoản đã bị vô hiệu hóa');
      case 'too-many-requests':
        return AuthException('Quá nhiều yêu cầu. Vui lòng thử lại sau');
      default:
        return AuthException(e.message ?? 'Đã xảy ra lỗi');
    }
  }
}

/// Auth exception class
class AuthException implements Exception {
  AuthException(this.message);
  final String message;

  @override
  String toString() => message;
}
