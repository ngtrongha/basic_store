import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/order.dart';
import '../../data/models/product.dart';
import '../../data/repositories/product_repository.dart';
import '../../blocs/pos/pos_bloc.dart'; 

class CartItemTile extends StatefulWidget {
  final OrderItem item;

  const CartItemTile({super.key, required this.item});

  @override
  State<CartItemTile> createState() => _CartItemTileState();
}

class _CartItemTileState extends State<CartItemTile> {
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

    return ListTile(
      title: Text(productName),
      subtitle: Text('SL: ${widget.item.quantity}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: () {
              final newQty = widget.item.quantity - 1;
              context.read<PosBloc>().add(
                PosEvent.updateQuantity(
                  productId: widget.item.productId,
                  quantity: newQty,
                ),
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
              context.read<PosBloc>().add(
                PosEvent.updateQuantity(
                  productId: widget.item.productId,
                  quantity: newQty,
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              context.read<PosBloc>().add(
                PosEvent.removeProduct(widget.item.productId),
              );
            },
          ),
        ],
      ),
    );
  }
}
