import 'package:auto_route/auto_route.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/widgets.dart';
import '../providers/customer_providers.dart';

@RoutePage()
class CustomerFormScreen extends ConsumerStatefulWidget {
  const CustomerFormScreen({super.key, this.customerId});

  final int? customerId;

  @override
  ConsumerState<CustomerFormScreen> createState() => _CustomerFormScreenState();
}

class _CustomerFormScreenState extends ConsumerState<CustomerFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _noteController = TextEditingController();

  bool _isLoading = false;
  bool _isEditing = false;
  Customer? _existingCustomer;

  @override
  void initState() {
    super.initState();
    if (widget.customerId != null) {
      _isEditing = true;
      _loadCustomer();
    }
  }

  Future<void> _loadCustomer() async {
    final dao = ref.read(customerDaoProvider);
    final customer = await dao.getCustomerById(widget.customerId!);
    if (customer != null && mounted) {
      setState(() {
        _existingCustomer = customer;
        _nameController.text = customer.name;
        _phoneController.text = customer.phone ?? '';
        _emailController.text = customer.email ?? '';
        _addressController.text = customer.address ?? '';
        _noteController.text = customer.note ?? '';
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _saveCustomer() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final dao = ref.read(customerDaoProvider);

      if (_isEditing && _existingCustomer != null) {
        // Update existing customer
        final updated = _existingCustomer!.copyWith(
          name: _nameController.text.trim(),
          phone: drift.Value(
            _phoneController.text.trim().isEmpty
                ? null
                : _phoneController.text.trim(),
          ),
          email: drift.Value(
            _emailController.text.trim().isEmpty
                ? null
                : _emailController.text.trim(),
          ),
          address: drift.Value(
            _addressController.text.trim().isEmpty
                ? null
                : _addressController.text.trim(),
          ),
          note: drift.Value(
            _noteController.text.trim().isEmpty
                ? null
                : _noteController.text.trim(),
          ),
          updatedAt: drift.Value(DateTime.now()),
        );
        await dao.updateCustomer(updated);
      } else {
        // Create new customer
        await dao.insertCustomer(
          CustomersCompanion.insert(
            name: _nameController.text.trim(),
            phone: drift.Value(
              _phoneController.text.trim().isEmpty
                  ? null
                  : _phoneController.text.trim(),
            ),
            email: drift.Value(
              _emailController.text.trim().isEmpty
                  ? null
                  : _emailController.text.trim(),
            ),
            address: drift.Value(
              _addressController.text.trim().isEmpty
                  ? null
                  : _addressController.text.trim(),
            ),
            note: drift.Value(
              _noteController.text.trim().isEmpty
                  ? null
                  : _noteController.text.trim(),
            ),
          ),
        );
      }

      // Refresh customer list
      ref.read(customersProvider.notifier).refresh();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _isEditing ? 'Đã cập nhật khách hàng' : 'Đã thêm khách hàng mới',
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
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(_isEditing ? 'Sửa khách hàng' : 'Thêm khách hàng'),
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
              // Avatar
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: AppColors.primary.withValues(alpha: 0.2),
                  child: Text(
                    _nameController.text.isNotEmpty
                        ? _nameController.text[0].toUpperCase()
                        : '?',
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Name
              AppTextField(
                controller: _nameController,
                label: 'Tên khách hàng *',
                hint: 'Nhập tên khách hàng',
                prefixIcon: Icons.person_outlined,
                onChanged: (_) => setState(() {}),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập tên khách hàng';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Phone
              AppTextField(
                controller: _phoneController,
                label: 'Số điện thoại',
                hint: 'Nhập số điện thoại',
                prefixIcon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
              ),

              const SizedBox(height: 16),

              // Email
              AppTextField(
                controller: _emailController,
                label: 'Email',
                hint: 'Nhập email',
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 16),

              // Address
              AppTextField(
                controller: _addressController,
                label: 'Địa chỉ',
                hint: 'Nhập địa chỉ',
                prefixIcon: Icons.location_on_outlined,
                maxLines: 2,
              ),

              const SizedBox(height: 16),

              // Note
              AppTextField(
                controller: _noteController,
                label: 'Ghi chú',
                hint: 'Ghi chú về khách hàng',
                prefixIcon: Icons.note_outlined,
                maxLines: 3,
              ),

              // Show debt info if editing
              if (_isEditing && _existingCustomer != null) ...[
                const SizedBox(height: 24),
                AppCard(
                  child: Row(
                    children: [
                      Icon(
                        Icons.account_balance_wallet_outlined,
                        color: _existingCustomer!.totalDebt > 0
                            ? AppColors.warning
                            : AppColors.success,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Công nợ hiện tại',
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              '${_existingCustomer!.totalDebt.toStringAsFixed(0)}₫',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: _existingCustomer!.totalDebt > 0
                                    ? AppColors.warning
                                    : AppColors.success,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 32),

              // Save button
              AppButton(
                text: _isEditing ? 'Lưu thay đổi' : 'Thêm khách hàng',
                onPressed: _saveCustomer,
                isLoading: _isLoading,
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmDelete() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xóa khách hàng'),
        content: const Text('Bạn có chắc muốn xóa khách hàng này?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              if (widget.customerId != null) {
                await ref
                    .read(customersProvider.notifier)
                    .deleteCustomer(widget.customerId!);
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
