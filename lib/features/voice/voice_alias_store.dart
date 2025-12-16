import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class VoiceAliasStore {
  static const String _productKey = 'voice_alias.product';
  static const String _customerKey = 'voice_alias.customer';

  Map<String, int>? _productCache;
  Map<String, int>? _customerCache;

  Future<int?> getProductId(String normalizedPhrase) async {
    final map = await _loadProductMap();
    return map[normalizedPhrase];
  }

  Future<int?> getCustomerId(String normalizedPhrase) async {
    final map = await _loadCustomerMap();
    return map[normalizedPhrase];
  }

  Future<void> saveProductAlias(String normalizedPhrase, int productId) async {
    final map = await _loadProductMap();
    map[normalizedPhrase] = productId;
    await _persistMap(_productKey, map);
    _productCache = map;
  }

  Future<void> saveCustomerAlias(
    String normalizedPhrase,
    int customerId,
  ) async {
    final map = await _loadCustomerMap();
    map[normalizedPhrase] = customerId;
    await _persistMap(_customerKey, map);
    _customerCache = map;
  }

  Future<void> removeProductAlias(String normalizedPhrase) async {
    final map = await _loadProductMap();
    if (map.remove(normalizedPhrase) == null) return;
    await _persistMap(_productKey, map);
    _productCache = map;
  }

  Future<void> removeCustomerAlias(String normalizedPhrase) async {
    final map = await _loadCustomerMap();
    if (map.remove(normalizedPhrase) == null) return;
    await _persistMap(_customerKey, map);
    _customerCache = map;
  }

  Future<Map<String, int>> _loadProductMap() async {
    return _productCache ??= await _readMap(_productKey);
  }

  Future<Map<String, int>> _loadCustomerMap() async {
    return _customerCache ??= await _readMap(_customerKey);
  }

  Future<Map<String, int>> _readMap(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(key);
    if (raw == null || raw.trim().isEmpty) return <String, int>{};

    try {
      final decoded = jsonDecode(raw);
      if (decoded is! Map) return <String, int>{};

      final out = <String, int>{};
      decoded.forEach((k, v) {
        if (k is String && v is num) out[k] = v.toInt();
      });
      return out;
    } catch (_) {
      return <String, int>{};
    }
  }

  Future<void> _persistMap(String key, Map<String, int> map) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(map);
    await prefs.setString(key, encoded);
  }
}
