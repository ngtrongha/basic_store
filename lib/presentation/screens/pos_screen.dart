import 'package:basic_store/data/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../l10n/app_localizations.dart';

import '../../blocs/pos/pos_bloc.dart';
import '../../data/models/order.dart';
import '../../data/services/invoice_service.dart';
import '../../data/repositories/order_repository.dart';
import '../../data/repositories/product_repository.dart';
import '../widgets/cart_item_tile.dart';
import '../../data/repositories/customer_repository.dart';
import '../../data/models/customer.dart';
import '../../data/models/promotion.dart';
import '../dialogs/checkout_dialog.dart';
import '../../data/models/payment.dart';
import '../../data/repositories/payment_repository.dart';
import '../../data/repositories/audit_log_repository.dart';
import '../../data/models/audit_log.dart';
import '../../data/services/auth_service.dart';
import '../../data/services/recent_service.dart';

class PosScreen extends StatelessWidget {
  const PosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<PosBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.pos),
          actions: [
            IconButton(
              icon: const Icon(Icons.picture_as_pdf),
              onPressed: () async {
                final state = context.read<PosBloc>().state;
                if (state.cartItems.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(AppLocalizations.of(context)!.warning),
                    ),
                  );
                  return;
                }
                final order = Order()
                  ..id = 0
                  ..createdAt = DateTime.now()
                  ..totalAmount = state.totalAmount
                  ..customerId = null
                  ..items = state.cartItems;
                await InvoiceService().shareInvoice(
                  order,
                  storeName: 'Basic Store',
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.person_search),
              tooltip: AppLocalizations.of(context)!.selectCustomer,
              onPressed: () async {
                final selected = await _selectCustomer(context);
                if (selected != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '${AppLocalizations.of(context)!.selectCustomer}: ${selected.name}',
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
        body: BlocBuilder<PosBloc, PosState>(
          builder: (context, state) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: const InputDecoration(
                                hintText: 'Nhập mã SKU để thêm nhanh',
                                border: OutlineInputBorder(),
                              ),
                              onSubmitted: (sku) async {
                                final repo = ProductRepository();
                                final p = await repo.getBySku(sku.trim());
                                if (p == null) {
                                  if (!context.mounted) return;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        AppLocalizations.of(context)!.error,
                                      ),
                                    ),
                                  );
                                  return;
                                }
                                if (!context.mounted) return;
                                context.read<PosBloc>().add(
                                  PosEvent.addProduct(p),
                                );
                                await RecentService.pushRecentSku(p.sku);
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          IconButton(
                            tooltip: AppLocalizations.of(context)!.scanBarcode,
                            icon: const Icon(Icons.qr_code_scanner),
                            onPressed: () async {
                              final result = await Navigator.of(
                                context,
                              ).pushNamed('/scanner');
                              if (result is String) {
                                final p = await ProductRepository().getBySku(
                                  result,
                                );
                                if (p != null && context.mounted) {
                                  context.read<PosBloc>().add(
                                    PosEvent.addProduct(p),
                                  );
                                  await RecentService.pushRecentSku(p.sku);
                                }
                              }
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: AppLocalizations.of(
                                  context,
                                )!.couponCode,
                                suffixIcon: state.couponCode != null
                                    ? IconButton(
                                        icon: const Icon(Icons.clear),
                                        onPressed: () => context
                                            .read<PosBloc>()
                                            .add(const PosEvent.clearCoupon()),
                                      )
                                    : null,
                                border: const OutlineInputBorder(),
                              ),
                              onSubmitted: (code) async {
                                if (code.trim().isEmpty) return;
                                final promo = Promotion()
                                  ..name = 'Coupon $code'
                                  ..couponCode = code.trim()
                                  ..type = PromotionType.couponPercent
                                  ..value = 10;
                                context.read<PosBloc>().add(
                                  PosEvent.applyCoupon(promo),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                FutureBuilder(
                  future: RecentService.getRecentSkus(),
                  builder: (context, snapshot) {
                    final recents = snapshot.data ?? <String>[];
                    if (recents.isEmpty) return const SizedBox.shrink();
                    return SizedBox(
                      height: 44,
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, i) {
                          final sku = recents[i];
                          return ActionChip(
                            label: Text(sku),
                            onPressed: () async {
                              final p = await ProductRepository().getBySku(sku);
                              if (p != null && context.mounted) {
                                context.read<PosBloc>().add(
                                  PosEvent.addProduct(p),
                                );
                                await RecentService.pushRecentSku(p.sku);
                              }
                            },
                          );
                        },
                        separatorBuilder: (_, __) => const SizedBox(width: 8),
                        itemCount: recents.length,
                      ),
                    );
                  },
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = state.cartItems[index];
                      return CartItemTile(item: item);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${AppLocalizations.of(context)!.subtotal}: ${state.subtotal.toStringAsFixed(0)} đ',
                            ),
                            if (state.cartDiscount > 0)
                              Text(
                                '${AppLocalizations.of(context)!.discount}: -${state.cartDiscount.toStringAsFixed(0)} đ',
                              ),
                            if (state.vatAmount > 0)
                              Text(
                                '${AppLocalizations.of(context)!.vat}: ${state.vatAmount.toStringAsFixed(0)} đ',
                              ),
                            if (state.serviceFee > 0)
                              Text(
                                '${AppLocalizations.of(context)!.serviceFee}: ${state.serviceFee.toStringAsFixed(0)} đ',
                              ),
                          ],
                        ),
                      ),
                      Text(
                        '${state.totalAmount.toStringAsFixed(0)} đ',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () async {
                        if (state.cartItems.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                AppLocalizations.of(context)!.warning,
                              ),
                            ),
                          );
                          return;
                        }

                        // Show checkout dialog
                        final payments = await showDialog<List<Payment>>(
                          context: context,
                          builder: (_) => CheckoutDialog(
                            totalAmount: state.totalAmount,
                            appliedCoupon: state.appliedCoupon,
                          ),
                        );

                        if (payments == null || payments.isEmpty) return;

                        final customer = await _selectCustomer(context);
                        final order = Order()
                          ..id = 0
                          ..createdAt = DateTime.now()
                          ..totalAmount = state.totalAmount
                          ..customerId = customer?.id
                          ..pointsDelta = _calcPoints(state.totalAmount)
                          ..items = state.cartItems
                          ..change =
                              payments.fold(0.0, (sum, p) => sum + p.amount) -
                              state.totalAmount;

                        final orderRepo = OrderRepository();
                        final productRepo = ProductRepository();
                        final paymentRepo = PaymentRepository();
                        final orderId = await orderRepo.create(order);

                        // Save payments separately
                        for (final payment in payments) {
                          payment.orderId = orderId;
                        }
                        await paymentRepo.createAll(payments);

                        // update stock per item
                        for (final it in state.cartItems) {
                          await productRepo.updateStock(
                            productId: it.productId,
                            delta: -it.quantity,
                          );
                        }

                        if (customer != null) {
                          await CustomerRepository().addPoints(
                            customer.id,
                            order.pointsDelta,
                          );
                        }

                        // Audit log
                        final currentUser = await AuthService()
                            .getCurrentUser();
                        await AuditLogRepository().create(
                          AuditLog()
                            ..userId = currentUser?.id
                            ..action = 'CHECKOUT'
                            ..details =
                                'orderId=$orderId total=${state.totalAmount.toStringAsFixed(0)}',
                        );

                        if (!context.mounted) return;
                        context.read<PosBloc>().add(const PosEvent.clearCart());
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${AppLocalizations.of(context)!.success}: #$orderId',
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.payments),
                      label: Text(AppLocalizations.of(context)!.checkout),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // demo: add or increment a product item with id=1 and price=10000
            final cubit = context.read<PosBloc>();
            // if item not exists, emulate adding full product object
            cubit.add(
              PosEvent.addProduct(
                // minimal Product shape: only price/id is used by cubit
                // in real flow you would pass a Product from repository
                (() {
                  // lightweight inline Product stand-in
                  // ignore: no_leading_underscores_for_local_identifiers
                  final _p = Product()
                    ..id = 1
                    ..name = 'Demo'
                    ..sku = 'DEMO-1'
                    ..costPrice = 8000
                    ..salePrice = 10000
                    ..stock = 999;
                  return _p;
                })(),
              ),
            );
          },
          child: const Icon(Icons.add_shopping_cart),
        ),
      ),
    );
  }

  Future<Customer?> _selectCustomer(BuildContext context) async {
    final repo = CustomerRepository();
    final list = await repo.search(limit: 200);
    return showModalBottomSheet<Customer?>(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  'Chọn khách hàng',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final c = list[index];
                    return ListTile(
                      title: Text(c.name),
                      subtitle: Text('Điểm: ${c.points}'),
                      onTap: () => Navigator.pop(context, c),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  int _calcPoints(double total) {
    // Simple rule: 1 point per 10,000đ
    return (total / 10000).floor();
  }
}
