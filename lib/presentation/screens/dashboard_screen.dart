import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/customer.dart';
import '../../data/models/product.dart';
import '../../data/repositories/product_unit_repository.dart';
import '../../data/services/recent_service.dart';
import '../../features/dashboard/dashboard_controller.dart';
import '../../features/dashboard/dashboard_state.dart';
import '../../features/pos/pos_controller.dart';
import '../../features/voice/voice_order_matcher.dart';
import '../../features/voice/voice_order_parser.dart';
import '../../l10n/app_localizations.dart';
import '../../router/app_router.dart';
import '../widgets/app_drawer.dart';
import '../widgets/voice_input_sheet.dart';

@RoutePage()
class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dashboardControllerProvider);
    final controller = ref.read(dashboardControllerProvider.notifier);
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: controller.refresh,
        child: CustomScrollView(
          slivers: [
            // App Bar
            _buildAppBar(context, state, controller, l10n, colorScheme),

            // Content
            if (state.isLoading)
              SliverFillRemaining(child: _buildLoadingState(colorScheme))
            else
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    _buildContent(context, state, l10n, colorScheme),
                  ]),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: _buildVoiceFab(context, colorScheme),
    );
  }

  Widget _buildAppBar(
    BuildContext context,
    DashboardState state,
    DashboardController controller,
    AppLocalizations l10n,
    ColorScheme colorScheme,
  ) {
    return SliverAppBar(
      expandedHeight: 160,
      floating: false,
      pinned: true,
      elevation: 0,
      backgroundColor: colorScheme.primary,
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(Icons.menu_rounded, color: colorScheme.onPrimary),
          onPressed: () => Scaffold.of(context).openDrawer(),
          tooltip: 'Menu',
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [colorScheme.primary, colorScheme.primaryContainer],
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(56, 16, 56, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Xin chào, ${state.currentUser?.username ?? 'Admin'}! 👋',
                    style: TextStyle(
                      color: colorScheme.onPrimary,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _getGreeting(),
                    style: TextStyle(
                      color: colorScheme.onPrimary.withOpacity(0.85),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      actions: [_buildUserMenu(context, state, controller, l10n, colorScheme)],
    );
  }

  Widget _buildUserMenu(
    BuildContext context,
    DashboardState state,
    DashboardController controller,
    AppLocalizations l10n,
    ColorScheme colorScheme,
  ) {
    return PopupMenuButton<String>(
      icon: CircleAvatar(
        backgroundColor: colorScheme.onPrimary.withOpacity(0.2),
        child: Text(
          state.currentUser?.username.substring(0, 1).toUpperCase() ?? '?',
          style: TextStyle(
            color: colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      onSelected: (value) async {
        if (value == 'logout') {
          await controller.logout();
          if (mounted) {
            context.router.replaceAll([const LoginRoute()]);
          }
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          enabled: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                state.currentUser?.username ?? 'Unknown',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                state.currentUser?.role.name ?? '',
                style: TextStyle(
                  fontSize: 12,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem(
          value: 'logout',
          child: Row(
            children: [
              Icon(Icons.logout, color: colorScheme.error),
              const SizedBox(width: 12),
              Text(l10n.logout),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingState(ColorScheme colorScheme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: colorScheme.primary),
          const SizedBox(height: 16),
          Text(
            'Đang tải dữ liệu...',
            style: TextStyle(color: colorScheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    DashboardState state,
    AppLocalizations l10n,
    ColorScheme colorScheme,
  ) {
    return FadeTransition(
      opacity: _animationController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Quick Actions (đưa lên đầu)
          _buildSectionHeader('Truy cập nhanh', null, colorScheme),
          const SizedBox(height: 12),
          _buildQuickActions(context, l10n, colorScheme),
          const SizedBox(height: 24),

          // Overview Stats (bao gồm cả doanh thu hôm nay)
          _buildSectionHeader(
            'Tổng quan',
            () => context.router.push(const ReportsRoute()),
            colorScheme,
          ),
          const SizedBox(height: 12),
          _buildStatsGrid(context, state, l10n, colorScheme),
          const SizedBox(height: 24),

          // Best Selling Products
          if (state.bestSellingProducts.isNotEmpty) ...[
            _buildSectionHeader(
              'Sản phẩm bán chạy',
              () => context.router.push(const ProductListRoute()),
              colorScheme,
            ),
            const SizedBox(height: 12),
            _buildBestSellingList(state.bestSellingProducts, colorScheme),
            const SizedBox(height: 24),
          ],

          // Low Stock Products
          if (state.lowStockProducts.isNotEmpty) ...[
            _buildSectionHeader(
              'Sắp hết hàng',
              () => context.router.push(const InventoryRoute()),
              colorScheme,
              badgeCount: state.lowStockCount,
            ),
            const SizedBox(height: 12),
            _buildLowStockList(state.lowStockProducts, colorScheme),
            const SizedBox(height: 24),
          ],

          // Recent Products
          if (state.recentProducts.isNotEmpty) ...[
            _buildSectionHeader(
              'Sản phẩm mới thêm',
              () => context.router.push(const ProductListRoute()),
              colorScheme,
            ),
            const SizedBox(height: 12),
            _buildRecentProductsList(state.recentProducts, colorScheme),
            const SizedBox(height: 24),
          ],
        ],
      ),
    );
  }

  Widget _buildSectionHeader(
    String title,
    VoidCallback? onViewAll,
    ColorScheme colorScheme, {
    int? badgeCount,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            if (badgeCount != null && badgeCount > 0) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  badgeCount.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
        if (onViewAll != null)
          TextButton(onPressed: onViewAll, child: const Text('Xem tất cả')),
      ],
    );
  }

  Widget _buildStatsGrid(
    BuildContext context,
    DashboardState state,
    AppLocalizations l10n,
    ColorScheme colorScheme,
  ) {
    return Column(
      children: [
        // Revenue Summary Card
        _buildRevenueSummaryCard(context, state, l10n, colorScheme),
        const SizedBox(height: 16),

        // Stats Row
        Row(
          children: [
            Expanded(
              child: _buildStatTile(
                context,
                l10n.totalProducts,
                state.totalProducts.toString(),
                Icons.inventory_2_rounded,
                Colors.blue,
                colorScheme,
                onTap: () => context.router.push(const ProductListRoute()),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatTile(
                context,
                l10n.totalOrders,
                state.totalOrders.toString(),
                Icons.receipt_long_rounded,
                Colors.green,
                colorScheme,
                onTap: () => context.router.push(const OrderHistoryRoute()),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildStatTile(
                context,
                'Khách hàng',
                state.totalCustomers.toString(),
                Icons.people_rounded,
                Colors.purple,
                colorScheme,
                onTap: () => context.router.push(const CustomersListRoute()),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatTile(
                context,
                l10n.lowStock,
                state.lowStockCount.toString(),
                Icons.warning_amber_rounded,
                Colors.red,
                colorScheme,
                showBadge: state.lowStockCount > 0,
                onTap: () => context.router.push(const InventoryRoute()),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRevenueSummaryCard(
    BuildContext context,
    DashboardState state,
    AppLocalizations l10n,
    ColorScheme colorScheme,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.primary,
            colorScheme.primary.withOpacity(0.8),
            colorScheme.secondary.withOpacity(0.7),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tổng doanh thu',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _formatFullCurrency(state.totalRevenue),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.account_balance_wallet_rounded,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _buildSummaryItem(
                    'Hôm nay',
                    _formatFullCurrency(state.todayRevenue),
                    Icons.today_rounded,
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: Colors.white.withOpacity(0.3),
                ),
                Expanded(
                  child: _buildSummaryItem(
                    'Đơn hôm nay',
                    state.todayOrders.toString(),
                    Icons.shopping_cart_rounded,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value, IconData icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.white.withOpacity(0.9), size: 20),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 11,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatTile(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
    ColorScheme colorScheme, {
    bool showBadge = false,
    VoidCallback? onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: colorScheme.outlineVariant.withOpacity(0.5),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(icon, color: color, size: 24),
                  ),
                  if (showBadge)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Theme.of(context).cardColor,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      value,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 12,
                        color: colorScheme.onSurfaceVariant,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: colorScheme.onSurfaceVariant.withOpacity(0.5),
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBestSellingList(
    List<ProductSalesInfo> products,
    ColorScheme colorScheme,
  ) {
    return SizedBox(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          final item = products[index];
          return Container(
            width: 130,
            margin: EdgeInsets.only(
              right: index < products.length - 1 ? 12 : 0,
            ),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: colorScheme.outlineVariant.withOpacity(0.5),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.trending_up,
                    color: Colors.green,
                    size: 20,
                  ),
                ),
                const Spacer(),
                Text(
                  item.product.name,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  'Đã bán: ${item.soldQuantity}',
                  style: TextStyle(
                    fontSize: 11,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLowStockList(List<Product> products, ColorScheme colorScheme) {
    return SizedBox(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Container(
            width: 130,
            margin: EdgeInsets.only(
              right: index < products.length - 1 ? 12 : 0,
            ),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.red.withOpacity(0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.warning_amber,
                    color: Colors.red,
                    size: 20,
                  ),
                ),
                const Spacer(),
                Text(
                  product.name,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  'Còn: ${product.stock}',
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildRecentProductsList(
    List<Product> products,
    ColorScheme colorScheme,
  ) {
    return SizedBox(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Container(
            width: 130,
            margin: EdgeInsets.only(
              right: index < products.length - 1 ? 12 : 0,
            ),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: colorScheme.outlineVariant.withOpacity(0.5),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.new_releases,
                    color: Colors.blue,
                    size: 20,
                  ),
                ),
                const Spacer(),
                Text(
                  product.name,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  _formatPrice(product.salePrice),
                  style: TextStyle(
                    fontSize: 11,
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildQuickActions(
    BuildContext context,
    AppLocalizations l10n,
    ColorScheme colorScheme,
  ) {
    final actions = [
      _ActionItem(
        title: 'Bán hàng',
        icon: Icons.point_of_sale,
        color: colorScheme.primary,
        route: const PosRoute(),
      ),
      _ActionItem(
        title: 'Sản phẩm',
        icon: Icons.inventory_2,
        color: Colors.blue,
        route: const ProductListRoute(),
      ),
      _ActionItem(
        title: 'Kho hàng',
        icon: Icons.warehouse,
        color: Colors.orange,
        route: const InventoryRoute(),
      ),
      _ActionItem(
        title: 'Báo cáo',
        icon: Icons.analytics,
        color: Colors.green,
        route: const ReportsRoute(),
      ),
      _ActionItem(
        title: 'Cài đặt',
        icon: Icons.settings,
        color: Colors.grey,
        route: const SettingsRoute(),
      ),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: actions.map((action) {
        return _buildActionButton(
          context,
          action.title,
          action.icon,
          action.color,
          colorScheme,
          onTap: () => context.router.push(action.route),
        );
      }).toList(),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    ColorScheme colorScheme, {
    VoidCallback? onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: SizedBox(
          width: 65,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: color.withOpacity(0.2)),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Chúc bạn buổi sáng tốt lành!';
    } else if (hour < 18) {
      return 'Chúc bạn buổi chiều vui vẻ!';
    } else {
      return 'Chúc bạn buổi tối an lành!';
    }
  }

  String _formatFullCurrency(double amount) {
    final formatted = amount
        .toStringAsFixed(0)
        .replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        );
    return '$formatted đ';
  }

  String _formatPrice(double price) {
    if (price >= 1000000) {
      return '${(price / 1000000).toStringAsFixed(1)}M đ';
    } else if (price >= 1000) {
      return '${(price / 1000).toStringAsFixed(0)}K đ';
    }
    return '${price.toStringAsFixed(0)} đ';
  }

  // ============ Voice Input ============

  Widget _buildVoiceFab(BuildContext context, ColorScheme colorScheme) {
    return FloatingActionButton.extended(
      heroTag: 'voice_dashboard',
      onPressed: () => _showVoiceInput(context),
      backgroundColor: colorScheme.primaryContainer,
      foregroundColor: colorScheme.onPrimaryContainer,
      icon: const Icon(Icons.mic_rounded),
      label: const Text('Tạo đơn'),
    );
  }

  Future<void> _showVoiceInput(BuildContext context) async {
    final text = await showModalBottomSheet<String?>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const VoiceInputSheet(),
    );

    final spoken = text?.trim();
    if (spoken == null || spoken.isEmpty) return;
    if (!mounted) return;

    await _processVoiceCommand(context, spoken);
  }

  Future<void> _processVoiceCommand(BuildContext context, String spoken) async {
    final colorScheme = Theme.of(context).colorScheme;

    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(color: colorScheme.primary),
            const SizedBox(width: 20),
            const Expanded(child: Text('Đang xử lý đơn hàng...')),
          ],
        ),
      ),
    );

    try {
      final cmd = VoiceOrderParser.parse(spoken);
      if (cmd.lines.isEmpty) {
        if (!mounted) return;
        Navigator.pop(context); // Close loading
        _showErrorSnackbar(context, 'Không nhận diện được sản phẩm');
        return;
      }

      final matcher = VoiceOrderMatcher();
      final productUnitRepo = ProductUnitRepository();
      final posNotifier = ref.read(posControllerProvider.notifier);

      // Clear current cart first
      posNotifier.clearCart();

      // Set customer if found
      Customer? customer;
      final customerName = cmd.customerName?.trim();
      if (customerName != null && customerName.isNotEmpty) {
        customer = await matcher.findOrCreateCustomer(customerName);
        if (!mounted) return;
        posNotifier.setCustomer(customer);
      }

      var added = 0;
      final notFound = <String>[];

      for (final line in cmd.lines) {
        final match = await matcher.matchProduct(
          phrase: line.productPhrase,
          unit: line.unit,
        );

        Product? product = match.product;

        // If no exact match but has candidates, pick the best one
        if (product == null && match.candidates.isNotEmpty) {
          // Auto-select the best candidate (highest score)
          product = match.candidates.first.product;
          await matcher.rememberProductAlias(
            phrase: line.productPhrase,
            unit: line.unit,
            product: product,
          );
        }

        if (product == null) {
          notFound.add(line.productPhrase);
          continue;
        }

        ProductUnitWithUnit? unitInfo;
        final rawUnit = line.unit?.trim();
        if (rawUnit != null && rawUnit.isNotEmpty) {
          unitInfo = await productUnitRepo.findByProductAndUnitKey(
            productId: product.id,
            unitKey: rawUnit,
          );
        }
        unitInfo ??= await productUnitRepo.getDefaultByProductWithUnit(
          product.id,
        );

        final unitId = unitInfo?.productUnit.unitId;
        final unitFactor = unitInfo?.productUnit.factor;
        final unitName = unitInfo?.unit.name;
        final unitPrice = unitInfo == null
            ? null
            : (unitInfo.productUnit.priceOverride ??
                  (product.salePrice * unitInfo.productUnit.factor));

        await posNotifier.addProductWithQuantity(
          product,
          line.quantity,
          unitId: unitId,
          unitFactor: unitFactor,
          unitName: unitName,
          unitPrice: unitPrice,
        );
        await RecentService.pushRecentSku(product.sku);
        added++;
      }

      if (!mounted) return;
      Navigator.pop(context); // Close loading

      if (added == 0) {
        _showErrorSnackbar(
          context,
          'Không tìm thấy sản phẩm: ${notFound.join(", ")}',
        );
        return;
      }

      // Show success and navigate to POS
      final customerLabel = customer == null ? '' : ' cho ${customer.name}';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle_rounded, color: Colors.white),
              const SizedBox(width: 8),
              Expanded(child: Text('Đã tạo đơn $added sản phẩm$customerLabel')),
            ],
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          duration: const Duration(seconds: 2),
        ),
      );

      // Navigate to POS screen
      context.router.push(const PosRoute());
    } catch (e) {
      if (!mounted) return;
      Navigator.pop(context); // Close loading
      _showErrorSnackbar(context, 'Lỗi xử lý: $e');
    }
  }

  void _showErrorSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline_rounded, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}

class _ActionItem {
  final String title;
  final IconData icon;
  final Color color;
  final PageRouteInfo route;

  _ActionItem({
    required this.title,
    required this.icon,
    required this.color,
    required this.route,
  });
}
