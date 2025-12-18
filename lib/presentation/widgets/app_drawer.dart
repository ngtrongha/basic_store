import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/app/app_info_provider.dart';
import '../../features/dashboard/dashboard_controller.dart';
import '../../features/dashboard/dashboard_state.dart';
import '../../l10n/app_localizations.dart';
import '../../router/app_router.dart';

class AppDrawer extends ConsumerStatefulWidget {
  const AppDrawer({super.key});

  @override
  ConsumerState<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends ConsumerState<AppDrawer> {
  bool _isLoggingOut = false;

  Future<void> _handleLogout(BuildContext context) async {
    if (_isLoggingOut) return;

    setState(() => _isLoggingOut = true);

    try {
      final controller = ref.read(dashboardControllerProvider.notifier);

      // Đóng drawer trước
      Navigator.of(context).pop();

      // Thực hiện logout
      await controller.logout();

      // Navigate to login
      if (mounted) {
        context.router.replaceAll([const LoginRoute()]);
      }
    } finally {
      if (mounted) {
        setState(() => _isLoggingOut = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dashboardControllerProvider);
    final appInfo = ref.watch(appInfoProvider);
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Drawer(
      child: Column(
        children: [
          // Header
          _buildHeader(context, state, colorScheme),

          // Menu Items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const SizedBox(height: 8),

                // Main Section
                _buildSectionTitle('Chính', colorScheme),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.dashboard_outlined,
                  selectedIcon: Icons.dashboard,
                  title: l10n.dashboard,
                  colorScheme: colorScheme,
                  isSelected: true,
                  onTap: () => Navigator.pop(context),
                ),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.point_of_sale_outlined,
                  selectedIcon: Icons.point_of_sale,
                  title: 'Bán hàng (POS)',
                  colorScheme: colorScheme,
                  onTap: () {
                    Navigator.pop(context);
                    context.router.push(const PosRoute());
                  },
                ),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.receipt_long_outlined,
                  selectedIcon: Icons.receipt_long,
                  title: 'Lịch sử đơn hàng',
                  colorScheme: colorScheme,
                  onTap: () {
                    Navigator.pop(context);
                    context.router.push(const OrderHistoryRoute());
                  },
                ),

                const Divider(height: 32),

                // Products Section
                _buildSectionTitle('Sản phẩm & Kho', colorScheme),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.inventory_2_outlined,
                  selectedIcon: Icons.inventory_2,
                  title: 'Sản phẩm',
                  colorScheme: colorScheme,
                  onTap: () {
                    Navigator.pop(context);
                    context.router.push(const ProductListRoute());
                  },
                ),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.warehouse_outlined,
                  selectedIcon: Icons.warehouse,
                  title: 'Kho hàng',
                  colorScheme: colorScheme,
                  badge: state.lowStockCount > 0
                      ? state.lowStockCount.toString()
                      : null,
                  badgeColor: Colors.red,
                  onTap: () {
                    Navigator.pop(context);
                    context.router.push(const InventoryRoute());
                  },
                ),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.swap_horiz_outlined,
                  selectedIcon: Icons.swap_horiz,
                  title: 'Chuyển kho',
                  colorScheme: colorScheme,
                  onTap: () {
                    Navigator.pop(context);
                    context.router.push(StockTransfersRoute());
                  },
                ),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.straighten_outlined,
                  selectedIcon: Icons.straighten,
                  title: 'Đơn vị tính',
                  colorScheme: colorScheme,
                  onTap: () {
                    Navigator.pop(context);
                    context.router.push(const UnitsRoute());
                  },
                ),

                const Divider(height: 32),

