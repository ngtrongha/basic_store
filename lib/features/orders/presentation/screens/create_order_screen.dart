import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/widgets.dart';
import '../../../products/presentation/providers/product_providers.dart';
import '../../../customers/presentation/providers/customer_providers.dart';
import '../providers/order_providers.dart';
import '../../data/dao/order_dao.dart';

@RoutePage()
class CreateOrderScreen extends ConsumerStatefulWidget {
  const CreateOrderScreen({super.key});

  @override
  ConsumerState<CreateOrderScreen> createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends ConsumerState<CreateOrderScreen> {
  final _currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
  bool _isCreatingOrder = false;

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartProvider);
    final selectedCustomer = ref.watch(selectedCustomerProvider);
    final discount = ref.watch(orderDiscountProvider);

    final subtotal = cart.fold(
      0.0,
      (sum, item) => sum + item.product.price * item.quantity,
    );
    final total = subtotal - discount;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Tạo đơn hàng'),
        actions: [
          if (cart.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () {
                ref.read(cartProvider.notifier).clear();
                ref.read(selectedCustomerProvider.notifier).clear();
                ref.read(orderDiscountProvider.notifier).clear();
              },
              tooltip: 'Xóa đơn hàng',
            ),
        ],
      ),
      body: Column(
        children: [
          // Customer selection
          _buildCustomerSection(selectedCustomer),
          const Divider(height: 1),

          // Cart items
          Expanded(
            child: cart.isEmpty
                ? _buildEmptyCart()
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      final item = cart[index];
                      return _CartItemCard(
                        item: item,
                        currencyFormat: _currencyFormat,
                        onIncrease: () => ref
                            .read(cartProvider.notifier)
                            .increaseQuantity(item.product.id),
                        onDecrease: () => ref
                            .read(cartProvider.notifier)
                            .decreaseQuantity(item.product.id),
                        onRemove: () => ref
                            .read(cartProvider.notifier)
                            .removeProduct(item.product.id),
                      );
                    },
                  ),
          ),

          // Order summary
          if (cart.isNotEmpty) _buildOrderSummary(subtotal, discount, total),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showProductPicker(),
        icon: const Icon(Icons.add),
        label: const Text('Thêm sản phẩm'),
      ),
    );
  }

  Widget _buildCustomerSection(Customer? customer) {
    return InkWell(
      onTap: _showCustomerPicker,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: customer != null
                  ? AppColors.primary.withValues(alpha: 0.2)
                  : AppColors.surfaceLight,
              child: Icon(
                Icons.person,
                color: customer != null
                    ? AppColors.primary
                    : AppColors.textSecondary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    customer?.name ?? 'Khách lẻ',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  if (customer?.phone != null)
                    Text(
                      customer!.phone!,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 80,
            color: AppColors.textSecondary,
          ),
          const SizedBox(height: 16),
          const Text(
            'Chưa có sản phẩm nào',
            style: TextStyle(fontSize: 18, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 8),
          const Text(
            'Nhấn nút bên dưới để thêm sản phẩm',
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary(double subtotal, double discount, double total) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Subtotal
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Tạm tính'),
                Text(_currencyFormat.format(subtotal)),
              ],
            ),
            // Discount
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                    onPressed: _showDiscountDialog,
                    icon: const Icon(Icons.discount_outlined, size: 18),
                    label: const Text('Giảm giá'),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
                  Text(
                    discount > 0
                        ? '-${_currencyFormat.format(discount)}'
                        : '₫0',
                    style: TextStyle(
                      color: discount > 0
                          ? AppColors.error
                          : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            // Total
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Tổng cộng',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(
                  _currencyFormat.format(total),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Create order button
            AppButton(
              text: 'Tạo đơn hàng',
              onPressed: _createOrder,
              isLoading: _isCreatingOrder,
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }

  void _showProductPicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) => _ProductPickerSheet(
          scrollController: scrollController,
          currencyFormat: _currencyFormat,
        ),
      ),
    );
  }

  void _showCustomerPicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) =>
            _CustomerPickerSheet(scrollController: scrollController),
      ),
    );
  }

  void _showDiscountDialog() {
    final controller = TextEditingController(
      text: ref.read(orderDiscountProvider).toStringAsFixed(0),
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Giảm giá'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Số tiền giảm',
            suffix: Text('₫'),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () {
              final discount = double.tryParse(controller.text) ?? 0;
              ref.read(orderDiscountProvider.notifier).setDiscount(discount);
              Navigator.pop(context);
            },
            child: const Text('Áp dụng'),
          ),
        ],
      ),
    );
  }

  Future<void> _createOrder() async {
    final cart = ref.read(cartProvider);
    if (cart.isEmpty) return;

    setState(() => _isCreatingOrder = true);

    try {
      final dao = ref.read(orderDaoProvider);
      final customer = ref.read(selectedCustomerProvider);
      final discount = ref.read(orderDiscountProvider);

      final subtotal = cart.fold(
        0.0,
        (sum, item) => sum + item.product.price * item.quantity,
      );
      final total = subtotal - discount;

      final orderNumber = await dao.generateOrderNumber();

      await dao.createOrder(
        orderNumber: orderNumber,
        customerId: customer?.id,
        subtotal: subtotal,
        discount: discount,
        total: total,
        paidAmount: total,
        paymentMethod: 'cash',
        items: cart
            .map(
              (item) => OrderItemData(
                productId: item.product.id,
                productName: item.product.name,
                price: item.product.price,
                quantity: item.quantity,
                subtotal: item.product.price * item.quantity,
              ),
            )
            .toList(),
      );

      // Clear cart
      ref.read(cartProvider.notifier).clear();
      ref.read(selectedCustomerProvider.notifier).clear();
      ref.read(orderDiscountProvider.notifier).clear();

      // Refresh stats
      ref.read(todaysStatsProvider.notifier).refresh();
      ref.read(ordersProvider.notifier).refresh();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Đã tạo đơn hàng $orderNumber'),
            backgroundColor: AppColors.success,
          ),
        );
        context.router.maybePop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi: $e'), backgroundColor: AppColors.error),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isCreatingOrder = false);
      }
    }
  }
}

