import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/services/backup_service.dart';

final getIt = GetIt.instance;

/// Backup service provider
final backupServiceProvider = Provider<BackupService>((ref) {
  return getIt<BackupService>();
});

/// Backup status enum
enum BackupStatus { idle, backing, restoring, success, error }

/// Backup state notifier (Riverpod 3.0 pattern)
class BackupNotifier extends Notifier<BackupState> {
  late BackupService _service;

  @override
  BackupState build() {
    _service = ref.watch(backupServiceProvider);
    _loadInitialState();
    return const BackupState();
  }

  Future<void> _loadInitialState() async {
    final lastBackup = await _service.getLastBackupTime();
    final hasBackup = await _service.hasLocalBackup();
    state = state.copyWith(
      lastBackupTime: lastBackup,
      hasLocalBackup: hasBackup,
    );
  }

  Future<void> refresh() => _loadInitialState();

  Future<bool> createBackup() async {
    state = state.copyWith(status: BackupStatus.backing);
    try {
      await _service.saveBackupToFile();
      final lastBackup = await _service.getLastBackupTime();
      state = state.copyWith(
        status: BackupStatus.success,
        lastBackupTime: lastBackup,
        hasLocalBackup: true,
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        status: BackupStatus.error,
        errorMessage: e.toString(),
      );
      return false;
    }
  }

  Future<bool> restoreBackup() async {
    state = state.copyWith(status: BackupStatus.restoring);
    try {
      final success = await _service.restoreFromFile();
      state = state.copyWith(
        status: success ? BackupStatus.success : BackupStatus.error,
        errorMessage: success ? null : 'Không tìm thấy file backup',
      );
      return success;
    } catch (e) {
      state = state.copyWith(
        status: BackupStatus.error,
        errorMessage: e.toString(),
      );
      return false;
    }
  }

  void resetStatus() {
    state = state.copyWith(status: BackupStatus.idle, errorMessage: null);
  }
}

/// Backup provider
final backupProvider = NotifierProvider<BackupNotifier, BackupState>(
  BackupNotifier.new,
);

/// Backup state
class BackupState {
  final BackupStatus status;
  final DateTime? lastBackupTime;
  final bool hasLocalBackup;
  final String? errorMessage;

  const BackupState({
    this.status = BackupStatus.idle,
    this.lastBackupTime,
    this.hasLocalBackup = false,
    this.errorMessage,
  });

  BackupState copyWith({
    BackupStatus? status,
    DateTime? lastBackupTime,
    bool? hasLocalBackup,
    String? errorMessage,
  }) {
    return BackupState(
      status: status ?? this.status,
      lastBackupTime: lastBackupTime ?? this.lastBackupTime,
      hasLocalBackup: hasLocalBackup ?? this.hasLocalBackup,
      errorMessage: errorMessage,
    );
  }
}