                // Partners Section
                _buildSectionTitle('Đối tác', colorScheme),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.people_outline,
                  selectedIcon: Icons.people,
                  title: 'Khách hàng',
                  colorScheme: colorScheme,
                  onTap: () {
                    Navigator.pop(context);
                    context.router.push(const CustomersListRoute());
                  },
                ),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.local_shipping_outlined,
                  selectedIcon: Icons.local_shipping,
                  title: 'Nhà cung cấp',
                  colorScheme: colorScheme,
                  onTap: () {
                    Navigator.pop(context);
                    context.router.push(const SuppliersRoute());
                  },
                ),

                const Divider(height: 32),

                // Reports Section
                _buildSectionTitle('Báo cáo', colorScheme),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.analytics_outlined,
                  selectedIcon: Icons.analytics,
                  title: 'Báo cáo',
                  colorScheme: colorScheme,
                  onTap: () {
                    Navigator.pop(context);
                    context.router.push(const ReportsRoute());
                  },
                ),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.assessment_outlined,
                  selectedIcon: Icons.assessment,
                  title: 'Báo cáo nâng cao',
                  colorScheme: colorScheme,
                  onTap: () {
                    Navigator.pop(context);
                    context.router.push(const AdvancedReportsRoute());
                  },
                ),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.file_download_outlined,
                  selectedIcon: Icons.file_download,
                  title: 'Xuất dữ liệu',
                  colorScheme: colorScheme,
                  onTap: () {
                    Navigator.pop(context);
                    context.router.push(const DataExportRoute());
                  },
                ),

                const Divider(height: 32),

                // System Section
                _buildSectionTitle('Hệ thống', colorScheme),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.store_outlined,
                  selectedIcon: Icons.store,
                  title: 'Cửa hàng',
                  colorScheme: colorScheme,
                  onTap: () {
                    Navigator.pop(context);
                    context.router.push(const StoresRoute());
                  },
                ),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.history_outlined,
                  selectedIcon: Icons.history,
                  title: 'Lịch sử hoạt động',
                  colorScheme: colorScheme,
                  onTap: () {
                    Navigator.pop(context);
                    context.router.push(const AuditLogRoute());
                  },
                ),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.bug_report_outlined,
                  selectedIcon: Icons.bug_report,
                  title: 'Logs',
                  colorScheme: colorScheme,
                  onTap: () {
                    Navigator.pop(context);
                    context.router.push(const TalkerLogsRoute());
                  },
                ),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.settings_outlined,
                  selectedIcon: Icons.settings,
                  title: 'Cài đặt',
                  colorScheme: colorScheme,
                  onTap: () {
                    Navigator.pop(context);
                    context.router.push(const SettingsRoute());
                  },
                ),

                const SizedBox(height: 16),
              ],
            ),
          ),

          // Footer
          _buildFooter(context, appInfo, l10n, colorScheme),
        ],
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    DashboardState state,
    ColorScheme colorScheme,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 24,
        bottom: 24,
        left: 20,
        right: 20,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [colorScheme.primary, colorScheme.primaryContainer],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              Icons.store_rounded,
              size: 36,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 16),
          // App Name
          Text(
            'Basic Store',
            style: TextStyle(
              color: colorScheme.onPrimary,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          // User Info
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: colorScheme.onPrimary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.person, size: 14, color: colorScheme.onPrimary),
                    const SizedBox(width: 4),
                    Text(
                      state.currentUser?.username ?? 'Admin',
                      style: TextStyle(
                        color: colorScheme.onPrimary,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: colorScheme.onPrimary.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  state.currentUser?.role.name.toUpperCase() ?? 'ADMIN',
                  style: TextStyle(
                    color: colorScheme.onPrimary.withOpacity(0.9),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 4),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: colorScheme.onSurfaceVariant,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required BuildContext context,
    required IconData icon,
    required IconData selectedIcon,
    required String title,
    required ColorScheme colorScheme,
    bool isSelected = false,
    String? badge,
    Color? badgeColor,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      child: Material(
        color: isSelected
            ? colorScheme.primaryContainer.withOpacity(0.5)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(
              children: [
                Icon(
                  isSelected ? selectedIcon : icon,
                  size: 22,
                  color: isSelected
                      ? colorScheme.primary
                      : colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w500,
                      color: isSelected
                          ? colorScheme.primary
                          : colorScheme.onSurface,
                    ),
                  ),
                ),
                if (badge != null) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: badgeColor ?? colorScheme.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      badge,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFooter(
    BuildContext context,
    AsyncValue appInfo,
    AppLocalizations l10n,
    ColorScheme colorScheme,
  ) {
    final versionText = appInfo.when(
      data: (info) => 'Version ${info.version} (${info.buildNumber})',
      loading: () => 'Loading...',
      error: (_, __) => 'Version 1.0.0',
    );

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: colorScheme.outlineVariant)),
      ),
      child: Column(
        children: [
          // Version info
          Text(
            versionText,
            style: TextStyle(fontSize: 11, color: colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 12),
          // Logout button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: _isLoggingOut ? null : () => _handleLogout(context),
              icon: _isLoggingOut
                  ? SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: colorScheme.error,
                      ),
                    )
                  : Icon(Icons.logout, color: colorScheme.error),
              label: Text(
                _isLoggingOut ? 'Đang đăng xuất...' : l10n.logout,
                style: TextStyle(color: colorScheme.error),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: colorScheme.error.withOpacity(0.5)),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
