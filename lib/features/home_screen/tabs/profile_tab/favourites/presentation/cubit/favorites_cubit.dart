import 'package:flutter_bloc/flutter_bloc.dart';
import 'favorites_state.dart';
import '../../data/repositories/favorites_repository.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoritesRepository repository;

  FavoritesCubit(this.repository) : super(FavoritesInitial());

  Future<void> loadFavorites() async {
    emit(FavoritesLoading());
    try {
      final movies = await repository.getFavorites();
      emit(FavoritesLoaded(movies));
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> toggleFavorite(int movieId) async {
    if (state is! FavoritesLoaded) {
      await loadFavorites();
    }

    final loaded = state as FavoritesLoaded;
    final exists = loaded.movies.any((m) => m.id == movieId);

    try {
      if (exists) {
        await repository.removeFavorite(movieId);
      } else {
        await repository.addFavorite(movieId);
      }

      await loadFavorites();
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }
}
