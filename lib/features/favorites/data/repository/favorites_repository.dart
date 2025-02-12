import 'package:mentor_hub/features/favorites/domain/models/favorite_item.dart';

class FavoritesRepository {
  final List<FavoriteItem> _favorites = [];

  List<FavoriteItem> getFavorites() => _favorites;

  void addFavorite(FavoriteItem item) {
    if (!_favorites.any((element) => element.id == item.id)) {
      _favorites.add(item);
    }
  }

  void removeFavorite(String itemId) {
    _favorites.removeWhere((item) => item.id == itemId);
  }
}
