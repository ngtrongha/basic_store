import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/login_controller.dart';
import '../../l10n/app_localizations.dart';
import '../../router/app_router.dart';

@RoutePage()
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final _usernameFocus = FocusNode();
  final _passwordFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.65, curve: Curves.easeOut),
      ),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.35), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0.0, 0.65, curve: Curves.easeOutCubic),
          ),
        );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _usernameFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final controller = ref.read(loginControllerProvider.notifier);
    final user = await controller.login();

    if (!mounted) return;

    if (user != null) {
      context.router.replaceAll([const DashboardRoute()]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginControllerProvider);
    final controller = ref.read(loginControllerProvider.notifier);
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colorScheme.primary,
              colorScheme.primaryContainer,
              colorScheme.secondary.withOpacity(0.8),
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Logo và Header
                        _buildHeader(colorScheme, l10n),
                        const SizedBox(height: 40),

                        // Card đăng nhập
                        _buildLoginCard(
                          context,
                          state,
                          controller,
                          l10n,
                          colorScheme,
                        ),

                        const SizedBox(height: 24),

                        // Footer
                        _buildFooter(colorScheme),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ColorScheme colorScheme, AppLocalizations l10n) {
    return Column(
      children: [
        // Logo Container
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Icon(
            Icons.store_rounded,
            size: 56,
            color: colorScheme.primary,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Basic Store',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Quản lý cửa hàng thông minh',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white.withOpacity(0.9),
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginCard(
    BuildContext context,
    dynamic state,
    dynamic controller,
    AppLocalizations l10n,
    ColorScheme colorScheme,
  ) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Title
          Text(
            l10n.login,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Đăng nhập để tiếp tục',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),

          // Error message
          if (state.errorMessage != null) ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colorScheme.errorContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.error_outline_rounded,
                    color: colorScheme.error,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      state.errorMessage!,
                      style: TextStyle(
                        color: colorScheme.onErrorContainer,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close_rounded,
                      size: 18,
                      color: colorScheme.onErrorContainer,
                    ),
                    onPressed: () => controller.clearError(),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],

          // Username field
          _buildTextField(
            context: context,
            label: l10n.username,
            icon: Icons.person_outline_rounded,
            value: state.username,
            onChanged: controller.setUsername,
            focusNode: _usernameFocus,
            nextFocus: _passwordFocus,
            colorScheme: colorScheme,
          ),
          const SizedBox(height: 20),

          // Password field
          _buildTextField(
            context: context,
            label: l10n.password,
            icon: Icons.lock_outline_rounded,
            value: state.password,
            onChanged: controller.setPassword,
            isPassword: true,
            isPasswordVisible: state.isPasswordVisible,
            onTogglePassword: controller.togglePasswordVisibility,
            focusNode: _passwordFocus,
            onSubmit: (_) => _handleLogin(),
            colorScheme: colorScheme,
          ),
          const SizedBox(height: 16),

          // Remember me & Forgot password
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 24,
                    width: 24,
                    child: Checkbox(
                      value: state.rememberMe,
                      onChanged: (_) => controller.toggleRememberMe(),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Ghi nhớ đăng nhập',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  // TODO: Implement forgot password
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'Quên mật khẩu?',
                  style: TextStyle(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Login button
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 56,
            child: FilledButton(
              onPressed: state.isLoading ? null : _handleLogin,
              style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: state.isLoading ? 0 : 2,
              ),
              child: state.isLoading
                  ? SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: colorScheme.onPrimary,
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          l10n.loginButton,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.arrow_forward_rounded, size: 20),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required BuildContext context,
    required String label,
    required IconData icon,
    required String value,
    required Function(String) onChanged,
    required ColorScheme colorScheme,
    bool isPassword = false,
    bool isPasswordVisible = false,
    VoidCallback? onTogglePassword,
    FocusNode? focusNode,
    FocusNode? nextFocus,
    Function(String)? onSubmit,
  }) {
    return TextFormField(
      initialValue: value,
      focusNode: focusNode,
      obscureText: isPassword && !isPasswordVisible,
      onChanged: onChanged,
      onFieldSubmitted:
          onSubmit ??
          (_) {
            if (nextFocus != null) {
              nextFocus.requestFocus();
            }
          },
      textInputAction: nextFocus != null
          ? TextInputAction.next
          : TextInputAction.done,
      style: Theme.of(context).textTheme.bodyLarge,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: colorScheme.primary),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  isPasswordVisible
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: colorScheme.onSurfaceVariant,
                ),
                onPressed: onTogglePassword,
              )
            : null,
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest.withOpacity(0.5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: colorScheme.outline.withOpacity(0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: colorScheme.error),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
      ),
    );
  }

  Widget _buildFooter(ColorScheme colorScheme) {
    return Column(
      children: [
        Text(
          '© 2024 Basic Store. All rights reserved.',
          style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildFooterLink('Điều khoản'),
            _buildDot(),
            _buildFooterLink('Bảo mật'),
            _buildDot(),
            _buildFooterLink('Hỗ trợ'),
          ],
        ),
      ],
    );
  }

  Widget _buildFooterLink(String text) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 12),
      ),
    );
  }

  Widget _buildDot() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text('•', style: TextStyle(color: Colors.white.withOpacity(0.7))),
    );
  }
}
