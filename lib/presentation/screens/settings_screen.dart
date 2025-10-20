import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/services/settings_service.dart';
import 'dart:io';
import '../../data/services/backup_service.dart';
import '../../data/services/locale_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _storeNameCtrl = TextEditingController();
  final _storeAddressCtrl = TextEditingController();
  final _storePhoneCtrl = TextEditingController();
  final _vatCtrl = TextEditingController();
  final _serviceFeeCtrl = TextEditingController();
  bool _vatInclusive = true;
  String _currentLocale = 'vi';
  bool _darkMode = false;
  final _currencyCtrl = TextEditingController();
  final _localeCtrl = TextEditingController();
  final _decimalCtrl = TextEditingController();
  final _footerCtrl = TextEditingController();
  String? _logoPath;

  @override
  void initState() {
    super.initState();
    _loadSettings();
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    final locale = await LocaleService.getLocaleCode();
    setState(() {
      _currentLocale = locale;
    });
  }

  @override
  void dispose() {
    _storeNameCtrl.dispose();
    _storeAddressCtrl.dispose();
    _storePhoneCtrl.dispose();
    _vatCtrl.dispose();
    _serviceFeeCtrl.dispose();
    _currencyCtrl.dispose();
    _localeCtrl.dispose();
    _decimalCtrl.dispose();
    _footerCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final currency = await SettingsService.getCurrencyCode();
    final locale = await SettingsService.getLocale();
    final digits = await SettingsService.getDecimalDigits();
    final footer = await SettingsService.getReceiptFooter();
    final logo = await SettingsService.getLogoPath();
    final dark = await SettingsService.getDarkModeEnabled();
    setState(() {
      _storeNameCtrl.text = prefs.getString('store_name') ?? 'Basic Store';
      _storeAddressCtrl.text = prefs.getString('store_address') ?? '';
      _storePhoneCtrl.text = prefs.getString('store_phone') ?? '';
      _currencyCtrl.text = currency;
      _localeCtrl.text = locale;
      _decimalCtrl.text = digits.toString();
      _footerCtrl.text = footer;
      _logoPath = logo;
      _darkMode = dark;
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
    await SettingsService.setLocale(_localeCtrl.text.trim());
    await SettingsService.setDecimalDigits(
      int.tryParse(_decimalCtrl.text.trim()) ?? 0,
    );
    await SettingsService.setReceiptFooter(_footerCtrl.text);
    await SettingsService.setLogoPath(_logoPath);
    await SettingsService.setDarkModeEnabled(_darkMode);
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Đã lưu cài đặt')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cài đặt'),
        actions: [
          TextButton(onPressed: _saveSettings, child: const Text('Lưu')),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _storeNameCtrl,
                decoration: const InputDecoration(
                  labelText: 'Tên cửa hàng',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _storeAddressCtrl,
                decoration: const InputDecoration(
                  labelText: 'Địa chỉ',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _storePhoneCtrl,
                decoration: const InputDecoration(
                  labelText: 'Số điện thoại',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _vatCtrl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'VAT %',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _serviceFeeCtrl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Phí DV %',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SwitchListTile(
                value: _darkMode,
                onChanged: (v) async {
                  setState(() => _darkMode = v);
                  await SettingsService.setDarkModeEnabled(v);
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        v ? 'Đã bật Dark Mode' : 'Đã tắt Dark Mode',
                      ),
                    ),
                  );
                },
                title: const Text('Dark mode'),
              ),
              const SizedBox(height: 12),
              SwitchListTile(
                value: _vatInclusive,
                onChanged: (v) => setState(() => _vatInclusive = v),
                title: const Text('Giá đã gồm VAT (vat-inclusive)'),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.file_download),
                      label: const Text('Xuất sao lưu'),
                      onPressed: () async {
                        try {
                          await BackupService.shareBackup();
                        } catch (e) {
                          if (!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Lỗi xuất sao lưu: $e')),
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.file_upload),
                      label: const Text('Nhập sao lưu'),
                      onPressed: () async {
                        final path = await showDialog<String>(
                          context: context,
                          builder: (ctx) {
                            final ctrl = TextEditingController();
                            return AlertDialog(
                              title: const Text(
                                'Nhập đường dẫn file backup (.isar)',
                              ),
                              content: TextField(
                                controller: ctrl,
                                decoration: const InputDecoration(
                                  hintText:
                                      '/storage/emulated/0/Download/basic_store_backup.isar',
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(ctx).pop(),
                                  child: const Text('Hủy'),
                                ),
                                FilledButton(
                                  onPressed: () =>
                                      Navigator.of(ctx).pop(ctrl.text.trim()),
                                  child: const Text('OK'),
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
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('File không tồn tại'),
                              ),
                            );
                            return;
                          }
                          await BackupService.importBackup(file);
                          if (!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Đã nhập sao lưu. Khởi động lại ứng dụng.',
                              ),
                            ),
                          );
                          // Điều hướng về màn hình chính
                          // ignore: use_build_context_synchronously
                          Navigator.of(
                            context,
                          ).pushNamedAndRemoveUntil('/', (r) => false);
                        } catch (e) {
                          if (!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Lỗi nhập sao lưu: $e')),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _currencyCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Mã tiền tệ (VD: VND, USD)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _currentLocale,
                      decoration: const InputDecoration(
                        labelText: 'Ngôn ngữ',
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'vi',
                          child: Text('Tiếng Việt'),
                        ),
                        DropdownMenuItem(value: 'en', child: Text('English')),
                      ],
                      onChanged: (value) async {
                        if (value != null) {
                          setState(() {
                            _currentLocale = value;
                          });
                          await LocaleService.setLocaleCode(value);
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Đã đổi ngôn ngữ. Khởi động lại ứng dụng.',
                                ),
                              ),
                            );
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _decimalCtrl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Số chữ số thập phân',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _footerCtrl,
                      maxLines: 1,
                      decoration: const InputDecoration(
                        labelText: 'Footer hóa đơn',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _logoPath == null || _logoPath!.isEmpty
                          ? 'Chưa chọn logo'
                          : 'Logo: $_logoPath',
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () async {
                      // Placeholder: integrate file picker as needed
                      // For now, clear or set a dummy path
                      setState(() {
                        _logoPath = _logoPath == null
                            ? '/path/to/logo.png'
                            : null;
                      });
                    },
                    child: const Text('Chọn logo'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
