import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/widgets.dart';
import '../../../customers/presentation/providers/customer_providers.dart';
import '../providers/debt_providers.dart';

@RoutePage()
class DebtListScreen extends ConsumerStatefulWidget {
  const DebtListScreen({super.key});

  @override
  ConsumerState<DebtListScreen> createState() => _DebtListScreenState();
}

class _DebtListScreenState extends ConsumerState<DebtListScreen> {
  final _currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');

  @override
  Widget build(BuildContext context) {
    final debtsAsync = ref.watch(debtsProvider);
    final showUnpaidOnly = ref.watch(showUnpaidOnlyProvider);
    final totalUnpaidAsync = ref.watch(totalUnpaidDebtProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Công nợ'),
        actions: [
          IconButton(
            icon: Icon(
              showUnpaidOnly ? Icons.filter_alt : Icons.filter_alt_outlined,
              color: showUnpaidOnly ? AppColors.warning : null,
            ),
            onPressed: () {
              ref.read(showUnpaidOnlyProvider.notifier).toggle();
              if (ref.read(showUnpaidOnlyProvider)) {
                ref.read(debtsProvider.notifier).loadUnpaidOnly();
              } else {
                ref.read(debtsProvider.notifier).refresh();
              }
            },
            tooltip: 'Chỉ hiện chưa thanh toán',
          ),
        ],
      ),
      body: Column(
        children: [
          // Total unpaid summary
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.warning,
                  AppColors.warning.withValues(alpha: 0.8),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.account_balance_wallet,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Tổng công nợ',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      const SizedBox(height: 4),
                      totalUnpaidAsync.when(
                        data: (total) => Text(
                          _currencyFormat.format(total),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        loading: () => const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                        error: (_, __) => const Text(
                          '---',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Debt list
          Expanded(
            child: debtsAsync.when(
              data: (debts) {
                if (debts.isEmpty) {
                  return _buildEmptyState();
                }
                return RefreshIndicator(
                  onRefresh: () async {
                    await ref.read(debtsProvider.notifier).refresh();
                    await ref.read(totalUnpaidDebtProvider.notifier).refresh();
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: debts.length,
                    itemBuilder: (context, index) {
                      final debt = debts[index];
                      return _DebtCard(
                        debt: debt,
                        currencyFormat: _currencyFormat,
                        onTap: () => _showPaymentDialog(debt),
                      );
                    },
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(child: Text('Lỗi: $error')),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.check_circle_outline, size: 80, color: AppColors.success),
          const SizedBox(height: 16),
          const Text(
            'Không có công nợ',
            style: TextStyle(fontSize: 18, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  void _showPaymentDialog(Debt debt) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ghi nhận thanh toán'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Số tiền còn nợ: ${_currencyFormat.format(debt.remainingAmount)}',
              style: const TextStyle(color: AppColors.warning),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Số tiền thanh toán',
                suffix: Text('₫'),
              ),
              autofocus: true,
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {
                controller.text = debt.remainingAmount.toStringAsFixed(0);
              },
              child: const Text('Thanh toán toàn bộ'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () async {
              final amount = double.tryParse(controller.text) ?? 0;
              if (amount <= 0) return;

              Navigator.pop(context);

              try {
                await ref
                    .read(debtDaoProvider)
                    .recordPayment(debtId: debt.id, amount: amount);

                ref.read(debtsProvider.notifier).refresh();
                ref.read(totalUnpaidDebtProvider.notifier).refresh();
                ref.read(customersProvider.notifier).refresh();

                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Đã ghi nhận ${_currencyFormat.format(amount)}',
                      ),
                      backgroundColor: AppColors.success,
                    ),
                  );
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Lỗi: $e'),
                      backgroundColor: AppColors.error,
                    ),
                  );
                }
              }
            },
            child: const Text('Thanh toán'),
          ),
        ],
      ),
    );
  }
}

class _DebtCard extends ConsumerWidget {
  const _DebtCard({
    required this.debt,
    required this.currencyFormat,
    required this.onTap,
  });

  final Debt debt;
  final NumberFormat currencyFormat;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customersAsync = ref.watch(customersProvider);

    return AppCard(
      margin: const EdgeInsets.only(bottom: 12),
      onTap: debt.isPaid ? null : onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Customer avatar
              CircleAvatar(
                radius: 20,
                backgroundColor: debt.isPaid
                    ? AppColors.success.withValues(alpha: 0.2)
                    : AppColors.warning.withValues(alpha: 0.2),
                child: customersAsync.when(
                  data: (customers) {
                    final customer = customers.cast<Customer?>().firstWhere(
                      (c) => c?.id == debt.customerId,
                      orElse: () => null,
                    );
                    return Text(
                      customer?.name.isNotEmpty == true
                          ? customer!.name[0].toUpperCase()
                          : '?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: debt.isPaid
                            ? AppColors.success
                            : AppColors.warning,
                      ),
                    );
                  },
                  loading: () => const Text('...'),
                  error: (_, __) => const Text('?'),
                ),
              ),
              const SizedBox(width: 12),

              // Customer name and debt info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customersAsync.when(
                      data: (customers) {
                        final customer = customers.cast<Customer?>().firstWhere(
                          (c) => c?.id == debt.customerId,
                          orElse: () => null,
                        );
                        return Text(
                          customer?.name ?? 'Khách hàng #${debt.customerId}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        );
                      },
                      loading: () => const Text('Đang tải...'),
                      error: (_, __) => Text('Khách hàng #${debt.customerId}'),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      DateFormat('dd/MM/yyyy HH:mm').format(debt.createdAt),
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              // Status badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: debt.isPaid
                      ? AppColors.success.withValues(alpha: 0.2)
                      : AppColors.warning.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  debt.isPaid ? 'Đã thanh toán' : 'Còn nợ',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: debt.isPaid ? AppColors.success : AppColors.warning,
                  ),
                ),
              ),
            ],
          ),

          const Divider(height: 24),

          // Amount details
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tổng nợ',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Text(
                    currencyFormat.format(debt.amount),
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Đã trả',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Text(
                    currencyFormat.format(debt.paidAmount),
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.success,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Còn lại',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Text(
                    currencyFormat.format(debt.remainingAmount),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: debt.remainingAmount > 0
                          ? AppColors.warning
                          : AppColors.success,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Note if exists
          if (debt.note != null && debt.note!.isNotEmpty) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(
                  Icons.note_outlined,
                  size: 14,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    debt.note!,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
