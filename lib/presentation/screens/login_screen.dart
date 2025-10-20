import 'package:flutter/material.dart';

import '../../data/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _userCtrl = TextEditingController(text: 'admin');
  final _passCtrl = TextEditingController(text: 'admin');
  bool _loading = false;

  @override
  void dispose() {
    _userCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    setState(() => _loading = true);
    try {
      final user = await AuthService().login(
        _userCtrl.text.trim(),
        _passCtrl.text,
      );
      if (!mounted) return;
      if (user == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Sai tài khoản/mật khẩu')));
      } else {
        Navigator.of(context).pushReplacementNamed('/');
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Đăng nhập')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _userCtrl,
              decoration: const InputDecoration(
                labelText: 'Tài khoản',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _passCtrl,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Mật khẩu',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _loading ? null : _login,
                child: _loading
                    ? const CircularProgressIndicator()
                    : const Text('Đăng nhập'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
