import 'dart:io';

import 'package:share_plus/share_plus.dart';

import 'data_export_service.dart';

class BackupService {
  static Future<File> exportBackup() async {
    final file = await DataExportService().createFullJsonExportFile();
    return file;
  }

  static Future<void> shareBackup() async {
    final file = await exportBackup();
    await Share.shareXFiles([XFile(file.path)], text: 'Basic Store backup');
  }

  static Future<void> importBackup(File backupFile) async {
    // Import process for ObjectBox is not implemented yet.
    throw UnsupportedError(
      'Import backup is not available with the current ObjectBox persistence layer.',
    );
  }
}
