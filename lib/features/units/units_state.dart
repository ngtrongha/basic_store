import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/unit.dart';

part 'units_state.freezed.dart';

@freezed
abstract class UnitsState with _$UnitsState {
  const factory UnitsState({
    @Default(true) bool isLoading,
    @Default([]) List<Unit> units,
    @Default('') String searchQuery,
    String? errorMessage,
  }) = _UnitsState;

  factory UnitsState.initial() => const UnitsState();
}
