import 'package:auto_route/auto_route.dart';
import 'package:basic_store/data/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/audit_log.dart';
import '../../data/models/customer.dart';
import '../../data/models/order.dart';
import '../../data/models/payment.dart';
import '../../data/models/promotion.dart';
import '../../data/repositories/audit_log_repository.dart';
import '../../data/repositories/customer_repository.dart';
import '../../data/repositories/order_repository.dart';
import '../../data/repositories/payment_repository.dart';
import '../../data/repositories/product_repository.dart';
import '../../data/repositories/product_unit_repository.dart';
import '../../data/services/auth_service.dart';
import '../../data/services/invoice_service.dart';
import '../../data/services/recent_service.dart';
import '../../features/pos/pos_controller.dart';
import '../../features/voice/voice_order_matcher.dart';
import '../../features/voice/voice_order_parser.dart';
import '../../l10n/app_localizations.dart';
import '../../router/app_router.dart';
import '../dialogs/checkout_dialog.dart';
import '../widgets/voice_input_sheet.dart';

@RoutePage()
class PosScreen extends ConsumerStatefulWidget {
  const PosScreen({super.key});

  @override
  ConsumerState<PosScreen> createState() => _PosScreenState();
}

class _PosScreenState extends ConsumerState<PosScreen>
    with SingleTickerProviderStateMixin {
  final _skuController = TextEditingController();
  final _couponController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _skuController.dispose();
    _couponController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(posControllerProvider);
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: CustomScrollView(
          slivers: [
            _buildAppBar(context, state, l10n, colorScheme),
            SliverToBoxAdapter(
              child: _buildInputSection(context, state, l10n, colorScheme),
            ),
            SliverToBoxAdapter(child: _buildRecentSkus(context, colorScheme)),
            SliverToBoxAdapter(
              child: _buildCustomerSection(context, state, colorScheme),
            ),
            _buildCartItems(context, state, l10n, colorScheme),
            SliverToBoxAdapter(
              child: _buildSummary(context, state, l10n, colorScheme),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(context, state, l10n, colorScheme),
      floatingActionButton: FloatingActionButton(
        heroTag: 'voice',
        onPressed: () => _showVoiceInput(context),
        backgroundColor: colorScheme.secondaryContainer,
        foregroundColor: colorScheme.onSecondaryContainer,
        child: const Icon(Icons.mic_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildAppBar(
    BuildContext context,
    dynamic state,
    AppLocalizations l10n,
    ColorScheme colorScheme,
  ) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      expandedHeight: 80,
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.point_of_sale_rounded, size: 24),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.pos,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${state.cartItems.length} sản phẩm',
                style: TextStyle(
                  fontSize: 12,
                  color: colorScheme.onPrimary.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.picture_as_pdf_rounded),
          tooltip: 'Xuất hóa đơn',
          onPressed: () => _exportInvoice(context, state),
        ),
        IconButton(
          icon: const Icon(Icons.person_add_alt_1_rounded),
          tooltip: l10n.selectCustomer,
          onPressed: () => _selectCustomer(context),
        ),
        const SizedBox(width: 8),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [colorScheme.primary, colorScheme.primaryContainer],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputSection(
    BuildContext context,
    dynamic state,
    AppLocalizations l10n,
    ColorScheme colorScheme,
  ) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SKU Input
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _skuController,
                  decoration: InputDecoration(
                    hintText: 'Nhập mã SKU / Barcode',
                    prefixIcon: Icon(
                      Icons.qr_code_2_rounded,
                      color: colorScheme.primary,
                    ),
                    filled: true,
                    fillColor: colorScheme.surfaceContainerHighest.withOpacity(
                      0.5,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                  onSubmitted: (sku) => _addBySku(context, sku),
                ),
              ),
              const SizedBox(width: 12),
              _buildIconButton(
                icon: Icons.qr_code_scanner_rounded,
                color: colorScheme.primary,
                onPressed: () => _scanBarcode(context),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Coupon Input
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _couponController,
                  decoration: InputDecoration(
                    hintText: l10n.couponCode,
                    prefixIcon: Icon(
                      Icons.local_offer_rounded,
                      color: Colors.orange,
                    ),
                    suffixIcon: state.couponCode != null
                        ? IconButton(
                            icon: const Icon(Icons.close_rounded, size: 20),
                            onPressed: () {
                              _couponController.clear();
                              ref
                                  .read(posControllerProvider.notifier)
                                  .clearCoupon();
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: colorScheme.surfaceContainerHighest.withOpacity(
                      0.5,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                  onSubmitted: (code) => _applyCoupon(context, code),
                ),
              ),
              if (state.couponCode != null) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        state.couponCode!,
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentSkus(BuildContext context, ColorScheme colorScheme) {
    return FutureBuilder(
      future: RecentService.getRecentSkus(),
      builder: (context, snapshot) {
        final recents = snapshot.data ?? <String>[];
        if (recents.isEmpty) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Icon(
                    Icons.history_rounded,
                    size: 18,
                    color: colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Gần đây',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 40,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: recents.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, i) {
                  final sku = recents[i];
                  return ActionChip(
                    avatar: Icon(
                      Icons.inventory_2_outlined,
                      size: 16,
                      color: colorScheme.primary,
                    ),
                    label: Text(sku),
                    backgroundColor: colorScheme.primaryContainer.withOpacity(
                      0.3,
                    ),
                    side: BorderSide.none,
                    onPressed: () => _addBySku(context, sku),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }

  Widget _buildCustomerSection(
    BuildContext context,
    dynamic state,
    ColorScheme colorScheme,
  ) {
    if (state.selectedCustomer == null) return const SizedBox.shrink();

    final customer = state.selectedCustomer!;
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.primaryContainer,
            colorScheme.primaryContainer.withOpacity(0.5),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: colorScheme.primary,
            child: Text(
              customer.name.isNotEmpty ? customer.name[0].toUpperCase() : '?',
              style: TextStyle(
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  customer.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Điểm tích lũy: ${customer.points}',
                  style: TextStyle(
                    fontSize: 12,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.close_rounded, color: colorScheme.error),
            onPressed: () =>
                ref.read(posControllerProvider.notifier).setCustomer(null),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItems(
    BuildContext context,
    dynamic state,
    AppLocalizations l10n,
    ColorScheme colorScheme,
  ) {
    if (state.cartItems.isEmpty) {
      return SliverToBoxAdapter(
        child: Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(48),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: colorScheme.outlineVariant.withOpacity(0.5),
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.shopping_cart_outlined,
                  size: 48,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Giỏ hàng trống',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Quét mã hoặc nhập SKU để thêm sản phẩm',
                style: TextStyle(color: colorScheme.onSurfaceVariant),
              ),
            ],
          ),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final item = state.cartItems[index];
        return _buildCartItemCard(context, item, colorScheme, index);
      }, childCount: state.cartItems.length),
    );
  }

  Widget _buildCartItemCard(
    BuildContext context,
    OrderItem item,
    ColorScheme colorScheme,
    int index,
  ) {
    return Container(
      margin: EdgeInsets.fromLTRB(16, index == 0 ? 0 : 8, 16, 8),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Dismissible(
        key: Key('${item.productId}_${item.unitId}'),
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
            color: colorScheme.error,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(Icons.delete_outline, color: colorScheme.onError),
        ),
        onDismissed: (_) {
          ref
              .read(posControllerProvider.notifier)
              .removeProduct(productId: item.productId, unitId: item.unitId);
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Product icon
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.inventory_2_rounded,
                  color: colorScheme.primary,
                ),
              ),
              const SizedBox(width: 12),
              // Product info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder(
                      future: ProductRepository().getById(item.productId),
                      builder: (context, snapshot) {
                        final name =
                            snapshot.data?.name ??
                            'Sản phẩm #${item.productId}';
                        return Text(
                          name,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        );
                      },
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        if (item.unitName != null) ...[
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: colorScheme.secondaryContainer,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              item.unitName!,
                              style: TextStyle(
                                fontSize: 11,
                                color: colorScheme.onSecondaryContainer,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                        Text(
                          _formatPrice(item.price),
                          style: TextStyle(
                            fontSize: 13,
                            color: colorScheme.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Quantity controls
              Container(
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.remove_rounded,
                        size: 20,
                        color: colorScheme.primary,
                      ),
                      onPressed: () {
                        if (item.quantity > 1) {
                          ref
                              .read(posControllerProvider.notifier)
                              .updateQuantity(
                                productId: item.productId,
                                unitId: item.unitId,
                                quantity: item.quantity.toInt() - 1,
                              );
                        } else {
                          ref
                              .read(posControllerProvider.notifier)
                              .removeProduct(
                                productId: item.productId,
                                unitId: item.unitId,
                              );
                        }
                      },
                      constraints: const BoxConstraints(
                        minWidth: 36,
                        minHeight: 36,
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    Container(
                      constraints: const BoxConstraints(minWidth: 32),
                      alignment: Alignment.center,
                      child: Text(
                        '${item.quantity.toInt()}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.add_rounded,
                        size: 20,
                        color: colorScheme.primary,
                      ),
                      onPressed: () {
                        ref
                            .read(posControllerProvider.notifier)
                            .updateQuantity(
                              productId: item.productId,
                              unitId: item.unitId,
                              quantity: item.quantity.toInt() + 1,
                            );
                      },
                      constraints: const BoxConstraints(
                        minWidth: 36,
                        minHeight: 36,
                      ),
                      padding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummary(
    BuildContext context,
    dynamic state,
    AppLocalizations l10n,
    ColorScheme colorScheme,
  ) {
    if (state.cartItems.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colorScheme.outlineVariant.withOpacity(0.5)),
      ),
      child: Column(
        children: [
          _buildSummaryRow(l10n.subtotal, state.subtotal, colorScheme),
          if (state.cartDiscount > 0) ...[
            const SizedBox(height: 8),
            _buildSummaryRow(
              l10n.discount,
              -state.cartDiscount,
              colorScheme,
              isDiscount: true,
            ),
          ],
          if (state.vatAmount > 0) ...[
            const SizedBox(height: 8),
            _buildSummaryRow(l10n.vat, state.vatAmount, colorScheme),
          ],
          if (state.serviceFee > 0) ...[
            const SizedBox(height: 8),
            _buildSummaryRow(l10n.serviceFee, state.serviceFee, colorScheme),
          ],
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(height: 1),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tổng cộng',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              Text(
                _formatPrice(state.totalAmount),
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    double value,
    ColorScheme colorScheme, {
    bool isDiscount = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: colorScheme.onSurfaceVariant)),
        Text(
          '${isDiscount ? '-' : ''}${_formatPrice(value.abs())}',
          style: TextStyle(
            color: isDiscount ? Colors.green : colorScheme.onSurface,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar(
    BuildContext context,
    dynamic state,
    AppLocalizations l10n,
    ColorScheme colorScheme,
  ) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        16,
        12,
        16,
        12 + MediaQuery.of(context).padding.bottom,
      ),
      decoration: BoxDecoration(
        color: theme.cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Clear cart button
          Container(
            decoration: BoxDecoration(
              color: colorScheme.errorContainer.withOpacity(0.5),
              borderRadius: BorderRadius.circular(14),
            ),
            child: IconButton(
              icon: Icon(Icons.delete_sweep_rounded, color: colorScheme.error),
              onPressed: state.cartItems.isEmpty
                  ? null
                  : () => ref.read(posControllerProvider.notifier).clearCart(),
              tooltip: 'Xóa giỏ hàng',
            ),
          ),
          const SizedBox(width: 12),
          // Checkout button
          Expanded(
            child: FilledButton(
              onPressed: state.cartItems.isEmpty
                  ? null
                  : () => _checkout(context, state),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.payments_rounded),
                  const SizedBox(width: 8),
                  Text(
                    '${l10n.checkout} • ${_formatPrice(state.totalAmount)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(14),
      ),
      child: IconButton(
        icon: Icon(icon, color: color),
        onPressed: onPressed,
      ),
    );
  }

  ThemeData get theme => Theme.of(context);

  String _formatPrice(double price) {
    final formatted = price
        .toStringAsFixed(0)
        .replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        );
    return '$formatted đ';
  }

  // ============ Actions ============

  Future<void> _addBySku(BuildContext context, String sku) async {
    if (sku.trim().isEmpty) return;
    _skuController.clear();

    final repo = ProductRepository();
    final p = await repo.getBySku(sku.trim());
    if (p == null) {
      if (!mounted) return;
      _showErrorSnackbar(context, 'Không tìm thấy sản phẩm: $sku');
      return;
    }

    await ref.read(posControllerProvider.notifier).addProduct(p);
    await RecentService.pushRecentSku(p.sku);
    if (!mounted) return;
    _showSuccessSnackbar(context, 'Đã thêm: ${p.name}');
  }

  Future<void> _scanBarcode(BuildContext context) async {
    final result = await context.router.push(const ScannerRoute());
    final skus = result is String
        ? <String>[result]
        : (result is List<String> ? result : const <String>[]);

    for (final sku in skus) {
      final p = await ProductRepository().getBySku(sku);
      if (p != null && mounted) {
        await ref.read(posControllerProvider.notifier).addProduct(p);
        await RecentService.pushRecentSku(p.sku);
      }
    }
  }

  Future<void> _applyCoupon(BuildContext context, String code) async {
    if (code.trim().isEmpty) return;
    final promo = Promotion()
      ..name = 'Coupon $code'
      ..couponCode = code.trim()
      ..type = PromotionType.couponPercent
      ..value = 10;
    await ref.read(posControllerProvider.notifier).applyCoupon(promo);
    if (!mounted) return;
    _showSuccessSnackbar(context, 'Áp dụng mã: ${code.trim()}');
  }

  Future<void> _exportInvoice(BuildContext context, dynamic state) async {
    if (state.cartItems.isEmpty) {
      _showErrorSnackbar(context, 'Giỏ hàng trống');
      return;
    }
    final order = Order()
      ..id = 0
      ..createdAt = DateTime.now()
      ..totalAmount = state.totalAmount
      ..customerId = state.selectedCustomer?.id
      ..items = state.cartItems;
    await InvoiceService().shareInvoice(order, storeName: 'Basic Store');
  }

  Future<void> _selectCustomer(BuildContext context) async {
    final selected = await _showCustomerPicker(context);
    if (!mounted) return;
    if (selected != null) {
      ref.read(posControllerProvider.notifier).setCustomer(selected);
      _showSuccessSnackbar(context, 'Đã chọn: ${selected.name}');
    }
  }

  Future<Customer?> _showCustomerPicker(BuildContext context) async {
    final repo = CustomerRepository();
    final list = await repo.search(limit: 200);
    if (!mounted) return null;

    final colorScheme = Theme.of(context).colorScheme;

    return showModalBottomSheet<Customer?>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: colorScheme.outlineVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.people_rounded, color: colorScheme.primary),
                    const SizedBox(width: 12),
                    const Text(
                      'Chọn khách hàng',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final c = list[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: colorScheme.primaryContainer,
                        child: Text(
                          c.name.isNotEmpty ? c.name[0].toUpperCase() : '?',
                          style: TextStyle(
                            color: colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ),
                      title: Text(c.name),
                      subtitle: Text('Điểm: ${c.points}'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => Navigator.pop(context, c),
                    );
                  },
                ),
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom + 16),
            ],
          ),
        );
      },
    );
  }

  Future<void> _checkout(BuildContext context, dynamic state) async {
    // Show checkout dialog
    final payments = await showDialog<List<Payment>>(
      context: context,
      builder: (_) => CheckoutDialog(
        totalAmount: state.totalAmount,
        appliedCoupon: state.appliedCoupon,
      ),
    );

    if (payments == null || payments.isEmpty) return;
    if (!mounted) return;

    Customer? customer = state.selectedCustomer;
    if (customer == null) {
      customer = await _showCustomerPicker(context);
      if (!mounted) return;
      if (customer != null) {
        ref.read(posControllerProvider.notifier).setCustomer(customer);
      }
    }

    final order = Order()
      ..id = 0
      ..createdAt = DateTime.now()
      ..totalAmount = state.totalAmount
      ..customerId = customer?.id
      ..pointsDelta = _calcPoints(state.totalAmount)
      ..items = state.cartItems
      ..change =
          payments.fold(0.0, (sum, p) => sum + p.amount) - state.totalAmount;

    final orderRepo = OrderRepository();
    final productRepo = ProductRepository();
    final paymentRepo = PaymentRepository();
    final orderId = await orderRepo.create(order);

    // Save payments
    for (final payment in payments) {
      payment.orderId = orderId;
    }
    await paymentRepo.createAll(payments);

    // Update stock
    for (final it in state.cartItems) {
      final baseDelta = -(it.quantity * it.unitFactor).round();
      await productRepo.updateStock(productId: it.productId, delta: baseDelta);
    }

    if (customer != null) {
      await CustomerRepository().addPoints(customer.id, order.pointsDelta);
    }

    // Audit log
    final currentUser = await AuthService().getCurrentUser();
    await AuditLogRepository().create(
      AuditLog()
        ..userId = currentUser?.id
        ..action = 'CHECKOUT'
        ..details =
            'orderId=$orderId total=${state.totalAmount.toStringAsFixed(0)}',
    );

    if (!mounted) return;
    ref.read(posControllerProvider.notifier).clearCart();
    _showSuccessSnackbar(context, 'Đơn hàng #$orderId thành công!');
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
    await _applyVoiceCommand(context, spoken);
  }

  Future<void> _applyVoiceCommand(BuildContext context, String spoken) async {
    final l10n = AppLocalizations.of(context)!;
    final cmd = VoiceOrderParser.parse(spoken);
    if (cmd.lines.isEmpty) {
      _showErrorSnackbar(context, l10n.error);
      return;
    }

    final matcher = VoiceOrderMatcher();
    final productUnitRepo = ProductUnitRepository();

    Customer? customer;
    final customerName = cmd.customerName?.trim();
    if (customerName != null && customerName.isNotEmpty) {
      customer = await matcher.findOrCreateCustomer(customerName);
      if (!mounted) return;
      ref.read(posControllerProvider.notifier).setCustomer(customer);
    } else {
      customer = ref.read(posControllerProvider).selectedCustomer;
    }

    var added = 0;
    for (final line in cmd.lines) {
      final match = await matcher.matchProduct(
        phrase: line.productPhrase,
        unit: line.unit,
      );

      Product? product = match.product;
      var pickedByUser = false;
      if (product == null && match.candidates.isNotEmpty) {
        if (!mounted) return;
        product = await _pickProductCandidate(
          context,
          match.candidates,
          query: line.productPhrase,
        );
        pickedByUser = product != null;
      }

      if (product == null) {
        if (!mounted) return;
        _showErrorSnackbar(context, '${l10n.error}: ${line.productPhrase}');
        continue;
      }

      if (pickedByUser) {
        await matcher.rememberProductAlias(
          phrase: line.productPhrase,
          unit: line.unit,
          product: product,
        );
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

      await ref
          .read(posControllerProvider.notifier)
          .addProductWithQuantity(
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
    final customerLabel = customer == null ? '' : ' • ${customer.name}';
    _showSuccessSnackbar(context, 'Đã thêm $added sản phẩm$customerLabel');
  }

  Future<Product?> _pickProductCandidate(
    BuildContext context,
    List<VoiceProductCandidate> candidates, {
    required String query,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return showModalBottomSheet<Product?>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: colorScheme.outlineVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Chọn sản phẩm cho: "$query"',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              const Divider(height: 1),
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: candidates.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final c = candidates[index];
                    final p = c.product;
                    return ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.inventory_2_rounded,
                          color: colorScheme.primary,
                        ),
                      ),
                      title: Text(p.name),
                      subtitle: Text('SKU: ${p.sku} • Tồn: ${p.stock}'),
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '${(c.score * 100).toStringAsFixed(0)}%',
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      onTap: () => Navigator.pop(context, p),
                    );
                  },
                ),
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom + 16),
            ],
          ),
        );
      },
    );
  }

  int _calcPoints(double total) => (total / 10000).floor();

  void _showSuccessSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_rounded, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 2),
      ),
    );
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
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
