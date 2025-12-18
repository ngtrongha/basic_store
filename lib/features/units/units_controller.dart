import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/unit.dart';
import '../../data/repositories/unit_repository.dart';
import '../../di/injection.dart';
import 'units_state.dart';

final unitsControllerProvider = NotifierProvider<UnitsController, UnitsState>(
  UnitsController.new,
);

class UnitsController extends Notifier<UnitsState> {
  UnitRepository get _repo => getIt<UnitRepository>();

  @override
  UnitsState build() {
    Future.microtask(_loadData);
    return UnitsState.initial();
  }

  Future<void> _loadData() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final units = await _repo.getAll(limit: 1000);
      state = state.copyWith(isLoading: false, units: units);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Không thể tải danh sách đơn vị',
      );
    }
  }

  Future<void> search(String query) async {
    state = state.copyWith(searchQuery: query);

    try {
      final units = query.isEmpty
          ? await _repo.getAll(limit: 1000)
          : await _repo.search(query: query, limit: 500);
      state = state.copyWith(units: units);
    } catch (e) {
      // Keep existing units on search error
    }
  }

  Future<void> createUnit(String name) async {
    if (name.trim().isEmpty) return;

    try {
      final unit = Unit()
        ..name = name.trim()
        ..key = UnitRepository.normalizeKey(name)
        ..isActive = true
        ..createdAt = DateTime.now();

      await _repo.create(unit);
      await refresh();
    } catch (e) {
      state = state.copyWith(errorMessage: 'Không thể tạo đơn vị');
    }
  }

  Future<void> updateUnit(Unit unit) async {
    try {
      await _repo.upsert(unit);
      await refresh();
    } catch (e) {
      state = state.copyWith(errorMessage: 'Không thể cập nhật đơn vị');
    }
  }

  Future<void> deleteUnit(int unitId) async {
    try {
      await _repo.deleteById(unitId);
      await refresh();
    } catch (e) {
      state = state.copyWith(errorMessage: 'Không thể xóa đơn vị');
    }
  }

  Future<void> toggleActive(Unit unit) async {
    final updated = Unit()
      ..id = unit.id
      ..name = unit.name
      ..key = unit.key
      ..isActive = !unit.isActive
      ..createdAt = unit.createdAt;
    await updateUnit(updated);
  }

  Future<void> refresh() async {
    await _loadData();
    if (state.searchQuery.isNotEmpty) {
      await search(state.searchQuery);
    }
  }
}
