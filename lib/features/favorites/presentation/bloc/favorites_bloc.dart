import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentor_hub/features/favorites/data/repository/favorites_repository.dart';
import 'favorites_event.dart';
import 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FavoritesRepository _repository = FavoritesRepository();

  FavoritesBloc() : super(FavoritesState(favorites: [])) {
    _loadFavorites();

    on<AddFavorite>((event, emit) async {
      await _repository.addFavorite(event.item);
      _loadFavorites();
    });

    on<RemoveFavorite>((event, emit) async {
      await _repository.removeFavorite(event.itemId);
      _loadFavorites();
    });
  }

  Future<void> _loadFavorites() async {
    final favorites = await _repository.getFavorites();
    emit(FavoritesState(favorites: favorites));
  }
}
