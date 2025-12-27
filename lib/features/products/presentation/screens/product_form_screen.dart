import 'package:auto_route/auto_route.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/widgets.dart';
import '../providers/product_providers.dart';

@RoutePage()
class ProductFormScreen extends ConsumerStatefulWidget {
  const ProductFormScreen({super.key, this.productId});

  final int? productId;

  @override
  ConsumerState<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends ConsumerState<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _costPriceController = TextEditingController();
  final _quantityController = TextEditingController();
  final _unitController = TextEditingController(text: 'cái');
  final _barcodeController = TextEditingController();

  int? _selectedCategoryId;
  String? _imagePath;
  bool _isLoading = false;
  bool _isEditing = false;
  Product? _existingProduct;

  @override
  void initState() {
    super.initState();
    if (widget.productId != null) {
      _isEditing = true;
      _loadProduct();
    }
  }

  Future<void> _loadProduct() async {
    final dao = ref.read(productDaoProvider);
    final product = await dao.getProductById(widget.productId!);
    if (product != null && mounted) {
      setState(() {
        _existingProduct = product;
        _nameController.text = product.name;
        _descriptionController.text = product.description ?? '';
        _priceController.text = product.price.toStringAsFixed(0);
        _costPriceController.text = product.costPrice.toStringAsFixed(0);
        _quantityController.text = product.quantity.toString();
        _unitController.text = product.unit;
        _barcodeController.text = product.barcode ?? '';
        _selectedCategoryId = product.categoryId;
        _imagePath = product.imagePath;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _costPriceController.dispose();
    _quantityController.dispose();
    _unitController.dispose();
    _barcodeController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final result = await picker.pickImage(source: ImageSource.gallery);
    if (result != null) {
      // TODO: Upload to Google Drive and get URL
      setState(() {
        _imagePath = result.path; // Temporary local path
      });
    }
  }

  Future<void> _saveProduct() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final dao = ref.read(productDaoProvider);

      if (_isEditing && _existingProduct != null) {
        // Update existing product
        final updated = _existingProduct!.copyWith(
          name: _nameController.text.trim(),
          description: drift.Value(_descriptionController.text.trim()),
          price: double.parse(_priceController.text),
          costPrice: double.parse(_costPriceController.text),
          quantity: int.parse(
            _quantityController.text.isEmpty ? '0' : _quantityController.text,
          ),
          unit: _unitController.text.trim(),
          barcode: drift.Value(
            _barcodeController.text.trim().isEmpty
                ? null
                : _barcodeController.text.trim(),
          ),
          categoryId: drift.Value(_selectedCategoryId),
          imagePath: drift.Value(_imagePath),
          updatedAt: drift.Value(DateTime.now()),
        );
        await dao.updateProduct(updated);
      } else {
        // Create new product
        await dao.insertProduct(
          ProductsCompanion.insert(
            name: _nameController.text.trim(),
            description: drift.Value(_descriptionController.text.trim()),
            price: double.parse(_priceController.text),
            costPrice: drift.Value(double.parse(_costPriceController.text)),
            quantity: drift.Value(
              int.parse(
                _quantityController.text.isEmpty
                    ? '0'
                    : _quantityController.text,
              ),
            ),
            unit: drift.Value(_unitController.text.trim()),
            barcode: drift.Value(
              _barcodeController.text.trim().isEmpty
                  ? null
                  : _barcodeController.text.trim(),
            ),
            categoryId: drift.Value(_selectedCategoryId),
            imagePath: drift.Value(_imagePath),
          ),
        );
      }

      // Refresh product list
      ref.read(productsProvider.notifier).refresh();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _isEditing ? 'Đã cập nhật sản phẩm' : 'Đã thêm sản phẩm mới',
            ),
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
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(categoriesProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(_isEditing ? 'Sửa sản phẩm' : 'Thêm sản phẩm'),
        actions: [
          if (_isEditing)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              color: AppColors.error,
              onPressed: _confirmDelete,
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image picker
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceLight,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: _imagePath != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              _imagePath!,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) =>
                                  _buildImagePlaceholder(),
                            ),
                          )
                        : _buildImagePlaceholder(),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Center(
                child: Text(
                  'Nhấn để thêm ảnh',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Name
              AppTextField(
                controller: _nameController,
                label: 'Tên sản phẩm *',
                hint: 'Nhập tên sản phẩm',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập tên sản phẩm';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Description
              AppTextField(
                controller: _descriptionController,
                label: 'Mô tả',
                hint: 'Mô tả sản phẩm (tùy chọn)',
                maxLines: 3,
              ),

              const SizedBox(height: 16),

              // Price and Cost Price
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      controller: _priceController,
                      label: 'Giá bán *',
                      hint: '0',
                      keyboardType: TextInputType.number,
                      prefixIcon: Icons.attach_money,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nhập giá bán';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: AppTextField(
                      controller: _costPriceController,
                      label: 'Giá vốn *',
                      hint: '0',
                      keyboardType: TextInputType.number,
                      prefixIcon: Icons.money_off,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nhập giá vốn';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Quantity and Unit
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      controller: _quantityController,
                      label: 'Số lượng',
                      hint: '0',
                      keyboardType: TextInputType.number,
                      prefixIcon: Icons.inventory_outlined,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: AppTextField(
                      controller: _unitController,
                      label: 'Đơn vị',
                      hint: 'cái',
                      prefixIcon: Icons.straighten,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Barcode
              AppTextField(
                controller: _barcodeController,
                label: 'Mã vạch',
                hint: 'Quét hoặc nhập',
                prefixIcon: Icons.qr_code,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.qr_code_scanner),
                  onPressed: () {
                    // TODO: Scan barcode
                  },
                ),
              ),

              const SizedBox(height: 16),

              // Category dropdown
              const Text(
                'Danh mục',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              categoriesAsync.when(
                data: (categories) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<int?>(
                      value: _selectedCategoryId,
                      isExpanded: true,
                      hint: const Text('Chọn danh mục'),
                      items: [
                        const DropdownMenuItem<int?>(
                          value: null,
                          child: Text('Không có danh mục'),
                        ),
                        ...categories.map(
                          (c) => DropdownMenuItem(
                            value: c.id,
                            child: Text(c.name),
                          ),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() => _selectedCategoryId = value);
                      },
                    ),
                  ),
                ),
                loading: () => const LinearProgressIndicator(),
                error: (_, __) => const Text('Không thể tải danh mục'),
              ),

              const SizedBox(height: 32),

              // Save button
              AppButton(
                text: _isEditing ? 'Lưu thay đổi' : 'Thêm sản phẩm',
                onPressed: _saveProduct,
                isLoading: _isLoading,
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagePlaceholder() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.add_photo_alternate_outlined,
          size: 40,
          color: AppColors.textSecondary,
        ),
        SizedBox(height: 4),
        Text(
          'Thêm ảnh',
          style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
        ),
      ],
    );
  }

  void _confirmDelete() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xóa sản phẩm'),
        content: const Text('Bạn có chắc muốn xóa sản phẩm này?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              if (widget.productId != null) {
                await ref
                    .read(productsProvider.notifier)
                    .deleteProduct(widget.productId!);
                if (mounted) {
                  context.router.maybePop();
                }
              }
            },
            child: const Text('Xóa', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }
}
