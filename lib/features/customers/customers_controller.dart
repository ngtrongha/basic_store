import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/customer.dart';
import '../../data/repositories/customer_repository.dart';
import '../../di/injection.dart';
import 'customers_state.dart';

final customersControllerProvider =
    NotifierProvider<CustomersController, CustomersState>(
      CustomersController.new,
    );

class CustomersController extends Notifier<CustomersState> {
  CustomerRepository get _repo => getIt<CustomerRepository>();

  @override
  CustomersState build() {
    Future.microtask(_loadData);
    return CustomersState.initial();
  }

  Future<void> _loadData() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final customers = state.searchQuery.isEmpty
          ? await _repo.getAll(limit: 500)
          : await _repo.search(query: state.searchQuery, limit: 500);

      state = state.copyWith(isLoading: false, customers: customers);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Không thể tải danh sách khách hàng',
      );
    }
  }

  Future<void> search(String query) async {
    state = state.copyWith(searchQuery: query);
    await _loadData();
  }

  Future<void> createCustomer(Customer customer) async {
    await _repo.create(customer);
    await refresh();
  }

  Future<void> updateCustomer(Customer customer) async {
    await _repo.create(customer);
    await refresh();
  }

  Future<void> deleteCustomer(int customerId) async {
    await _repo.deleteById(customerId);
    await refresh();
  }

  Future<void> addPoints(int customerId, int points) async {
    await _repo.addPoints(customerId, points);
    await refresh();
  }

  Future<void> refresh() async {
    await _loadData();
  }
}
