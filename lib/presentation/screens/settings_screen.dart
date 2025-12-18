import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/services/backup_service.dart';
import '../../data/services/locale_service.dart';
import '../../data/services/settings_service.dart';
import '../../l10n/app_localizations.dart';
import '../../router/app_router.dart';

@RoutePage()
class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final _storeNameCtrl = TextEditingController();
  final _storeAddressCtrl = TextEditingController();
  final _storePhoneCtrl = TextEditingController();
  final _vatCtrl = TextEditingController();
  final _serviceFeeCtrl = TextEditingController();
  final _currencyCtrl = TextEditingController();
  final _decimalCtrl = TextEditingController();
  final _footerCtrl = TextEditingController();

  bool _vatInclusive = true;
  bool _darkMode = false;
  String _currentLocale = 'vi';
  String? _logoPath;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAllSettings();
  }

  @override
  void dispose() {
    _storeNameCtrl.dispose();
    _storeAddressCtrl.dispose();
    _storePhoneCtrl.dispose();
    _vatCtrl.dispose();
    _serviceFeeCtrl.dispose();
    _currencyCtrl.dispose();
    _decimalCtrl.dispose();
    _footerCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadAllSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final locale = await LocaleService.getLocaleCode();
    final currency = await SettingsService.getCurrencyCode();
    final digits = await SettingsService.getDecimalDigits();
    final footer = await SettingsService.getReceiptFooter();
    final logo = await SettingsService.getLogoPath();
    final dark = await SettingsService.getDarkModeEnabled();

    setState(() {
      _storeNameCtrl.text = prefs.getString('store_name') ?? 'Basic Store';
      _storeAddressCtrl.text = prefs.getString('store_address') ?? '';
      _storePhoneCtrl.text = prefs.getString('store_phone') ?? '';
      _vatCtrl.text = (prefs.getDouble('vat_rate_percent') ?? 0).toString();
      _serviceFeeCtrl.text = (prefs.getDouble('service_fee_percent') ?? 0)
          .toString();
      _vatInclusive = prefs.getBool('vat_inclusive') ?? true;
      _currencyCtrl.text = currency;
      _decimalCtrl.text = digits.toString();
      _footerCtrl.text = footer;
      _logoPath = logo;
      _darkMode = dark;
      _currentLocale = locale;
      _isLoading = false;
    });
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('store_name', _storeNameCtrl.text.trim());
    await prefs.setString('store_address', _storeAddressCtrl.text.trim());
    await prefs.setString('store_phone', _storePhoneCtrl.text.trim());

    final vat = double.tryParse(_vatCtrl.text.trim()) ?? 0;
    final fee = double.tryParse(_serviceFeeCtrl.text.trim()) ?? 0;
    await prefs.setDouble('vat_rate_percent', vat);
    await prefs.setBool('vat_inclusive', _vatInclusive);
    await prefs.setDouble('service_fee_percent', fee);

    await SettingsService.setCurrencyCode(
      _currencyCtrl.text.trim().toUpperCase(),
    );
    await SettingsService.setDecimalDigits(
      int.tryParse(_decimalCtrl.text.trim()) ?? 0,
    );
    await SettingsService.setReceiptFooter(_footerCtrl.text);
    await SettingsService.setLogoPath(_logoPath);
    await SettingsService.setDarkModeEnabled(_darkMode);

    if (!mounted) return;
    _showSuccessSnackbar('Đã lưu cài đặt');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: _isLoading
          ? Center(child: CircularProgressIndicator(color: colorScheme.primary))
          : CustomScrollView(
              slivers: [
                _buildAppBar(context, l10n, colorScheme),
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      _buildStoreSection(context, l10n, colorScheme),
                      const SizedBox(height: 20),
                      _buildTaxSection(context, l10n, colorScheme),
                      const SizedBox(height: 20),
                      _buildAppearanceSection(context, l10n, colorScheme),
                      const SizedBox(height: 20),
                      _buildRegionalSection(context, l10n, colorScheme),
                      const SizedBox(height: 20),
                      _buildReceiptSection(context, l10n, colorScheme),
                      const SizedBox(height: 20),
                      _buildBackupSection(context, l10n, colorScheme),
                      const SizedBox(height: 20),
                      _buildAdvancedSection(context, l10n, colorScheme),
                      const SizedBox(height: 32),
                    ]),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildAppBar(
    BuildContext context,
    AppLocalizations l10n,
    ColorScheme colorScheme,
  ) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      expandedHeight: 120,
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.settings_rounded, size: 24),
          ),
          const SizedBox(width: 12),
          Text(l10n.settings),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.bug_report_rounded),
          tooltip: 'Logs',
          onPressed: () => context.router.push(const TalkerLogsRoute()),
        ),
        Container(
          margin: const EdgeInsets.only(right: 8),
          child: FilledButton.tonal(
            onPressed: _saveSettings,
            style: FilledButton.styleFrom(
              backgroundColor: Colors.white.withOpacity(0.2),
              foregroundColor: Colors.white,
            ),
            child: Text(l10n.save),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [colorScheme.primary, colorScheme.primaryContainer],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required Color iconColor,
    required List<Widget> children,
    required ColorScheme colorScheme,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colorScheme.outlineVariant.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: iconColor, size: 22),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          ...children,
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: colorScheme.primary),
          filled: true,
          fillColor: colorScheme.surfaceContainerHighest.withOpacity(0.5),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required IconData icon,
    required Color iconColor,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: iconColor, size: 20),
      ),
      title: Text(title),
      subtitle: Text(
        subtitle,
        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
      ),
      trailing: Switch.adaptive(value: value, onChanged: onChanged),
    );
  }

  Widget _buildStoreSection(
    BuildContext context,
    AppLocalizations l10n,
    ColorScheme colorScheme,
  ) {
    return _buildSectionCard(
      title: 'Thông tin cửa hàng',
      icon: Icons.store_rounded,
      iconColor: Colors.blue,
      colorScheme: colorScheme,
      children: [
        _buildTextField(
          controller: _storeNameCtrl,
          label: l10n.storeName,
          icon: Icons.storefront_rounded,
        ),
        _buildTextField(
          controller: _storeAddressCtrl,
          label: l10n.storeAddress,
          icon: Icons.location_on_rounded,
        ),
        _buildTextField(
          controller: _storePhoneCtrl,
          label: l10n.storePhone,
          icon: Icons.phone_rounded,
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildTaxSection(
    BuildContext context,
    AppLocalizations l10n,
    ColorScheme colorScheme,
  ) {
    return _buildSectionCard(
      title: 'Thuế & Phí',
      icon: Icons.receipt_long_rounded,
      iconColor: Colors.orange,
      colorScheme: colorScheme,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _vatCtrl,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: '${l10n.vat} (%)',
                    prefixIcon: Icon(
                      Icons.percent_rounded,
                      color: colorScheme.primary,
                    ),
                    filled: true,
                    fillColor: colorScheme.surfaceContainerHighest.withOpacity(
                      0.5,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: _serviceFeeCtrl,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: '${l10n.serviceFee} (%)',
                    prefixIcon: Icon(
                      Icons.room_service_rounded,
                      color: colorScheme.primary,
                    ),
                    filled: true,
                    fillColor: colorScheme.surfaceContainerHighest.withOpacity(
                      0.5,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        _buildSwitchTile(
          title: 'VAT đã bao gồm',
          subtitle: 'Giá bán đã bao gồm thuế VAT',
          value: _vatInclusive,
          onChanged: (v) => setState(() => _vatInclusive = v),
          icon: Icons.price_check_rounded,
          iconColor: Colors.orange,
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildAppearanceSection(
    BuildContext context,
    AppLocalizations l10n,
    ColorScheme colorScheme,
  ) {
    return _buildSectionCard(
      title: 'Giao diện',
      icon: Icons.palette_rounded,
      iconColor: Colors.purple,
      colorScheme: colorScheme,
      children: [
        _buildSwitchTile(
          title: l10n.darkMode,
          subtitle: 'Bật chế độ tối cho ứng dụng',
          value: _darkMode,
          onChanged: (v) async {
            setState(() => _darkMode = v);
            await SettingsService.setDarkModeEnabled(v);
            if (!mounted) return;
            _showSuccessSnackbar('Đã ${v ? 'bật' : 'tắt'} chế độ tối');
          },
          icon: Icons.dark_mode_rounded,
          iconColor: Colors.purple,
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildRegionalSection(
    BuildContext context,
    AppLocalizations l10n,
    ColorScheme colorScheme,
  ) {
    return _buildSectionCard(
      title: 'Khu vực & Tiền tệ',
      icon: Icons.language_rounded,
      iconColor: Colors.teal,
      colorScheme: colorScheme,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _currencyCtrl,
                  decoration: InputDecoration(
                    labelText: l10n.currency,
                    prefixIcon: Icon(
                      Icons.attach_money_rounded,
                      color: colorScheme.primary,
                    ),
                    filled: true,
                    fillColor: colorScheme.surfaceContainerHighest.withOpacity(
                      0.5,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: _decimalCtrl,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: l10n.decimalDigits,
                    prefixIcon: Icon(
                      Icons.pin_rounded,
                      color: colorScheme.primary,
                    ),
                    filled: true,
                    fillColor: colorScheme.surfaceContainerHighest.withOpacity(
                      0.5,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        ListTile(
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.teal.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.translate_rounded,
              color: Colors.teal,
              size: 20,
            ),
          ),
          title: Text(l10n.locale),
          subtitle: Text(
            _currentLocale == 'vi' ? 'Tiếng Việt' : 'English',
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
          trailing: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButton<String>(
              value: _currentLocale,
              underline: const SizedBox(),
              borderRadius: BorderRadius.circular(12),
              items: const [
                DropdownMenuItem(value: 'vi', child: Text('🇻🇳 Tiếng Việt')),
                DropdownMenuItem(value: 'en', child: Text('🇺🇸 English')),
              ],
              onChanged: (value) async {
                if (value != null) {
                  setState(() => _currentLocale = value);
                  await LocaleService.setLocaleCode(value);
                  if (mounted) {
                    _showSuccessSnackbar('Đã đổi ngôn ngữ');
                  }
                }
              },
            ),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildReceiptSection(
    BuildContext context,
    AppLocalizations l10n,
    ColorScheme colorScheme,
  ) {
    return _buildSectionCard(
      title: 'Hóa đơn',
      icon: Icons.receipt_rounded,
      iconColor: Colors.green,
      colorScheme: colorScheme,
      children: [
        _buildTextField(
          controller: _footerCtrl,
          label: l10n.receiptFooter,
          icon: Icons.short_text_rounded,
        ),
        ListTile(
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.image_rounded,
              color: Colors.green,
              size: 20,
            ),
          ),
          title: Text(l10n.logo),
          subtitle: Text(
            _logoPath == null || _logoPath!.isEmpty
                ? 'Chưa chọn logo'
                : _logoPath!.split('/').last,
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
          trailing: OutlinedButton.icon(
            onPressed: () {
              setState(() {
                _logoPath = _logoPath == null ? '/path/to/logo.png' : null;
              });
            },
            icon: Icon(
              _logoPath == null ? Icons.add_rounded : Icons.close_rounded,
            ),
            label: Text(_logoPath == null ? 'Chọn' : 'Xóa'),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildBackupSection(
    BuildContext context,
    AppLocalizations l10n,
    ColorScheme colorScheme,
  ) {
    return _buildSectionCard(
      title: 'Sao lưu & Khôi phục',
      icon: Icons.cloud_sync_rounded,
      iconColor: Colors.indigo,
      colorScheme: colorScheme,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  icon: Icons.cloud_download_rounded,
                  label: l10n.exportBackup,
                  color: Colors.indigo,
                  onPressed: _exportBackup,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildActionButton(
                  icon: Icons.cloud_upload_rounded,
                  label: l10n.importBackup,
                  color: Colors.green,
                  onPressed: () => _importBackup(context, l10n),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAdvancedSection(
    BuildContext context,
    AppLocalizations l10n,
    ColorScheme colorScheme,
  ) {
    return _buildSectionCard(
      title: 'Nâng cao',
      icon: Icons.build_rounded,
      iconColor: Colors.grey,
      colorScheme: colorScheme,
      children: [
        ListTile(
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.bug_report_rounded,
              color: Colors.grey,
              size: 20,
            ),
          ),
          title: const Text('Nhật ký ứng dụng'),
          subtitle: Text(
            'Xem logs và debug',
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
          trailing: const Icon(Icons.chevron_right_rounded),
          onTap: () => context.router.push(const TalkerLogsRoute()),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14),
        side: BorderSide(color: color.withOpacity(0.5)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 8),
          Text(label, style: TextStyle(color: color)),
        ],
      ),
    );
  }

  Future<void> _exportBackup() async {
    try {
      await BackupService.shareBackup();
    } catch (e) {
      if (!mounted) return;
      _showErrorSnackbar('Lỗi xuất backup: $e');
    }
  }

  Future<void> _importBackup(
    BuildContext context,
    AppLocalizations l10n,
  ) async {
    final path = await showDialog<String>(
      context: context,
      builder: (ctx) {
        final ctrl = TextEditingController();
        final colorScheme = Theme.of(context).colorScheme;

        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.cloud_upload_rounded, color: colorScheme.primary),
              const SizedBox(width: 12),
              Text(l10n.importBackup),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Nhập đường dẫn tệp backup:'),
              const SizedBox(height: 16),
              TextField(
                controller: ctrl,
                decoration: InputDecoration(
                  hintText: '/storage/emulated/0/Download/backup.json',
                  prefixIcon: const Icon(Icons.folder_open_rounded),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text(l10n.cancel),
            ),
            FilledButton(
              onPressed: () => Navigator.of(ctx).pop(ctrl.text.trim()),
              child: const Text('Nhập'),
            ),
          ],
        );
      },
    );

    if (path == null || path.isEmpty) return;

    try {
      final file = File(path);
      if (!await file.exists()) {
        if (!mounted) return;
        _showErrorSnackbar(l10n.fileNotFound);
        return;
      }

      await BackupService.importBackup(file);
      if (!mounted) return;
      _showSuccessSnackbar(l10n.backupImported);

      Navigator.of(context).pushNamedAndRemoveUntil('/', (r) => false);
    } catch (e) {
      if (!mounted) return;
      _showErrorSnackbar('${l10n.backupError}: $e');
    }
  }

  void _showSuccessSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_rounded, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline_rounded, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
