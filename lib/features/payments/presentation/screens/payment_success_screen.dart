import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/widgets.dart';
import '../providers/payment_providers.dart';

@RoutePage()
class PaymentSuccessScreen extends ConsumerWidget {
  const PaymentSuccessScreen({super.key, this.amount = 0});

  final double amount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Success animation/icon
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle,
                  size: 80,
                  color: AppColors.success,
                ),
              ),

              const SizedBox(height: 32),

              const Text(
                'Thanh toán thành công!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),

              const SizedBox(height: 16),

              if (amount > 0) ...[
                Text(
                  currencyFormat.format(amount),
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now()),
                  style: const TextStyle(color: AppColors.textSecondary),
                ),
              ],

              const SizedBox(height: 48),

              // Action buttons
              AppButton(
                text: 'In hóa đơn',
                onPressed: () {
                  // TODO: Implement print receipt
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Tính năng in hóa đơn sẽ được thêm sau'),
                    ),
                  );
                },
                isOutlined: true,
                width: double.infinity,
                icon: Icons.print,
              ),

              const SizedBox(height: 12),

              AppButton(
                text: 'Hoàn tất',
                onPressed: () {
                  // Clear payment state
                  ref.read(paymentAmountProvider.notifier).clear();
                  ref.read(paymentStatusProvider.notifier).reset();
                  // Go back to dashboard
                  context.router.popUntilRoot();
                },
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
