import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/customer.dart';

part 'customers_state.freezed.dart';

@freezed
abstract class CustomersState with _$CustomersState {
  const factory CustomersState({
    @Default(true) bool isLoading,
    @Default([]) List<Customer> customers,
    @Default('') String searchQuery,
    String? errorMessage,
  }) = _CustomersState;

  factory CustomersState.initial() => const CustomersState();
}
