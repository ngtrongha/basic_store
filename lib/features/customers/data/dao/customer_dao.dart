import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/database/app_database.dart';

part 'customer_dao.g.dart';

/// Data Access Object for Customers
@lazySingleton
@DriftAccessor(tables: [Customers])
class CustomerDao extends DatabaseAccessor<AppDatabase>
    with _$CustomerDaoMixin {
  CustomerDao(super.db);

  /// Get all customers
  Future<List<Customer>> getAllCustomers() => select(customers).get();

  /// Get customers with optional search
  Future<List<Customer>> getCustomers({String? searchQuery}) {
    final query = select(customers);

    if (searchQuery != null && searchQuery.isNotEmpty) {
      query.where(
        (c) => c.name.like('%$searchQuery%') | c.phone.like('%$searchQuery%'),
      );
    }

    return query.get();
  }

  /// Get customer by ID
  Future<Customer?> getCustomerById(int id) {
    return (select(customers)..where((c) => c.id.equals(id))).getSingleOrNull();
  }

  /// Get customers with debt
  Future<List<Customer>> getCustomersWithDebt() {
    return (select(
      customers,
    )..where((c) => c.totalDebt.isBiggerThanValue(0))).get();
  }

  /// Insert customer
  Future<int> insertCustomer(CustomersCompanion customer) {
    return into(customers).insert(customer);
  }

  /// Update customer
  Future<bool> updateCustomer(Customer customer) {
    return update(customers).replace(customer);
  }

  /// Delete customer
  Future<int> deleteCustomer(int id) {
    return (delete(customers)..where((c) => c.id.equals(id))).go();
  }

  /// Watch all customers (stream)
  Stream<List<Customer>> watchAllCustomers() => select(customers).watch();

  /// Update customer debt
  Future<void> updateCustomerDebt(int customerId, double newDebt) async {
    await (update(customers)..where((c) => c.id.equals(customerId))).write(
      CustomersCompanion(totalDebt: Value(newDebt)),
    );
  }
}
