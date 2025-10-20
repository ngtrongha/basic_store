import 'package:flutter/material.dart';
import '../../data/services/favorite_service.dart';

class ProductCard extends StatefulWidget {
  final String name;
  final String sku;
  final double salePrice;
  final int stock;
  final int? productId;
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    required this.name,
    required this.sku,
    required this.salePrice,
    required this.stock,
    this.productId,
    this.onTap,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _fav = false;

  @override
  void initState() {
    super.initState();
    _loadFav();
  }

  Future<void> _loadFav() async {
    if (widget.productId == null) return;
    final favs = await FavoriteService.getFavorites();
    if (mounted) setState(() => _fav = favs.contains(widget.productId));
  }

  Future<void> _toggleFav() async {
    if (widget.productId == null) return;
    await FavoriteService.toggleFavorite(widget.productId!);
    await _loadFav();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: InkWell(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: _toggleFav,
                          icon: Icon(
                            _fav ? Icons.favorite : Icons.favorite_border,
                            color: _fav ? Colors.red : null,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'SKU: ${widget.sku}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${widget.salePrice.toStringAsFixed(0)} đ',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text('Tồn: ${widget.stock}'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
