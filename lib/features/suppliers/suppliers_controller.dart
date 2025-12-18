import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/supplier.dart';
import '../../data/repositories/supplier_repository.dart';
import '../../di/injection.dart';
import 'suppliers_state.dart';

final suppliersControllerProvider =
    NotifierProvider<SuppliersController, SuppliersState>(
      SuppliersController.new,
    );

class SuppliersController extends Notifier<SuppliersState> {
  SupplierRepository get _repo => getIt<SupplierRepository>();

  @override
  SuppliersState build() {
    Future.microtask(_loadData);
    return SuppliersState.initial();
  }

  Future<void> _loadData() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final suppliers = await _repo.search(limit: 200);
      state = state.copyWith(isLoading: false, suppliers: suppliers);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Không thể tải danh sách nhà cung cấp',
      );
    }
  }

  Future<void> search(String query) async {
    state = state.copyWith(searchQuery: query);

    try {
      final suppliers = await _repo.search(query: query, limit: 200);
      state = state.copyWith(suppliers: suppliers);
    } catch (e) {
      // Keep existing suppliers on search error
    }
  }

  Future<void> createSupplier(Supplier supplier) async {
    try {
      await _repo.create(supplier);
      await refresh();
    } catch (e) {
      state = state.copyWith(errorMessage: 'Không thể tạo nhà cung cấp');
    }
  }

  Future<void> updateSupplier(Supplier supplier) async {
    try {
      await _repo.update(supplier);
      await refresh();
    } catch (e) {
      state = state.copyWith(errorMessage: 'Không thể cập nhật nhà cung cấp');
    }
  }

  Future<void> deleteSupplier(int supplierId) async {
    try {
      await _repo.delete(supplierId);
      await refresh();
    } catch (e) {
      state = state.copyWith(errorMessage: 'Không thể xóa nhà cung cấp');
    }
  }

  Future<void> refresh() async {
    await _loadData();
    if (state.searchQuery.isNotEmpty) {
      await search(state.searchQuery);
    }
  }
}
