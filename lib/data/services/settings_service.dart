import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  static const String _storeNameKey = 'store_name';
  static const String _storeAddressKey = 'store_address';
  static const String _storePhoneKey = 'store_phone';
  static const String _currencyCodeKey = 'currency_code';
  static const String _localeKey = 'app_locale';
  static const String _decimalDigitsKey = 'decimal_digits';
  static const String _receiptFooterKey = 'receipt_footer';
  static const String _logoPathKey = 'store_logo_path';
  static const String _darkModeKey = 'dark_mode_enabled';

  static Future<String> getStoreName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_storeNameKey) ?? 'Basic Store';
  }

  static Future<String> getStoreAddress() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_storeAddressKey) ?? '';
  }

  static Future<String> getStorePhone() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_storePhoneKey) ?? '';
  }

  static Future<void> setStoreName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storeNameKey, name);
  }

  static Future<void> setStoreAddress(String address) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storeAddressKey, address);
  }

  static Future<void> setStorePhone(String phone) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storePhoneKey, phone);
  }

  static Future<String> getCurrencyCode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_currencyCodeKey) ?? 'VND';
  }

  static Future<void> setCurrencyCode(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_currencyCodeKey, code);
  }

  static Future<String> getLocale() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_localeKey) ?? 'vi_VN';
  }

  static Future<void> setLocale(String locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localeKey, locale);
  }

  static Future<int> getDecimalDigits() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_decimalDigitsKey) ?? 0;
  }

  static Future<void> setDecimalDigits(int digits) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_decimalDigitsKey, digits);
  }

  static Future<String> getReceiptFooter() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_receiptFooterKey) ?? '';
  }

  static Future<void> setReceiptFooter(String footer) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_receiptFooterKey, footer);
  }

  static Future<String?> getLogoPath() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_logoPathKey);
  }

  static Future<void> setLogoPath(String? path) async {
    final prefs = await SharedPreferences.getInstance();
    if (path == null || path.isEmpty) {
      await prefs.remove(_logoPathKey);
    } else {
      await prefs.setString(_logoPathKey, path);
    }
  }

  static Future<bool> getDarkModeEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_darkModeKey) ?? false;
  }

  static Future<void> setDarkModeEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_darkModeKey, enabled);
  }
}
