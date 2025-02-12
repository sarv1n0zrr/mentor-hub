import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentor_hub/features/favorites/data/repository/favorites_repository.dart';

import 'favorites_event.dart';
import 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final _repository = FavoritesRepository();

  FavoritesBloc() : super(FavoritesState(favorites: [])) {
    on<AddFavorite>((event, emit) {
      _repository.addFavorite(event.item);
      emit(FavoritesState(favorites: _repository.getFavorites()));
    });

    on<RemoveFavorite>((event, emit) {
      _repository.removeFavorite(event.itemId);
      emit(FavoritesState(favorites: _repository.getFavorites()));
    });
  }
}
