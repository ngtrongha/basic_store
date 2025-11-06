import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

import '../../data/repositories/audit_log_repository.dart';
import '../../data/models/audit_log.dart';
import '../../data/services/auth_service.dart';
import '../../data/models/user.dart';

class AuditLogScreen extends StatefulWidget {
  const AuditLogScreen({super.key});

  @override
  State<AuditLogScreen> createState() => _AuditLogScreenState();
}

class _AuditLogScreenState extends State<AuditLogScreen> {
  final _repo = AuditLogRepository();
  List<AuditLog> _logs = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _guardAndLoad();
  }

  Future<void> _guardAndLoad() async {
    final allowed = await AuthService().hasRole(UserRole.manager);
    if (!allowed && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.warning)),
      );
      Navigator.of(context).pop();
      return;
    }
    _loadLogs();
  }

  Future<void> _loadLogs() async {
    setState(() => _loading = true);
    try {
      final logs = await _repo.list(limit: 200);
      if (mounted) setState(() => _logs = logs);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.auditLog),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _loadLogs),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _logs.isEmpty
          ? Center(child: Text(AppLocalizations.of(context)!.noData))
          : ListView.builder(
              itemCount: _logs.length,
              itemBuilder: (context, i) {
                final log = _logs[i];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        (log.userId?.toString() ?? '?').substring(0, 1),
                      ),
                    ),
                    title: Text(log.action),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'User: ${log.userId ?? '-'} • ${_formatTime(log.createdAt)}',
                        ),
                        if (log.details?.isNotEmpty == true) Text(log.details!),
                      ],
                    ),
                    isThreeLine: log.details?.isNotEmpty == true,
                  ),
                );
              },
            ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final diff = now.difference(time);
    if (diff.inDays > 0) return '${diff.inDays} ngày trước';
    if (diff.inHours > 0) return '${diff.inHours} giờ trước';
    if (diff.inMinutes > 0) return '${diff.inMinutes} phút trước';
    return 'Vừa xong';
  }
}
