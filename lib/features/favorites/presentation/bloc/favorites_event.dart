import 'package:mentor_hub/features/favorites/domain/models/favorite_item.dart';

abstract class FavoritesEvent {}

class AddFavorite extends FavoritesEvent {
  final FavoriteItem item;
  AddFavorite(this.item);
}

class RemoveFavorite extends FavoritesEvent {
  final String itemId;
  RemoveFavorite(this.itemId);
}
