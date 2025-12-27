import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/widgets.dart';
import '../providers/backup_providers.dart';

@RoutePage()
class BackupScreen extends ConsumerWidget {
  const BackupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backupState = ref.watch(backupProvider);
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');

    // Listen for status changes
    ref.listen<BackupState>(backupProvider, (previous, next) {
      if (next.status == BackupStatus.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Thao tác thành công!'),
            backgroundColor: AppColors.success,
          ),
        );
        ref.read(backupProvider.notifier).resetStatus();
      } else if (next.status == BackupStatus.error &&
          next.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Lỗi: ${next.errorMessage}'),
            backgroundColor: AppColors.error,
          ),
        );
        ref.read(backupProvider.notifier).resetStatus();
      }
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Sao lưu & Khôi phục')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Backup status card
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.backup_outlined,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Sao lưu dữ liệu',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              backupState.lastBackupTime != null
                                  ? 'Lần cuối: ${dateFormat.format(backupState.lastBackupTime!)}'
                                  : 'Chưa có bản sao lưu',
                              style: const TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Sao lưu dữ liệu sản phẩm, khách hàng, đơn hàng và công nợ vào file local.',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 16),
                  AppButton(
                    text: 'Sao lưu ngay',
                    onPressed: backupState.status == BackupStatus.backing
                        ? null
                        : () =>
                              ref.read(backupProvider.notifier).createBackup(),
                    isLoading: backupState.status == BackupStatus.backing,
                    width: double.infinity,
                    icon: Icons.cloud_upload_outlined,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Restore card
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.warning.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.restore_outlined,
                          color: AppColors.warning,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Khôi phục dữ liệu',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              backupState.hasLocalBackup
                                  ? 'Có bản sao lưu'
                                  : 'Không có bản sao lưu',
                              style: TextStyle(
                                color: backupState.hasLocalBackup
                                    ? AppColors.success
                                    : AppColors.textSecondary,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Khôi phục dữ liệu từ bản sao lưu. Lưu ý: Dữ liệu hiện tại sẽ bị ghi đè.',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 16),
                  AppButton(
                    text: 'Khôi phục',
                    onPressed:
                        !backupState.hasLocalBackup ||
                            backupState.status == BackupStatus.restoring
                        ? null
                        : () => _confirmRestore(context, ref),
                    isLoading: backupState.status == BackupStatus.restoring,
                    isOutlined: true,
                    width: double.infinity,
                    icon: Icons.cloud_download_outlined,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Info section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.info.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.info.withValues(alpha: 0.3),
                ),
              ),
              child: const Row(
                children: [
                  Icon(Icons.info_outline, color: AppColors.info),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Tính năng sao lưu lên Google Drive sẽ được cập nhật trong phiên bản sau.',
                      style: TextStyle(color: AppColors.info, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmRestore(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xác nhận khôi phục'),
        content: const Text(
          'Dữ liệu hiện tại sẽ bị xóa và thay thế bằng dữ liệu từ bản sao lưu. Bạn có chắc chắn?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ref.read(backupProvider.notifier).restoreBackup();
            },
            child: const Text(
              'Khôi phục',
              style: TextStyle(color: AppColors.warning),
            ),
          ),
        ],
      ),
    );
  }
}
