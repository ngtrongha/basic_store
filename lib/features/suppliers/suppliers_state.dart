import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/supplier.dart';

part 'suppliers_state.freezed.dart';

@freezed
abstract class SuppliersState with _$SuppliersState {
  const factory SuppliersState({
    @Default(true) bool isLoading,
    @Default([]) List<Supplier> suppliers,
    @Default('') String searchQuery,
    String? errorMessage,
  }) = _SuppliersState;

  factory SuppliersState.initial() => const SuppliersState();
}
