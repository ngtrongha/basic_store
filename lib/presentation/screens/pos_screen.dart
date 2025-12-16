import 'package:auto_route/auto_route.dart';
import 'package:basic_store/data/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

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
import '../../data/services/auth_service.dart';
import '../../data/services/invoice_service.dart';
import '../../data/services/recent_service.dart';
import '../../features/pos/pos_controller.dart';
import '../../features/voice/voice_order_matcher.dart';
import '../../features/voice/voice_order_parser.dart';
import '../../l10n/app_localizations.dart';
import '../../router/app_router.dart';
import '../dialogs/checkout_dialog.dart';
import '../widgets/cart_item_tile.dart';

@RoutePage()
class PosScreen extends ConsumerWidget {
  const PosScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(posControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.pos),
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: () async {
              final current = ref.read(posControllerProvider);
              if (current.cartItems.isEmpty) {
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
                ..totalAmount = current.totalAmount
                ..customerId = current.selectedCustomer?.id
                ..items = current.cartItems;
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
              final l10n = AppLocalizations.of(context)!;
              final messenger = ScaffoldMessenger.of(context);
              final selected = await _selectCustomer(context);
              if (!context.mounted) return;
              if (selected != null) {
                ref.read(posControllerProvider.notifier).setCustomer(selected);
                messenger.showSnackBar(
                  SnackBar(
                    content: Text('${l10n.selectCustomer}: ${selected.name}'),
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: Column(
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
                          await ref
                              .read(posControllerProvider.notifier)
                              .addProduct(p);
                          await RecentService.pushRecentSku(p.sku);
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    IconButton(
                      tooltip: AppLocalizations.of(context)!.scanBarcode,
                      icon: const Icon(Icons.qr_code_scanner),
                      onPressed: () async {
                        final result = await context.router.push(
                          const ScannerRoute(),
                        );
                        final skus = result is String
                            ? <String>[result]
                            : (result is List<String>
                                  ? result
                                  : const <String>[]);

                        for (final sku in skus) {
                          final p = await ProductRepository().getBySku(sku);
                          if (p != null && context.mounted) {
                            await ref
                                .read(posControllerProvider.notifier)
                                .addProduct(p);
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
                          hintText: AppLocalizations.of(context)!.couponCode,
                          suffixIcon: state.couponCode != null
                              ? IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () => ref
                                      .read(posControllerProvider.notifier)
                                      .clearCoupon(),
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
                          await ref
                              .read(posControllerProvider.notifier)
                              .applyCoupon(promo);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                if (state.selectedCustomer != null)
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${AppLocalizations.of(context)!.selectCustomer}: ${state.selectedCustomer!.name}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () => ref
                            .read(posControllerProvider.notifier)
                            .setCustomer(null),
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
                          await ref
                              .read(posControllerProvider.notifier)
                              .addProduct(p);
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
                        content: Text(AppLocalizations.of(context)!.warning),
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
                  if (!context.mounted) return;

                  Customer? customer = state.selectedCustomer;
                  if (customer == null) {
                    customer = await _selectCustomer(context);
                    if (!context.mounted) return;
                    if (customer != null) {
                      ref
                          .read(posControllerProvider.notifier)
                          .setCustomer(customer);
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
                  final currentUser = await AuthService().getCurrentUser();
                  await AuditLogRepository().create(
                    AuditLog()
                      ..userId = currentUser?.id
                      ..action = 'CHECKOUT'
                      ..details =
                          'orderId=$orderId total=${state.totalAmount.toStringAsFixed(0)}',
                  );

                  if (!context.mounted) return;
                  ref.read(posControllerProvider.notifier).clearCart();
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
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Voice',
        onPressed: () async {
          final text = await showModalBottomSheet<String?>(
            context: context,
            isScrollControlled: true,
            builder: (_) => const _VoiceInputSheet(),
          );
          final spoken = text?.trim();
          if (spoken == null || spoken.isEmpty) return;
          if (!context.mounted) return;
          await _applyVoiceCommand(context, ref, spoken);
        },
        child: const Icon(Icons.mic),
      ),
    );
  }

  Future<void> _applyVoiceCommand(
    BuildContext context,
    WidgetRef ref,
    String spoken,
  ) async {
    final cmd = VoiceOrderParser.parse(spoken);
    if (cmd.lines.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.error)),
      );
      return;
    }

    final matcher = VoiceOrderMatcher();

    Customer? customer;
    final customerName = cmd.customerName?.trim();
    if (customerName != null && customerName.isNotEmpty) {
      customer = await matcher.findOrCreateCustomer(customerName);
      if (!context.mounted) return;
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
        if (!context.mounted) return;
        product = await _pickProductCandidate(
          context,
          match.candidates,
          query: line.productPhrase,
        );
        pickedByUser = product != null;
      }

      if (product == null) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${AppLocalizations.of(context)!.error}: ${line.productPhrase}',
            ),
          ),
        );
        continue;
      }

      if (pickedByUser) {
        await matcher.rememberProductAlias(
          phrase: line.productPhrase,
          unit: line.unit,
          product: product,
        );
      }

      await ref
          .read(posControllerProvider.notifier)
          .addProductWithQuantity(product, line.quantity);
      await RecentService.pushRecentSku(product.sku);
      added++;
    }

    if (!context.mounted) return;
    final customerLabel = customer == null ? '' : ' • ${customer.name}';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Đã thêm $added sản phẩm$customerLabel')),
    );
  }

