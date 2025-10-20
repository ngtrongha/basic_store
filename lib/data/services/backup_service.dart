import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import 'database_service.dart';

class BackupService {
  static const String _backupFileName = 'basic_store_backup.isar';

  static Future<File> exportBackup() async {
    final appDir = await getApplicationDocumentsDirectory();
    final backupPath = '${appDir.path}/$_backupFileName';
    final file = File(backupPath);

    final isar = DatabaseService.instance.isar;
    await isar.copyToFile(backupPath);

    return file;
  }

  static Future<void> shareBackup() async {
    final file = await exportBackup();
    await Share.shareXFiles([XFile(file.path)], text: 'Basic Store backup');
  }

  static Future<void> importBackup(File backupFile) async {
    final isar = DatabaseService.instance.isar;
    final dir = await getApplicationDocumentsDirectory();
    final targetPath = '${dir.path}/default.isar';

    // Close DB and replace file
    await isar.close();

    final targetFile = File(targetPath);
    if (await targetFile.exists()) {
      await targetFile.delete();
    }
    await backupFile.copy(targetPath);

    // Reopen DB
    await DatabaseService.instance.reopen();
  }
}
