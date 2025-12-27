import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/di/injection.dart';
import '../../../../core/database/app_database.dart';
import '../../data/dao/customer_dao.dart';

/// Customer DAO provider
final customerDaoProvider = Provider<CustomerDao>((ref) {
  return getIt<CustomerDao>();
});

/// Customers list notifier (Riverpod 3.0 pattern)
class CustomersNotifier extends Notifier<AsyncValue<List<Customer>>> {
  late CustomerDao _dao;

  @override
  AsyncValue<List<Customer>> build() {
    _dao = ref.watch(customerDaoProvider);
    _loadCustomers();
    return const AsyncValue.loading();
  }

  Future<void> _loadCustomers() async {
    state = const AsyncValue.loading();
    try {
      final customers = await _dao.getAllCustomers();
      state = AsyncValue.data(customers);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() => _loadCustomers();

  Future<void> searchCustomers(String query) async {
    state = const AsyncValue.loading();
    try {
      final customers = await _dao.getCustomers(searchQuery: query);
      state = AsyncValue.data(customers);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> showOnlyWithDebt() async {
    state = const AsyncValue.loading();
    try {
      final customers = await _dao.getCustomersWithDebt();
      state = AsyncValue.data(customers);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<bool> deleteCustomer(int id) async {
    try {
      await _dao.deleteCustomer(id);
      await _loadCustomers();
      return true;
    } catch (e) {
      return false;
    }
  }
}

/// Customers list provider
final customersProvider =
    NotifierProvider<CustomersNotifier, AsyncValue<List<Customer>>>(
      CustomersNotifier.new,
    );

/// Customer search query notifier (Riverpod 3.0 pattern)
class CustomerSearchQueryNotifier extends Notifier<String> {
  @override
  String build() => '';

  void setQuery(String query) => state = query;
  void clear() => state = '';
}

/// Customer search query provider
final customerSearchQueryProvider =
    NotifierProvider<CustomerSearchQueryNotifier, String>(
      CustomerSearchQueryNotifier.new,
    );

/// Show only customers with debt filter (Riverpod 3.0 pattern)
class ShowDebtOnlyNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void toggle() => state = !state;
  void setFilter(bool value) => state = value;
}

/// Show debt only filter provider
final showDebtOnlyProvider = NotifierProvider<ShowDebtOnlyNotifier, bool>(
  ShowDebtOnlyNotifier.new,
);