  Future<Product?> _pickProductCandidate(
    BuildContext context,
    List<VoiceProductCandidate> candidates, {
    required String query,
  }) {
    return showModalBottomSheet<Product?>(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  'Chọn sản phẩm cho: $query',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: candidates.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final c = candidates[index];
                    final p = c.product;
                    return ListTile(
                      title: Text(p.name),
                      subtitle: Text('SKU: ${p.sku} • Tồn: ${p.stock}'),
                      trailing: Text('${(c.score * 100).toStringAsFixed(0)}%'),
                      onTap: () => Navigator.pop(context, p),
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

  Future<Customer?> _selectCustomer(BuildContext context) async {
    final repo = CustomerRepository();
    final list = await repo.search(limit: 200);
    if (!context.mounted) return null;
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

class _VoiceInputSheet extends StatefulWidget {
  const _VoiceInputSheet();

  @override
  State<_VoiceInputSheet> createState() => _VoiceInputSheetState();
}

class _VoiceInputSheetState extends State<_VoiceInputSheet> {
  final stt.SpeechToText _speech = stt.SpeechToText();
  final TextEditingController _textCtrl = TextEditingController();

  bool _initialized = false;
  bool _listening = false;
  bool _userEdited = false;
  String? _error;
  String _status = '';
  String? _localeId;

  @override
  void initState() {
    super.initState();
    _textCtrl.addListener(_onTextChanged);
    _initAndListen();
  }

  @override
  void dispose() {
    _speech.stop();
    _textCtrl.removeListener(_onTextChanged);
    _textCtrl.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    if (!mounted) return;
    setState(() {});
  }

  Future<void> _initAndListen() async {
    final ok = await _speech.initialize(
      onError: (e) {
        if (!mounted) return;
        setState(() => _error = e.errorMsg);
      },
      onStatus: (s) {
        if (!mounted) return;
        setState(() => _status = s);
        if (s == 'done' || s == 'notListening') {
          setState(() => _listening = false);
        }
      },
    );

    if (!mounted) return;
    if (!ok) {
      setState(() {
        _initialized = true;
        _error = 'Không thể khởi tạo nhận dạng giọng nói';
      });
      return;
    }

    try {
      final locales = await _speech.locales();
      final vi = locales
          .where((l) => l.localeId.toLowerCase().startsWith('vi'))
          .toList();
      _localeId = vi.isNotEmpty ? vi.first.localeId : null;
    } catch (_) {
      _localeId = null;
    }

    setState(() => _initialized = true);
    await _startListening();
  }

  Future<void> _startListening() async {
    if (!_speech.isAvailable) return;
    if (_listening) return;

    setState(() {
      _error = null;
      _listening = true;
      _userEdited = false;
    });

    await _speech.listen(
      onResult: (r) {
        if (!mounted) return;
        if (_userEdited) return;
        _textCtrl.text = r.recognizedWords;
        _textCtrl.selection = TextSelection.collapsed(
          offset: _textCtrl.text.length,
        );
      },
      localeId: _localeId,
      listenFor: const Duration(seconds: 30),
      pauseFor: const Duration(seconds: 2),
      listenOptions: stt.SpeechListenOptions(
        partialResults: true,
        cancelOnError: true,
        listenMode: stt.ListenMode.dictation,
      ),
    );
  }

  Future<void> _stopListening() async {
    await _speech.stop();
    if (!mounted) return;
    setState(() => _listening = false);
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + bottomInset),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Icon(Icons.mic),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'Nhập đơn bằng giọng nói',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                if (_status.isNotEmpty)
                  Text(
                    _status,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.outline,
                      fontSize: 12,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            if (!_initialized)
              const Padding(
                padding: EdgeInsets.all(12),
                child: Center(child: CircularProgressIndicator()),
              )
            else ...[
              if (_error != null) ...[
                Text(_error!, style: const TextStyle(color: Colors.red)),
                const SizedBox(height: 8),
              ],
              TextField(
                controller: _textCtrl,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'Ví dụ: Ông B mua 1 thùng Tiger',
                  border: OutlineInputBorder(),
                ),
                onChanged: (_) => setState(() => _userEdited = true),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  OutlinedButton.icon(
                    onPressed: _listening ? _stopListening : _startListening,
                    icon: Icon(_listening ? Icons.stop : Icons.mic),
                    label: Text(_listening ? 'Dừng' : 'Nghe'),
                  ),
                  const SizedBox(width: 12),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(AppLocalizations.of(context)!.cancel),
                  ),
                  const Spacer(),
                  FilledButton(
                    onPressed: _textCtrl.text.trim().isEmpty
                        ? null
                        : () => Navigator.pop(context, _textCtrl.text.trim()),
                    child: Text(AppLocalizations.of(context)!.save),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
