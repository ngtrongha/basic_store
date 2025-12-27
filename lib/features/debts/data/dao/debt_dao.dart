import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/database/app_database.dart';

part 'debt_dao.g.dart';

/// Data Access Object for Debts
@lazySingleton
@DriftAccessor(tables: [Debts, DebtPayments, Customers])
class DebtDao extends DatabaseAccessor<AppDatabase> with _$DebtDaoMixin {
  DebtDao(super.db);

  /// Get all debts
  Future<List<Debt>> getAllDebts() {
    return (select(
      debts,
    )..orderBy([(d) => OrderingTerm.desc(d.createdAt)])).get();
  }

  /// Get unpaid debts only
  Future<List<Debt>> getUnpaidDebts() {
    return (select(debts)
          ..where((d) => d.isPaid.equals(false))
          ..orderBy([(d) => OrderingTerm.desc(d.createdAt)]))
        .get();
  }

  /// Get debts by customer
  Future<List<Debt>> getDebtsByCustomer(int customerId) {
    return (select(debts)
          ..where((d) => d.customerId.equals(customerId))
          ..orderBy([(d) => OrderingTerm.desc(d.createdAt)]))
        .get();
  }

  /// Get debt by ID
  Future<Debt?> getDebtById(int id) {
    return (select(debts)..where((d) => d.id.equals(id))).getSingleOrNull();
  }

  /// Create debt
  Future<int> createDebt({
    required int customerId,
    int? orderId,
    required double amount,
    String? note,
    DateTime? dueDate,
  }) async {
    return into(debts).insert(
      DebtsCompanion.insert(
        customerId: customerId,
        orderId: Value(orderId),
        amount: amount,
        remainingAmount: amount,
        note: Value(note),
        dueDate: Value(dueDate),
      ),
    );
  }

  /// Record debt payment
  Future<void> recordPayment({
    required int debtId,
    required double amount,
    String paymentMethod = 'cash',
    String? note,
  }) async {
    await transaction(() async {
      // Get current debt
      final debt = await getDebtById(debtId);
      if (debt == null) return;

      // Insert payment record
      await into(debtPayments).insert(
        DebtPaymentsCompanion.insert(
          debtId: debtId,
          amount: amount,
          paymentMethod: Value(paymentMethod),
          note: Value(note),
        ),
      );

      // Update debt
      final newPaidAmount = debt.paidAmount + amount;
      final newRemainingAmount = debt.amount - newPaidAmount;
      final isPaid = newRemainingAmount <= 0;

      await (update(debts)..where((d) => d.id.equals(debtId))).write(
        DebtsCompanion(
          paidAmount: Value(newPaidAmount),
          remainingAmount: Value(
            newRemainingAmount < 0 ? 0 : newRemainingAmount,
          ),
          isPaid: Value(isPaid),
          paidAt: isPaid ? Value(DateTime.now()) : const Value.absent(),
        ),
      );

      // Update customer total debt
      final customerDebts = await getDebtsByCustomer(debt.customerId);
      double totalDebt = 0.0;
      for (final d in customerDebts) {
        totalDebt += (d.id == debtId ? newRemainingAmount : d.remainingAmount);
      }
      await (update(
        customers,
      )..where((c) => c.id.equals(debt.customerId))).write(
        CustomersCompanion(totalDebt: Value(totalDebt < 0 ? 0 : totalDebt)),
      );
    });
  }

  /// Get payment history for a debt
  Future<List<DebtPayment>> getPaymentHistory(int debtId) {
    return (select(debtPayments)
          ..where((p) => p.debtId.equals(debtId))
          ..orderBy([(p) => OrderingTerm.desc(p.createdAt)]))
        .get();
  }

  /// Get total unpaid debt amount
  Future<double> getTotalUnpaidDebt() async {
    final unpaidDebts = await getUnpaidDebts();
    double total = 0.0;
    for (final debt in unpaidDebts) {
      total += debt.remainingAmount;
    }
    return total;
  }

  /// Watch all debts (stream)
  Stream<List<Debt>> watchAllDebts() {
    return (select(
      debts,
    )..orderBy([(d) => OrderingTerm.desc(d.createdAt)])).watch();
  }

  /// Watch unpaid debts (stream)
  Stream<List<Debt>> watchUnpaidDebts() {
    return (select(debts)
          ..where((d) => d.isPaid.equals(false))
          ..orderBy([(d) => OrderingTerm.desc(d.createdAt)]))
        .watch();
  }
}
