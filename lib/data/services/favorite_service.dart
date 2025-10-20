import 'package:shared_preferences/shared_preferences.dart';

class FavoriteService {
  static const _favoriteProductIdsKey = 'favorite_product_ids';

  static Future<Set<int>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_favoriteProductIdsKey) ?? <String>[];
    return list.map(int.parse).toSet();
  }

  static Future<List<int>> getFavoriteProductIds() async {
    final favorites = await getFavorites();
    return favorites.toList();
  }

  static Future<void> toggleFavorite(int productId) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_favoriteProductIdsKey) ?? <String>[];
    final set = list.map(int.parse).toSet();
    if (set.contains(productId)) {
      set.remove(productId);
    } else {
      set.add(productId);
    }
    await prefs.setStringList(
      _favoriteProductIdsKey,
      set.map((e) => e.toString()).toList(),
    );
  }
}
