import 'package:shared_preferences/shared_preferences.dart';

class RecentService {
  static const _recentSkusKey = 'recent_skus';

  static Future<List<String>> getRecentSkus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_recentSkusKey) ?? <String>[];
  }

  static Future<void> pushRecentSku(String sku, {int maxItems = 10}) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_recentSkusKey) ?? <String>[];
    list.removeWhere((s) => s.toLowerCase() == sku.toLowerCase());
    list.insert(0, sku);
    if (list.length > maxItems) {
      list.removeRange(maxItems, list.length);
    }
    await prefs.setStringList(_recentSkusKey, list);
  }
}
