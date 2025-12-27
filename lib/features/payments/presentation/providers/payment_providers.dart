import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// QR Payment settings provider (stores QR code image path)
class QrPaymentSettingsNotifier extends Notifier<String?> {
  static const _qrImagePathKey = 'qr_payment_image_path';

  @override
  String? build() {
    _loadSavedPath();
    return null;
  }

  Future<void> _loadSavedPath() async {
    final prefs = await SharedPreferences.getInstance();
    final savedPath = prefs.getString(_qrImagePathKey);
    state = savedPath;
  }

  Future<void> setQrImagePath(String path) async {
    state = path;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_qrImagePathKey, path);
  }

  Future<void> clearQrImage() async {
    state = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_qrImagePathKey);
  }
}

/// QR Payment settings provider
final qrPaymentSettingsProvider =
    NotifierProvider<QrPaymentSettingsNotifier, String?>(
      QrPaymentSettingsNotifier.new,
    );

/// Payment amount notifier (Riverpod 3.0 pattern)
class PaymentAmountNotifier extends Notifier<double> {
  @override
  double build() => 0;

  void setAmount(double amount) => state = amount;
  void clear() => state = 0;
}

/// Payment amount provider
final paymentAmountProvider = NotifierProvider<PaymentAmountNotifier, double>(
  PaymentAmountNotifier.new,
);

/// Payment status notifier (Riverpod 3.0 pattern)
class PaymentStatusNotifier extends Notifier<PaymentStatus> {
  @override
  PaymentStatus build() => PaymentStatus.idle;

  void setStatus(PaymentStatus status) => state = status;
  void reset() => state = PaymentStatus.idle;
}

/// Payment status provider
final paymentStatusProvider =
    NotifierProvider<PaymentStatusNotifier, PaymentStatus>(
      PaymentStatusNotifier.new,
    );

enum PaymentStatus { idle, processing, success, failed }