class _CartItemCard extends StatelessWidget {
  const _CartItemCard({
    required this.item,
    required this.currencyFormat,
    required this.onIncrease,
    required this.onDecrease,
    required this.onRemove,
  });

  final CartItem item;
  final NumberFormat currencyFormat;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  currencyFormat.format(item.product.price),
                  style: const TextStyle(color: AppColors.primary),
                ),
              ],
            ),
          ),
          // Quantity controls
          Container(
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove, size: 18),
                  onPressed: onDecrease,
                  visualDensity: VisualDensity.compact,
                ),
                SizedBox(
                  width: 32,
                  child: Text(
                    '${item.quantity}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add, size: 18),
                  onPressed: onIncrease,
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Subtotal
          Text(
            currencyFormat.format(item.subtotal),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _ProductPickerSheet extends ConsumerWidget {
  const _ProductPickerSheet({
    required this.scrollController,
    required this.currencyFormat,
  });

  final ScrollController scrollController;
  final NumberFormat currencyFormat;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productsProvider);

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        children: [
          // Handle
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // Title
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Chọn sản phẩm',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16),
          // Product list
          Expanded(
            child: productsAsync.when(
              data: (products) => ListView.builder(
                controller: scrollController,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ListTile(
                    leading: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.inventory_2_outlined,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    title: Text(product.name),
                    subtitle: Text(currencyFormat.format(product.price)),
                    trailing: Text('Tồn: ${product.quantity}'),
                    onTap: () {
                      ref.read(cartProvider.notifier).addProduct(product);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Lỗi: $e')),
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomerPickerSheet extends ConsumerWidget {
  const _CustomerPickerSheet({required this.scrollController});

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customersAsync = ref.watch(customersProvider);

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        children: [
          // Handle
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Chọn khách hàng',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    ref.read(selectedCustomerProvider.notifier).clear();
                    Navigator.pop(context);
                  },
                  child: const Text('Khách lẻ'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Customer list
          Expanded(
            child: customersAsync.when(
              data: (customers) => ListView.builder(
                controller: scrollController,
                itemCount: customers.length,
                itemBuilder: (context, index) {
                  final customer = customers[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.primary.withValues(alpha: 0.2),
                      child: Text(
                        customer.name.isNotEmpty
                            ? customer.name[0].toUpperCase()
                            : '?',
                        style: const TextStyle(color: AppColors.primary),
                      ),
                    ),
                    title: Text(customer.name),
                    subtitle: customer.phone != null
                        ? Text(customer.phone!)
                        : null,
                    onTap: () {
                      ref
                          .read(selectedCustomerProvider.notifier)
                          .select(customer);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Lỗi: $e')),
            ),
          ),
        ],
      ),
    );
  }
}
