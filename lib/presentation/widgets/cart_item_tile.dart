import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/order.dart';
import '../../data/models/product.dart';
import '../../data/repositories/product_repository.dart';
import '../../features/pos/pos_controller.dart';

class CartItemTile extends ConsumerStatefulWidget {
  final OrderItem item;

  const CartItemTile({super.key, required this.item});

  @override
  ConsumerState<CartItemTile> createState() => _CartItemTileState();
}

class _CartItemTileState extends ConsumerState<CartItemTile> {
  Product? _product;
  final _productRepo = ProductRepository();

  @override
  void initState() {
    super.initState();
    _loadProduct();
  }

  Future<void> _loadProduct() async {
    final product = await _productRepo.getById(widget.item.productId);
    if (mounted) {
      setState(() {
        _product = product;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final productName = _product?.name ?? 'SP #${widget.item.productId}';
    final unitLabel =
        widget.item.unitName == null || widget.item.unitName!.isEmpty
        ? ''
        : ' ${widget.item.unitName}';

    return ListTile(
      title: Text(productName),
      subtitle: Text('SL: ${widget.item.quantity}$unitLabel'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: () {
              final newQty = widget.item.quantity - 1;
              ref
                  .read(posControllerProvider.notifier)
                  .updateQuantity(
                    productId: widget.item.productId,
                    unitId: widget.item.unitId,
                    quantity: newQty,
                  );
            },
          ),
          Text(
            '${(widget.item.price * widget.item.quantity).toStringAsFixed(0)} đ',
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              final newQty = widget.item.quantity + 1;
              ref
                  .read(posControllerProvider.notifier)
                  .updateQuantity(
                    productId: widget.item.productId,
                    unitId: widget.item.unitId,
                    quantity: newQty,
                  );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              ref
                  .read(posControllerProvider.notifier)
                  .removeProduct(
                    productId: widget.item.productId,
                    unitId: widget.item.unitId,
                  );
            },
          ),
        ],
      ),
    );
  }
}
