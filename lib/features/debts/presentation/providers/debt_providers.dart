import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/database/app_database.dart';
import '../../data/dao/debt_dao.dart';

final getIt = GetIt.instance;

/// Debt DAO provider
final debtDaoProvider = Provider<DebtDao>((ref) {
  return getIt<DebtDao>();
});

/// Debts list notifier (Riverpod 3.0 pattern)
class DebtsNotifier extends Notifier<AsyncValue<List<Debt>>> {
  late DebtDao _dao;

  @override
  AsyncValue<List<Debt>> build() {
    _dao = ref.watch(debtDaoProvider);
    _loadDebts();
    return const AsyncValue.loading();
  }

  Future<void> _loadDebts() async {
    state = const AsyncValue.loading();
    try {
      final debts = await _dao.getAllDebts();
      state = AsyncValue.data(debts);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() => _loadDebts();

  Future<void> loadUnpaidOnly() async {
    state = const AsyncValue.loading();
    try {
      final debts = await _dao.getUnpaidDebts();
      state = AsyncValue.data(debts);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> loadByCustomer(int customerId) async {
    state = const AsyncValue.loading();
    try {
      final debts = await _dao.getDebtsByCustomer(customerId);
      state = AsyncValue.data(debts);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

/// Debts list provider
final debtsProvider = NotifierProvider<DebtsNotifier, AsyncValue<List<Debt>>>(
  DebtsNotifier.new,
);

/// Show unpaid only filter (Riverpod 3.0 pattern)
class ShowUnpaidOnlyNotifier extends Notifier<bool> {
  @override
  bool build() => true; // Default to showing unpaid only

  void toggle() => state = !state;
  void setFilter(bool value) => state = value;
}

/// Show unpaid only filter provider
final showUnpaidOnlyProvider = NotifierProvider<ShowUnpaidOnlyNotifier, bool>(
  ShowUnpaidOnlyNotifier.new,
);

/// Total unpaid debt notifier (Riverpod 3.0 pattern)
class TotalUnpaidDebtNotifier extends Notifier<AsyncValue<double>> {
  late DebtDao _dao;

  @override
  AsyncValue<double> build() {
    _dao = ref.watch(debtDaoProvider);
    _loadTotal();
    return const AsyncValue.loading();
  }

  Future<void> _loadTotal() async {
    state = const AsyncValue.loading();
    try {
      final total = await _dao.getTotalUnpaidDebt();
      state = AsyncValue.data(total);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() => _loadTotal();
}

/// Total unpaid debt provider
final totalUnpaidDebtProvider =
    NotifierProvider<TotalUnpaidDebtNotifier, AsyncValue<double>>(
      TotalUnpaidDebtNotifier.new,
    );

/// Selected debt for payment (Riverpod 3.0 pattern)
class SelectedDebtNotifier extends Notifier<Debt?> {
  @override
  Debt? build() => null;

  void select(Debt debt) => state = debt;
  void clear() => state = null;
}

/// Selected debt provider
final selectedDebtProvider = NotifierProvider<SelectedDebtNotifier, Debt?>(
  SelectedDebtNotifier.new,
);
