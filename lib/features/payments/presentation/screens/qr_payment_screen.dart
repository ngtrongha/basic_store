import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:basic_store/app/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/widgets.dart';
import '../providers/payment_providers.dart';

@RoutePage()
class QrPaymentScreen extends ConsumerStatefulWidget {
  const QrPaymentScreen({super.key, this.amount});

  final double? amount;

  @override
  ConsumerState<QrPaymentScreen> createState() => _QrPaymentScreenState();
}

class _QrPaymentScreenState extends ConsumerState<QrPaymentScreen> {
  final _currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');

  @override
  void initState() {
    super.initState();
    if (widget.amount != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(paymentAmountProvider.notifier).setAmount(widget.amount!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final qrImagePath = ref.watch(qrPaymentSettingsProvider);
    final paymentAmount = ref.watch(paymentAmountProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Thanh toán QR'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: _showQrSettings,
            tooltip: 'Cài đặt QR',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Amount display
            if (paymentAmount > 0) ...[
              AppCard(
                child: Column(
                  children: [
                    const Text(
                      'Số tiền thanh toán',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _currencyFormat.format(paymentAmount),
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],

            // QR Code display
            if (qrImagePath != null && qrImagePath.isNotEmpty) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    File(qrImagePath),
                    width: 280,
                    height: 280,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => Container(
                      width: 280,
                      height: 280,
                      color: AppColors.surfaceLight,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 48,
                            color: AppColors.error,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Không thể tải ảnh QR',
                            style: TextStyle(color: AppColors.error),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Quét mã QR để thanh toán',
                style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
              ),
            ] else ...[
              // No QR code set
              _buildNoQrState(),
            ],

            const SizedBox(height: 32),

            // Confirm payment button
            if (qrImagePath != null && qrImagePath.isNotEmpty)
              AppButton(
                text: 'Xác nhận đã thanh toán',
                onPressed: _confirmPayment,
                width: double.infinity,
                icon: Icons.check,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoQrState() {
    return AppCard(
      child: Column(
        children: [
          const Icon(Icons.qr_code_2, size: 80, color: AppColors.textSecondary),
          const SizedBox(height: 16),
          const Text(
            'Chưa có mã QR thanh toán',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Thêm ảnh QR code để nhận thanh toán',
            style: TextStyle(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          AppButton(
            text: 'Thêm ảnh QR',
            onPressed: _pickQrImage,
            icon: Icons.add_photo_alternate,
          ),
        ],
      ),
    );
  }

  Future<void> _pickQrImage() async {
    final picker = ImagePicker();
    final result = await picker.pickImage(source: ImageSource.gallery);
    if (result != null) {
      await ref
          .read(qrPaymentSettingsProvider.notifier)
          .setQrImagePath(result.path);
    }
  }

  void _showQrSettings() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Cài đặt QR thanh toán',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('Thay đổi ảnh QR'),
              onTap: () {
                Navigator.pop(context);
                _pickQrImage();
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline, color: AppColors.error),
              title: const Text(
                'Xóa ảnh QR',
                style: TextStyle(color: AppColors.error),
              ),
              onTap: () async {
                Navigator.pop(context);
                await ref
                    .read(qrPaymentSettingsProvider.notifier)
                    .clearQrImage();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _confirmPayment() {
    context.router.push(
      PaymentSuccessRoute(amount: ref.read(paymentAmountProvider)),
    );
  }
}
