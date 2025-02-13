import 'package:hive/hive.dart';
import 'package:mentor_hub/features/favorites/domain/models/favorite_item.dart';

class FavoritesRepository {
  static const String _favoritesBox = 'favoritesBox';

  Future<void> addFavorite(FavoriteItem item) async {
    final box = await Hive.openBox<FavoriteItem>(_favoritesBox);
    if (!box.containsKey(item.id)) {
      await box.put(item.id, item);
    }
  }

  Future<void> removeFavorite(String itemId) async {
    final box = await Hive.openBox<FavoriteItem>(_favoritesBox);
    await box.delete(itemId);
  }

  Future<List<FavoriteItem>> getFavorites() async {
    final box = await Hive.openBox<FavoriteItem>(_favoritesBox);
    return box.values.toList();
  }
}
