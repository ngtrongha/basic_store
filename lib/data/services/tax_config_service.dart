import 'package:shared_preferences/shared_preferences.dart';

class TaxConfigService {
  static const String _vatRateKey = 'vat_rate_percent';
  static const String _vatInclusiveKey = 'vat_inclusive';
  static const String _serviceFeeKey = 'service_fee_percent';

  static Future<double> getVatRatePercent() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_vatRateKey) ?? 0;
  }

  static Future<void> setVatRatePercent(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_vatRateKey, value);
  }

  static Future<bool> isVatInclusive() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_vatInclusiveKey) ?? true;
  }

  static Future<void> setVatInclusive(bool inclusive) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_vatInclusiveKey, inclusive);
  }

  static Future<double> getServiceFeePercent() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_serviceFeeKey) ?? 0;
  }

  static Future<void> setServiceFeePercent(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_serviceFeeKey, value);
  }
}
