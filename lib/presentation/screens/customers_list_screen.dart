import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/customer.dart';
import '../../features/customers/customers_controller.dart';
import '../../l10n/app_localizations.dart';

@RoutePage()
class CustomersListScreen extends ConsumerStatefulWidget {
  const CustomersListScreen({super.key});

  @override
  ConsumerState<CustomersListScreen> createState() =>
      _CustomersListScreenState();
}

class _CustomersListScreenState extends ConsumerState<CustomersListScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(customersControllerProvider);
    final controller = ref.read(customersControllerProvider.notifier);
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          _buildAppBar(context, state, controller, l10n, colorScheme),
        ],
        body: state.isLoading
            ? _buildLoadingState(colorScheme)
            : state.customers.isEmpty
            ? _buildEmptyState(colorScheme, l10n)
            : _buildCustomerList(context, state, controller, colorScheme, l10n),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddCustomerDialog(context, controller, l10n),
        icon: const Icon(Icons.person_add_rounded),
        label: const Text('Thêm KH'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
    );
  }

  Widget _buildAppBar(
    BuildContext context,
    dynamic state,
    CustomersController controller,
    AppLocalizations l10n,
    ColorScheme colorScheme,
  ) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      expandedHeight: 140,
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
            child: const Icon(Icons.people_rounded, size: 24),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.customers,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${state.customers.length} khách hàng',
                style: TextStyle(
                  fontSize: 12,
                  color: colorScheme.onPrimary.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ],
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [colorScheme.primary, colorScheme.primaryContainer],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 60, 16, 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Search Bar
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: controller.search,
                      decoration: InputDecoration(
                        hintText: 'Tìm kiếm khách hàng...',
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          color: colorScheme.primary,
                        ),
                        suffixIcon: state.searchQuery.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.close_rounded),
                                onPressed: () {
                                  _searchController.clear();
                                  controller.search('');
                                },
                              )
                            : null,
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
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
            'Đang tải khách hàng...',
            style: TextStyle(color: colorScheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(ColorScheme colorScheme, AppLocalizations l10n) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.people_outline_rounded,
              size: 48,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Chưa có khách hàng',
            style: TextStyle(fontSize: 16, color: colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 8),
          Text(
            'Nhấn + để thêm khách hàng mới',
            style: TextStyle(
              fontSize: 14,
              color: colorScheme.onSurfaceVariant.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerList(
    BuildContext context,
    dynamic state,
    CustomersController controller,
    ColorScheme colorScheme,
    AppLocalizations l10n,
  ) {
    return RefreshIndicator(
      onRefresh: controller.refresh,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: state.customers.length,
        itemBuilder: (context, index) {
          final customer = state.customers[index];
          return _buildCustomerCard(
            context,
            customer,
            controller,
            colorScheme,
            l10n,
            index,
          );
        },
      ),
    );
  }

  Widget _buildCustomerCard(
    BuildContext context,
    Customer customer,
    CustomersController controller,
    ColorScheme colorScheme,
    AppLocalizations l10n,
    int index,
  ) {
    final tierColor = _getTierColor(customer.tier);

    return Container(
      margin: EdgeInsets.only(bottom: index < 100 ? 12 : 0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.outlineVariant.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _showCustomerDetails(
            context,
            customer,
            controller,
            colorScheme,
            l10n,
          ),
          onLongPress: () => _showCustomerOptions(
            context,
            customer,
            controller,
            colorScheme,
            l10n,
          ),
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Avatar
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        tierColor.withOpacity(0.8),
                        tierColor.withOpacity(0.6),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      customer.name.isNotEmpty
                          ? customer.name[0].toUpperCase()
                          : '?',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              customer.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          // Tier badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: tierColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: tierColor.withOpacity(0.3),
                              ),
                            ),
                            child: Text(
                              customer.tier ?? 'Bronze',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: tierColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      // Contact info
                      if (customer.phone != null || customer.email != null)
                        Row(
                          children: [
                            if (customer.phone != null) ...[
                              Icon(
                                Icons.phone_outlined,
                                size: 14,
                                color: colorScheme.onSurfaceVariant,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                customer.phone!,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                              if (customer.email != null) ...[
                                const SizedBox(width: 12),
                              ],
                            ],
                            if (customer.email != null) ...[
                              Icon(
                                Icons.email_outlined,
                                size: 14,
                                color: colorScheme.onSurfaceVariant,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  customer.email!,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ],
                        ),
                      const SizedBox(height: 6),
                      // Points
                      Row(
                        children: [
                          Icon(
                            Icons.stars_rounded,
                            size: 16,
                            color: Colors.amber,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${customer.points} điểm',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Arrow
                Icon(
                  Icons.chevron_right_rounded,
                  color: colorScheme.onSurfaceVariant.withOpacity(0.5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getTierColor(String? tier) {
    switch (tier?.toLowerCase()) {
      case 'gold':
        return Colors.amber;
      case 'silver':
        return Colors.blueGrey;
      case 'platinum':
        return Colors.purple;
      default:
        return Colors.brown;
    }
  }

  void _showCustomerDetails(
    BuildContext context,
    Customer customer,
    CustomersController controller,
    ColorScheme colorScheme,
    AppLocalizations l10n,
  ) {
    final tierColor = _getTierColor(customer.tier);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
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
              const SizedBox(height: 24),
              // Avatar
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [tierColor, tierColor.withOpacity(0.7)],
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Center(
                  child: Text(
                    customer.name.isNotEmpty
                        ? customer.name[0].toUpperCase()
                        : '?',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                customer.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: tierColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.workspace_premium_rounded,
                      color: tierColor,
                      size: 18,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      customer.tier ?? 'Bronze',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: tierColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Stats
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildStatItem(
                        'Điểm tích lũy',
                        '${customer.points}',
                        Icons.stars_rounded,
                        Colors.amber,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Contact info
              if (customer.phone != null || customer.email != null)
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      if (customer.phone != null)
                        _buildContactRow(
                          Icons.phone_rounded,
                          customer.phone!,
                          colorScheme,
                        ),
                      if (customer.phone != null && customer.email != null)
                        const SizedBox(height: 12),
                      if (customer.email != null)
                        _buildContactRow(
                          Icons.email_rounded,
                          customer.email!,
                          colorScheme,
                        ),
                    ],
                  ),
                ),
              const SizedBox(height: 24),
              // Actions
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          _showEditCustomerDialog(
                            context,
                            customer,
                            controller,
                            l10n,
                          );
                        },
                        icon: const Icon(Icons.edit_rounded),
                        label: const Text('Sửa'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          _showAddPointsDialog(context, customer, controller);
                        },
                        icon: const Icon(Icons.add_rounded),
                        label: const Text('Thêm điểm'),
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom + 16),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatItem(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Column(
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildContactRow(
    IconData icon,
    String value,
    ColorScheme colorScheme,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 18, color: colorScheme.primary),
        ),
        const SizedBox(width: 12),
        Expanded(child: Text(value, style: const TextStyle(fontSize: 15))),
      ],
    );
  }

  void _showCustomerOptions(
    BuildContext context,
    Customer customer,
    CustomersController controller,
    ColorScheme colorScheme,
    AppLocalizations l10n,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
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
              const SizedBox(height: 8),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.edit_rounded, color: Colors.blue),
                ),
                title: const Text('Chỉnh sửa'),
                onTap: () {
                  Navigator.pop(context);
                  _showEditCustomerDialog(context, customer, controller, l10n);
                },
              ),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.add_rounded, color: Colors.green),
                ),
                title: const Text('Thêm điểm'),
                onTap: () {
                  Navigator.pop(context);
                  _showAddPointsDialog(context, customer, controller);
                },
              ),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.delete_rounded, color: Colors.red),
                ),
                title: const Text('Xóa khách hàng'),
                onTap: () async {
                  Navigator.pop(context);
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('Xác nhận xóa'),
                      content: Text('Bạn có chắc muốn xóa "${customer.name}"?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(ctx, false),
                          child: Text(l10n.cancel),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(ctx, true),
                          child: const Text(
                            'Xóa',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  );
                  if (confirm == true) {
                    await controller.deleteCustomer(customer.id);
                  }
                },
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom + 16),
            ],
          ),
        );
      },
    );
  }

  void _showAddCustomerDialog(
    BuildContext context,
    CustomersController controller,
    AppLocalizations l10n,
  ) {
    final nameCtrl = TextEditingController();
    final phoneCtrl = TextEditingController();
    final emailCtrl = TextEditingController();
    String selectedTier = 'Bronze';

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Row(
            children: [
              const Icon(Icons.person_add_rounded),
              const SizedBox(width: 12),
              Text(l10n.addCustomer),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameCtrl,
                  decoration: InputDecoration(
                    labelText: l10n.customerName,
                    prefixIcon: const Icon(Icons.person_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: phoneCtrl,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: l10n.customerPhone,
                    prefixIcon: const Icon(Icons.phone_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: l10n.customerEmail,
                    prefixIcon: const Icon(Icons.email_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: selectedTier,
                  decoration: InputDecoration(
                    labelText: 'Hạng thành viên',
                    prefixIcon: const Icon(Icons.workspace_premium_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  items: ['Bronze', 'Silver', 'Gold', 'Platinum']
                      .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                      .toList(),
                  onChanged: (v) => setDialogState(() => selectedTier = v!),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(l10n.cancel),
            ),
            FilledButton(
              onPressed: () async {
                if (nameCtrl.text.trim().isEmpty) return;
                final customer = Customer()
                  ..name = nameCtrl.text.trim()
                  ..phone = phoneCtrl.text.trim().isEmpty
                      ? null
                      : phoneCtrl.text.trim()
                  ..email = emailCtrl.text.trim().isEmpty
                      ? null
                      : emailCtrl.text.trim()
                  ..tier = selectedTier
                  ..points = 0;
                await controller.createCustomer(customer);
                if (context.mounted) Navigator.pop(ctx);
              },
              child: Text(l10n.save),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditCustomerDialog(
    BuildContext context,
    Customer customer,
    CustomersController controller,
    AppLocalizations l10n,
  ) {
    final nameCtrl = TextEditingController(text: customer.name);
    final phoneCtrl = TextEditingController(text: customer.phone ?? '');
    final emailCtrl = TextEditingController(text: customer.email ?? '');
    String selectedTier = customer.tier ?? 'Bronze';

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.edit_rounded),
              SizedBox(width: 12),
              Text('Chỉnh sửa khách hàng'),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameCtrl,
                  decoration: InputDecoration(
                    labelText: l10n.customerName,
                    prefixIcon: const Icon(Icons.person_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: phoneCtrl,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: l10n.customerPhone,
                    prefixIcon: const Icon(Icons.phone_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: l10n.customerEmail,
                    prefixIcon: const Icon(Icons.email_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: selectedTier,
                  decoration: InputDecoration(
                    labelText: 'Hạng thành viên',
                    prefixIcon: const Icon(Icons.workspace_premium_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  items: ['Bronze', 'Silver', 'Gold', 'Platinum']
                      .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                      .toList(),
                  onChanged: (v) => setDialogState(() => selectedTier = v!),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(l10n.cancel),
            ),
            FilledButton(
              onPressed: () async {
                if (nameCtrl.text.trim().isEmpty) return;
                customer
                  ..name = nameCtrl.text.trim()
                  ..phone = phoneCtrl.text.trim().isEmpty
                      ? null
                      : phoneCtrl.text.trim()
                  ..email = emailCtrl.text.trim().isEmpty
                      ? null
                      : emailCtrl.text.trim()
                  ..tier = selectedTier;
                await controller.updateCustomer(customer);
                if (context.mounted) Navigator.pop(ctx);
              },
              child: Text(l10n.save),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddPointsDialog(
    BuildContext context,
    Customer customer,
    CustomersController controller,
  ) {
    final pointsCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.stars_rounded, color: Colors.amber),
            SizedBox(width: 12),
            Text('Thêm điểm'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Thêm điểm cho ${customer.name}'),
            const SizedBox(height: 16),
            TextField(
              controller: pointsCtrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Số điểm',
                prefixIcon: const Icon(Icons.add_rounded),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Hủy'),
          ),
          FilledButton(
            onPressed: () async {
              final points = int.tryParse(pointsCtrl.text) ?? 0;
              if (points > 0) {
                await controller.addPoints(customer.id, points);
              }
              if (context.mounted) Navigator.pop(ctx);
            },
            child: const Text('Thêm'),
          ),
        ],
      ),
    );
  }
}
